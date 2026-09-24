// lib/models/onboarding_state.dart

enum UserRole {
  artisan,
  buyer,
  none,
}

class OnboardingState {
  final UserRole selectedRole;
  final String selectedLanguage;
  final String artisanName;
  final String phoneNumber;
  final String email;
  final String password;
  final String artisanLocation;
  final List<String> selectedCraftIds;
  final String selectedCraft;
  final String voiceTranscript;
  String get voiceStoryTranscript => voiceTranscript;
  final String voiceDuration;
  final bool hasRecordedVoice;
  final bool hasProfilePhoto;
  final String profilePhotoPath;
  final String profilePhotoUrl;
  final String experienceYears;
  final bool bulkProductionReady;
  final bool isProfileComplete;
  final bool isEmailVerified;

  const OnboardingState({
    this.selectedRole = UserRole.none,
    this.selectedLanguage = 'English',
    this.artisanName = 'Ramu Kumar',
    this.phoneNumber = '+91 98765 43210',
    this.email = 'ramukumar@hunarsangam.in',
    this.password = '',
    this.artisanLocation = 'Barabanki, Uttar Pradesh',
    this.selectedCraftIds = const ['bamboo_cane'],
    this.selectedCraft = 'Bamboo & Cane',
    this.voiceTranscript = 'Master artisan in bamboo weaving and heritage crafts.',
    this.voiceDuration = '0:18',
    this.hasRecordedVoice = false,
    this.hasProfilePhoto = false,
    this.profilePhotoPath = '',
    this.profilePhotoUrl = 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80',
    this.experienceYears = '10+ Years',
    this.bulkProductionReady = true,
    this.isProfileComplete = true,
    this.isEmailVerified = false,
  });

  OnboardingState copyWith({
    UserRole? selectedRole,
    String? selectedLanguage,
    String? artisanName,
    String? phoneNumber,
    String? email,
    String? password,
    String? artisanLocation,
    List<String>? selectedCraftIds,
    String? selectedCraft,
    String? voiceTranscript,
    String? voiceStoryTranscript,
    String? voiceDuration,
    bool? hasRecordedVoice,
    bool? hasProfilePhoto,
    String? profilePhotoPath,
    String? profilePhotoUrl,
    String? experienceYears,
    bool? bulkProductionReady,
    bool? isProfileComplete,
    bool? isEmailVerified,
  }) {
    return OnboardingState(
      selectedRole: selectedRole ?? this.selectedRole,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      artisanName: artisanName ?? this.artisanName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      password: password ?? this.password,
      artisanLocation: artisanLocation ?? this.artisanLocation,
      selectedCraftIds: selectedCraftIds ?? this.selectedCraftIds,
      selectedCraft: selectedCraft ?? this.selectedCraft,
      voiceTranscript: voiceStoryTranscript ?? voiceTranscript ?? this.voiceTranscript,
      voiceDuration: voiceDuration ?? this.voiceDuration,
      hasRecordedVoice: hasRecordedVoice ?? this.hasRecordedVoice,
      hasProfilePhoto: hasProfilePhoto ?? this.hasProfilePhoto,
      profilePhotoPath: profilePhotoPath ?? this.profilePhotoPath,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      experienceYears: experienceYears ?? this.experienceYears,
      bulkProductionReady: bulkProductionReady ?? this.bulkProductionReady,
      isProfileComplete: isProfileComplete ?? this.isProfileComplete,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }
}
