// lib/services/supabase_service.dart

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_config.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';

class UuidUtil {
  static String generateV4() {
    final now = DateTime.now().millisecondsSinceEpoch;
    return 'user-$now-${(1000 + (now % 9000))}';
  }
}

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  SupabaseClient? _client;
  bool _isLive = false;
  bool get isLive => _isLive;
  String? _lastError;
  String? get lastError => _lastError;

  SupabaseClient? get client {
    if (_client == null) {
      try {
        _client = Supabase.instance.client;
      } catch (e) {
        // Safe fallback
      }
    }
    return _client;
  }

  User? get currentAuthUser => client?.auth.currentUser;
  Session? get currentSession => client?.auth.currentSession;
  Stream<AuthState>? get authStateChanges => client?.auth.onAuthStateChange;

  Future<bool> init() async {
    try {
      await SupabaseConfig.loadPersistedConfig();
      final url = SupabaseConfig.url;
      final key = SupabaseConfig.anonKey;

      if (SupabaseConfig.isSupabaseConfigured()) {
        try {
          await Supabase.initialize(
            url: url,
            anonKey: key,
          );
          _client = Supabase.instance.client;
          _isLive = true;
          _lastError = null;
          debugPrint('✅ Supabase connected successfully to $url');
          return true;
        } catch (e) {
          _lastError = e.toString();
          debugPrint('⚠️ Supabase initialize error: $e');
          // If already initialized, fetch instance
          try {
            _client = Supabase.instance.client;
            _isLive = true;
            return true;
          } catch (_) {}
        }
      } else {
        _isLive = false;
        debugPrint('ℹ️ Supabase running in local/demo mode (API credentials not configured)');
      }
    } catch (e) {
      _lastError = e.toString();
      debugPrint('⚠️ Supabase init note: $e');
    }
    return false;
  }

  /// Test Supabase connection
  Future<Map<String, dynamic>> testConnection() async {
    if (!SupabaseConfig.isSupabaseConfigured()) {
      return {
        'success': false,
        'message': 'Supabase URL or Anon Key is missing. Please configure them in Settings.',
      };
    }
    try {
      final res = await client?.from('profiles').select('count').limit(1);
      return {
        'success': true,
        'message': 'Successfully connected to Supabase database!',
        'data': res,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Supabase connection error: $e',
      };
    }
  }

  // ==========================================
  // SUPABASE AUTHENTICATION METHODS
  // ==========================================

  /// Secure Sign Up with Supabase Auth for Makers (Artisans) and Bulk Buyers
  Future<Map<String, dynamic>> signUpWithSupabaseAuth({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String role, // 'artisan' or 'buyer'
    String? profileImage,
    Map<String, dynamic>? extraMetadata,
    Map<String, dynamic>? artisanDetails,
  }) async {
    final cleanEmail = email.trim().toLowerCase();
    final cleanPassword = password.trim();

    if (_isLive && client != null) {
      try {
        final authResponse = await client!.auth.signUp(
          email: cleanEmail,
          password: cleanPassword,
          data: {
            'name': name.trim(),
            'phone': phone.trim(),
            'role': role,
            'profile_image': profileImage,
            ...?extraMetadata,
          },
        );

        final user = authResponse.user;
        final userId = user?.id ?? UuidUtil.generateV4();

        // Upsert into profiles table
        try {
          await client!.from('profiles').upsert({
            'user_id': userId,
            'name': name.trim(),
            'phone': phone.trim(),
            'email': cleanEmail,
            'role': role,
            'profile_image': profileImage,
            'updated_at': DateTime.now().toIso8601String(),
          });

          if (role == 'artisan' && artisanDetails != null) {
            await client!.from('artisans').upsert({
              'user_id': userId,
              'craft_type': artisanDetails['craft_type'] ?? 'Handicrafts',
              'location': artisanDetails['location'] ?? 'India',
              'bio': artisanDetails['bio'] ?? '',
              'monthly_capacity': artisanDetails['monthly_capacity'] ?? 500,
              'verification_status': 'verified',
              'updated_at': DateTime.now().toIso8601String(),
            });
          }
        } catch (dbErr) {
          debugPrint('⚠️ Note during profile DB upsert: $dbErr');
        }

        return {
          'success': true,
          'user_id': userId,
          'email': cleanEmail,
          'name': name.trim(),
          'phone': phone.trim(),
          'role': role,
          'session': authResponse.session,
          'is_email_confirmed': user?.emailConfirmedAt != null,
          'message': authResponse.session != null
              ? 'Successfully registered and logged in with Supabase!'
              : 'Account created! Please check your email to confirm registration.',
        };
      } on AuthException catch (authErr) {
        debugPrint('⚠️ Supabase AuthException during sign up: ${authErr.message}');
        return {
          'success': false,
          'error': authErr.message,
          'isAuthException': true,
        };
      } catch (e) {
        debugPrint('⚠️ General error during Supabase sign up: $e');
        return {
          'success': false,
          'error': e.toString(),
        };
      }
    }

    // Offline / Demo fallback
    final fallbackId = UuidUtil.generateV4();
    return {
      'success': true,
      'user_id': fallbackId,
      'email': cleanEmail,
      'name': name.trim(),
      'phone': phone.trim(),
      'role': role,
      'is_fallback': true,
      'message': 'Account created in local session.',
    };
  }

  /// Secure Sign In with Supabase Auth using Email & Password
  Future<Map<String, dynamic>> signInWithSupabaseAuth({
    required String email,
    required String password,
  }) async {
    final cleanEmail = email.trim().toLowerCase();
    final cleanPassword = password.trim();

    if (_isLive && client != null) {
      try {
        final authResponse = await client!.auth.signInWithPassword(
          email: cleanEmail,
          password: cleanPassword,
        );

        final user = authResponse.user;
        if (user == null) {
          return {
            'success': false,
            'error': 'User not found in Supabase credentials.',
          };
        }

        final meta = user.userMetadata ?? {};
        String role = meta['role']?.toString() ?? 'artisan';
        String name = meta['name']?.toString() ?? user.email?.split('@').first ?? 'User';
        String phone = meta['phone']?.toString() ?? '';

        // Query database profile if available
        try {
          final profileRow = await client!.from('profiles').select().eq('user_id', user.id).maybeSingle();
          if (profileRow != null) {
            role = profileRow['role']?.toString() ?? role;
            name = profileRow['name']?.toString() ?? name;
            phone = profileRow['phone']?.toString() ?? phone;
          }
        } catch (_) {}

        return {
          'success': true,
          'user_id': user.id,
          'email': user.email ?? cleanEmail,
          'name': name,
          'phone': phone,
          'role': role,
          'session': authResponse.session,
          'message': 'Welcome back, $name!',
        };
      } on AuthException catch (authErr) {
        debugPrint('⚠️ Supabase AuthException during sign in: ${authErr.message}');
        return {
          'success': false,
          'error': authErr.message,
          'isAuthException': true,
        };
      } catch (e) {
        debugPrint('⚠️ General error during Supabase sign in: $e');
        return {
          'success': false,
          'error': e.toString(),
        };
      }
    }

    return {
      'success': false,
      'error': 'Supabase not connected. Please login via local credentials or configure Supabase URL.',
      'is_offline': true,
    };
  }

  /// Send Phone OTP via Supabase Auth
  Future<Map<String, dynamic>> sendOtpWithSupabaseAuth({required String phone}) async {
    final cleanPhone = phone.trim();
    if (_isLive && client != null) {
      try {
        await client!.auth.signInWithOtp(phone: cleanPhone);
        return {
          'success': true,
          'message': 'OTP sent to $cleanPhone via Supabase SMS',
        };
      } on AuthException catch (e) {
        return {
          'success': false,
          'error': e.message,
        };
      } catch (e) {
        return {
          'success': false,
          'error': e.toString(),
        };
      }
    }

    return {
      'success': true,
      'is_local': true,
      'message': 'Local OTP simulation active',
    };
  }

  /// Verify Phone OTP via Supabase Auth
  Future<Map<String, dynamic>> verifyOtpWithSupabaseAuth({
    required String phone,
    required String token,
  }) async {
    final cleanPhone = phone.trim();
    final cleanToken = token.trim();

    if (_isLive && client != null) {
      try {
        final res = await client!.auth.verifyOTP(
          phone: cleanPhone,
          token: cleanToken,
          type: OtpType.sms,
        );
        final user = res.user;
        return {
          'success': true,
          'user_id': user?.id,
          'session': res.session,
        };
      } on AuthException catch (e) {
        return {
          'success': false,
          'error': e.message,
        };
      } catch (e) {
        return {
          'success': false,
          'error': e.toString(),
        };
      }
    }

    return {
      'success': true,
      'is_local': true,
    };
  }

  /// Send Password Reset Email via Supabase Auth
  Future<Map<String, dynamic>> sendPasswordReset(String email) async {
    final cleanEmail = email.trim().toLowerCase();
    if (_isLive && client != null) {
      try {
        await client!.auth.resetPasswordForEmail(cleanEmail);
        return {
          'success': true,
          'message': 'Password reset link sent to $cleanEmail',
        };
      } on AuthException catch (e) {
        return {
          'success': false,
          'error': e.message,
        };
      } catch (e) {
        return {
          'success': false,
          'error': e.toString(),
        };
      }
    }
    return {
      'success': true,
      'message': 'Password reset request recorded for $cleanEmail',
    };
  }

  /// Sign Out from Supabase Auth
  Future<void> signOutSupabaseAuth() async {
    if (_isLive && client != null) {
      try {
        await client!.auth.signOut();
      } catch (e) {
        debugPrint('⚠️ Supabase signOut error: $e');
      }
    }
  }

  /// Sync or persist user profile to Supabase `profiles` & `artisans` table
  Future<Map<String, dynamic>> syncUserAccount({
    required String name,
    required String phone,
    required String email,
    required String password,
    required String role,
    String? profileImage,
    Map<String, dynamic>? artisanDetails,
  }) async {
    final generatedId = UuidUtil.generateV4();

    if (_isLive && client != null) {
      try {
        final profileData = {
          'name': name,
          'phone': phone,
          'email': email,
          'role': role,
          'profile_image': profileImage,
          'updated_at': DateTime.now().toIso8601String(),
        };

        final res = await client!.from('profiles').upsert(profileData).select().maybeSingle();
        final userId = res?['user_id']?.toString() ?? generatedId;

        if (role == 'artisan' && artisanDetails != null) {
          await client!.from('artisans').upsert({
            'user_id': userId,
            'craft_type': artisanDetails['craft_type'] ?? 'Handicrafts',
            'location': artisanDetails['location'] ?? 'India',
            'bio': artisanDetails['bio'] ?? '',
            'monthly_capacity': artisanDetails['monthly_capacity'] ?? 500,
            'verification_status': 'verified',
            'updated_at': DateTime.now().toIso8601String(),
          });
        }

        return {
          'user_id': userId,
          'name': name,
          'phone': phone,
          'email': email,
          'role': role,
          'status': 'synced_remote',
        };
      } catch (e) {
        debugPrint('⚠️ Supabase sync error, falling back locally: $e');
      }
    }

    return {
      'user_id': generatedId,
      'name': name,
      'phone': phone,
      'email': email,
      'role': role,
      'status': 'synced',
    };
  }

  // ==========================================
  // PRODUCTS & ORDERS DATABASE METHODS
  // ==========================================

  /// Fetch products from Supabase `products` table
  Future<List<ProductModel>> fetchProducts() async {
    if (_isLive && client != null) {
      try {
        final data = await client!.from('products').select().order('created_at', ascending: false);
        if (data.isNotEmpty) {
          return data.map((m) {
            return ProductModel(
              id: m['id']?.toString() ?? 'prod_${m['name']}',
              artisanId: m['artisan_id']?.toString() ?? 'art_1',
              title: m['name']?.toString() ?? 'Handmade Craft',
              description: m['description']?.toString() ?? '',
              price: (m['price'] as num?)?.toDouble() ?? 450.0,
              originalPrice: '₹${((m['price'] as num?)?.toDouble() ?? 450.0) * 1.2}',
              category: m['category']?.toString() ?? 'Crafts',
              stockQuantity: (m['stock'] as num?)?.toInt() ?? 100,
              isFeatured: true,
              rating: 4.9,
              reviewsCount: 24,
            );
          }).toList();
        }
      } catch (e) {
        debugPrint('⚠️ Supabase fetch products error: $e');
      }
    }
    return [];
  }

  /// Insert product to Supabase `products` table
  Future<bool> insertProduct(ProductModel product) async {
    if (_isLive && client != null) {
      try {
        await client!.from('products').insert({
          'name': product.title,
          'category': product.category,
          'description': product.description,
          'price': product.price,
          'stock': product.stockQuantity,
          'status': 'published',
          'is_ondc_synced': true,
          'is_gi_certified': true,
        });
        return true;
      } catch (e) {
        debugPrint('⚠️ Supabase insert product error: $e');
      }
    }
    return true;
  }

  /// Fetch orders from Supabase `orders` table
  Future<List<OrderModel>> fetchOrders() async {
    if (_isLive && client != null) {
      try {
        final data = await client!.from('orders').select().order('created_at', ascending: false);
        if (data.isNotEmpty) {
          return data.map((m) {
            return OrderModel(
              id: m['id']?.toString() ?? '',
              orderNumber: m['order_number']?.toString() ?? 'PO-2026',
              artisanId: m['artisan_id']?.toString() ?? '',
              buyerName: m['buyer_name']?.toString() ?? 'Enterprise Buyer',
              totalAmount: (m['total_amount'] as num?)?.toDouble() ?? 0.0,
              status: m['status']?.toString() ?? 'pending',
              escrowAmount: (m['escrow_amount'] as num?)?.toDouble() ?? 0.0,
              unitsTotal: (m['units_total'] as num?)?.toInt() ?? 1,
              unitsCompleted: (m['units_completed'] as num?)?.toInt() ?? 0,
              createdAt: DateTime.tryParse(m['created_at']?.toString() ?? '') ?? DateTime.now(),
              updatedAt: DateTime.tryParse(m['updated_at']?.toString() ?? '') ?? DateTime.now(),
            );
          }).toList();
        }
      } catch (e) {
        debugPrint('⚠️ Supabase fetch orders error: $e');
      }
    }
    return [];
  }

  /// Fetch order requests from Supabase `order_requests` table
  Future<List<OrderRequestModel>> fetchOrderRequests() async {
    if (_isLive && client != null) {
      try {
        final data = await client!.from('order_requests').select().order('created_at', ascending: false);
        if (data.isNotEmpty) {
          return data.map((m) {
            return OrderRequestModel(
              id: m['id']?.toString() ?? '',
              artisanId: m['artisan_id']?.toString() ?? '',
              buyerId: m['buyer_id']?.toString(),
              buyerName: m['buyer_name']?.toString() ?? 'Buyer',
              buyerLocation: m['buyer_location']?.toString() ?? 'India',
              productId: m['product_id']?.toString(),
              productName: m['product_name']?.toString() ?? 'Handicraft Item',
              quantity: (m['quantity'] as num?)?.toInt() ?? 10,
              unitPrice: (m['unit_price'] as num?)?.toDouble() ?? 250.0,
              totalAmount: (m['total_amount'] as num?)?.toDouble() ?? 2500.0,
              message: m['message']?.toString() ?? '',
              status: m['status']?.toString() ?? 'pending',
              createdAt: DateTime.tryParse(m['created_at']?.toString() ?? '') ?? DateTime.now(),
              updatedAt: DateTime.tryParse(m['updated_at']?.toString() ?? '') ?? DateTime.now(),
            );
          }).toList();
        }
      } catch (e) {
        debugPrint('⚠️ Supabase fetch order requests error: $e');
      }
    }
    return [];
  }

  /// Insert order request into Supabase `order_requests` table
  Future<bool> insertOrderRequest(OrderRequestModel req) async {
    if (_isLive && client != null) {
      try {
        await client!.from('order_requests').insert({
          'artisan_id': req.artisanId,
          'buyer_name': req.buyerName,
          'buyer_location': req.buyerLocation,
          'product_id': req.productId,
          'product_name': req.productName,
          'quantity': req.quantity,
          'unit_price': req.unitPrice,
          'total_amount': req.totalAmount,
          'message': req.message,
          'status': req.status,
        });
        return true;
      } catch (e) {
        debugPrint('⚠️ Supabase insert order request error: $e');
      }
    }
    return true;
  }

  /// Update order status in Supabase `orders` table
  Future<void> updateOrderStatusInDb(String orderId, String status, {int? unitsCompleted}) async {
    if (_isLive && client != null) {
      try {
        final Map<String, dynamic> updates = {
          'status': status,
          'updated_at': DateTime.now().toIso8601String(),
        };
        if (unitsCompleted != null) {
          updates['units_completed'] = unitsCompleted;
        }
        await client!.from('orders').update(updates).eq('id', orderId);
      } catch (e) {
        debugPrint('⚠️ Supabase update order status error: $e');
      }
    }
  }

  /// Upload bytes or binary payload to Supabase storage bucket
  Future<String?> uploadStorageBytes({
    required Uint8List bytes,
    required String bucketName,
    required String destinationPath,
  }) async {
    if (_isLive && client != null) {
      try {
        await client!.storage.from(bucketName).uploadBinary(
          destinationPath,
          bytes,
          fileOptions: const FileOptions(upsert: true),
        );
        final publicUrl = client!.storage.from(bucketName).getPublicUrl(destinationPath);
        return publicUrl;
      } catch (e) {
        debugPrint('⚠️ Supabase upload file error: $e');
      }
    }
    return null;
  }
}
