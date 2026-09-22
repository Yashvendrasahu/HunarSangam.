// lib/services/supabase_config.dart

class SupabaseConfig {
  static const String url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://demo-placeholder.supabase.co',
  );

  static const String anonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'demo-anon-key-placeholder',
  );

  static const String geminiApiKey = String.fromEnvironment(
    'GEMINI_API_KEY',
    defaultValue: '',
  );

  static const String bucketArtisanProfiles = 'artisan_profiles';
  static const String bucketProductionPhotos = 'production_photos';
  static const String bucketVerificationPhotos = 'verification_photos';
  static const String bucketProductImages = 'product_images';
}
