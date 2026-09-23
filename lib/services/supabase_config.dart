// lib/services/supabase_config.dart

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupabaseConfig {
  static const String _defaultUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://demo-placeholder.supabase.co',
  );

  static const String _defaultAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'demo-anon-key-placeholder',
  );

  static const String _defaultGeminiApiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: '',
  );

  static String _currentUrl = _defaultUrl;
  static String _currentAnonKey = _defaultAnonKey;
  static String _currentGeminiApiKey = _defaultGeminiApiKey;

  static String get url => _currentUrl.trim().isNotEmpty ? _currentUrl.trim() : _defaultUrl;
  static String get anonKey => _currentAnonKey.trim().isNotEmpty ? _currentAnonKey.trim() : _defaultAnonKey;
  static String get geminiApiKey => _currentGeminiApiKey.trim().isNotEmpty ? _currentGeminiApiKey.trim() : _defaultGeminiApiKey;

  static const String bucketArtisanProfiles = 'artisan_profiles';
  static const String bucketProductionPhotos = 'production_photos';
  static const String bucketVerificationPhotos = 'verification_photos';
  static const String bucketProductImages = 'product_images';

  /// Load persisted credentials from local device storage
  static Future<void> loadPersistedConfig() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedUrl = prefs.getString('supabase_url');
      final savedAnonKey = prefs.getString('supabase_anon_key');
      final savedGeminiKey = prefs.getString('gemini_api_key');

      if (savedUrl != null && savedUrl.trim().isNotEmpty) {
        _currentUrl = savedUrl.trim();
      } else if (_defaultUrl.isNotEmpty && !_defaultUrl.contains('demo-placeholder')) {
        _currentUrl = _defaultUrl;
      }

      if (savedAnonKey != null && savedAnonKey.trim().isNotEmpty) {
        _currentAnonKey = savedAnonKey.trim();
      } else if (_defaultAnonKey.isNotEmpty && !_defaultAnonKey.contains('placeholder')) {
        _currentAnonKey = _defaultAnonKey;
      }

      if (savedGeminiKey != null && savedGeminiKey.trim().isNotEmpty) {
        _currentGeminiApiKey = savedGeminiKey.trim();
      } else if (_defaultGeminiApiKey.isNotEmpty) {
        _currentGeminiApiKey = _defaultGeminiApiKey;
      }

      debugPrint('[SupabaseConfig] Config loaded. Supabase configured: ${isSupabaseConfigured()}, Gemini configured: ${isGeminiConfigured()}');
    } catch (e) {
      debugPrint('[SupabaseConfig] Failed to load persisted config: $e');
    }
  }

  /// Save new credentials to persistent device storage
  static Future<void> saveCredentials({
    required String url,
    required String anonKey,
    required String geminiApiKey,
  }) async {
    _currentUrl = url.trim();
    _currentAnonKey = anonKey.trim();
    _currentGeminiApiKey = geminiApiKey.trim();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('supabase_url', _currentUrl);
      await prefs.setString('supabase_anon_key', _currentAnonKey);
      await prefs.setString('gemini_api_key', _currentGeminiApiKey);
      debugPrint('[SupabaseConfig] Credentials saved to SharedPreferences');
    } catch (e) {
      debugPrint('[SupabaseConfig] Failed to persist credentials: $e');
    }
  }

  static bool isSupabaseConfigured() {
    final u = url;
    final k = anonKey;
    return u.isNotEmpty &&
        !u.contains('demo-placeholder') &&
        u.startsWith('http') &&
        k.isNotEmpty &&
        !k.contains('placeholder');
  }

  static bool isGeminiConfigured() {
    return geminiApiKey.isNotEmpty && geminiApiKey.length >= 10;
  }
}
