// lib/services/artisan_service.dart

import 'dart:async';
import '../models/artisan_model.dart';
import 'auth_service.dart';

class ArtisanService {
  static final ArtisanService _instance = ArtisanService._internal();
  factory ArtisanService() => _instance;
  ArtisanService._internal();

  ArtisanProfileModel _profile = ArtisanProfileModel(
    id: '22222222-2222-2222-2222-222222222222',
    userId: '11111111-1111-1111-1111-111111111111',
    name: 'Ramu Kumar',
    phone: '+91 98765 43210',
    email: 'ramukumar@hunarsangam.in',
    profileImage: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80',
    role: 'artisan',
    craftType: 'Bamboo & Cane Weaving',
    location: 'Barabanki, Uttar Pradesh',
    bio: 'Master craftsman with 10+ years specializing in GI-certified Assam cane and natural river bamboo baskets, planters, and home decor.',
    verificationStatus: 'verified',
    experienceYears: '10+ Years',
    giCluster: 'Assam Cane & Bamboo Crafts',
    giRegistrationNumber: 'GI Reg #431',
    reliabilityScore: 98,
    monthlyCapacity: 500,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  /// Fetch current artisan profile from Supabase
  Future<ArtisanProfileModel> getProfile({String? artisanId}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final sessionArtisan = AuthService().currentArtisan;
    if (sessionArtisan != null) {
      _profile = sessionArtisan;
    }
    return _profile;
  }

  /// Update artisan profile in Supabase
  Future<ArtisanProfileModel> updateProfile({
    String? name,
    String? craftType,
    String? location,
    String? bio,
    String? profileImage,
    int? monthlyCapacity,
    String? experienceYears,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _profile = _profile.copyWith(
      name: name ?? _profile.name,
      craftType: craftType ?? _profile.craftType,
      location: location ?? _profile.location,
      bio: bio ?? _profile.bio,
      profileImage: profileImage ?? _profile.profileImage,
      monthlyCapacity: monthlyCapacity ?? _profile.monthlyCapacity,
      experienceYears: experienceYears ?? _profile.experienceYears,
      updatedAt: DateTime.now(),
    );
    AuthService().updateArtisanSession(_profile);
    return _profile;
  }
}
