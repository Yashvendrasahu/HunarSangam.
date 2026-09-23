// lib/utils/input_validators.dart

class InputValidators {
  /// Validate Name (letters and spaces only, min 2 chars)
  static String? validateName(String? value, {String fieldName = 'Name'}) {
    if (value == null || value.trim().isEmpty) {
      return '❌ Please enter $fieldName / कृपया $fieldName दर्ज करें';
    }
    final clean = value.trim();
    if (clean.length < 2) {
      return '❌ $fieldName must be at least 2 characters / कम से कम 2 अक्षर आवश्यक हैं';
    }
    // Only letters (including Unicode script for Hindi/Indian languages), spaces, dots, hyphens
    final nameRegex = RegExp(r"^[\p{L}\s\.\-']+$", unicode: true);
    if (!nameRegex.hasMatch(clean)) {
      return '❌ $fieldName should contain only letters (no numbers/symbols) / केवल अक्षर लिखें';
    }
    return null;
  }

  /// Validate Business or Organization Name (min 2 chars, letters, numbers, spaces, common punctuation)
  static String? validateBusinessName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '❌ Please enter Business Name / कृपया व्यापार का नाम दर्ज करें';
    }
    final clean = value.trim();
    if (clean.length < 2) {
      return '❌ Business name must be at least 2 characters / कम से कम 2 अक्षर होने चाहिए';
    }
    return null;
  }

  /// Validate Mobile Phone Number (10 digits)
  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '❌ Please enter phone number / कृपया फ़ोन नंबर दर्ज करें';
    }
    // Extract only digits
    final digits = value.replaceAll(RegExp(r'\D'), '');
    // If it starts with 91 and has 12 digits, consider the 10 digits
    final actualDigits = (digits.startsWith('91') && digits.length == 12) ? digits.substring(2) : digits;

    if (actualDigits.length < 10) {
      return '❌ Please enter a valid 10-digit mobile number / 10 अंकों का नंबर दर्ज करें';
    }
    if (actualDigits.length > 11) {
      return '❌ Phone number exceeds 10 digits / फ़ोन नंबर 10 अंकों से अधिक है';
    }
    return null;
  }

  /// Validate Email Address
  static String? validateEmail(String? value, {bool required = true}) {
    if (value == null || value.trim().isEmpty) {
      return required ? '❌ Please enter email address / कृपया ईमेल दर्ज करें' : null;
    }
    final clean = value.trim();
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(clean)) {
      return '❌ Please enter a valid email (e.g. name@example.com) / मान्य ईमेल दर्ज करें';
    }
    return null;
  }

  /// Validate Contact (can be valid Email or 10-digit Phone)
  static String? validateContact(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '❌ Please enter email or phone number / ईमेल या फ़ोन नंबर दर्ज करें';
    }
    final clean = value.trim();
    if (clean.contains('@')) {
      return validateEmail(clean, required: true);
    } else {
      return validatePhone(clean);
    }
  }

  /// Validate Password / PIN (min 6 characters)
  static String? validatePassword(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return '❌ Please enter your password / कृपया पासवर्ड दर्ज करें';
    }
    if (value.length < minLength) {
      return '❌ Password must be at least $minLength characters / पासवर्ड कम से कम $minLength अक्षरों का होना चाहिए';
    }
    return null;
  }

  /// Validate 6-digit OTP
  static String? validateOtp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return '❌ Please enter the OTP code / कृपया ओटीपी कोड दर्ज करें';
    }
    final clean = value.replaceAll(RegExp(r'\D'), '');
    if (clean.length < 4 || clean.length > 6) {
      return '❌ Please enter a valid 6-digit OTP / 6 अंकों का ओटीपी कोड दर्ज करें';
    }
    return null;
  }

  /// Validate Positive Number / Price / Quantity
  static String? validatePositiveNumber(
    String? value, {
    String fieldName = 'Amount',
    double min = 1.0,
    double? max,
    bool allowDecimals = true,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '❌ Please enter $fieldName / कृपया $fieldName दर्ज करें';
    }
    final clean = value.trim().replaceAll(',', '');
    final numVal = double.tryParse(clean);
    if (numVal == null) {
      return '❌ $fieldName must be a valid number (digits only) / केवल संख्या दर्ज करें';
    }
    if (numVal < min) {
      return '❌ $fieldName must be at least ${min.toInt()} / न्यूनतम मान ${min.toInt()} होना चाहिए';
    }
    if (max != null && numVal > max) {
      return '❌ $fieldName cannot exceed ${max.toInt()} / अधिकतम सीमा ${max.toInt()} है';
    }
    return null;
  }

  /// Validate URL (https://)
  static String? validateUrl(String? value, {bool required = true}) {
    if (value == null || value.trim().isEmpty) {
      return required ? '❌ Please enter URL / कृपया URL दर्ज करें' : null;
    }
    final clean = value.trim();
    if (!clean.startsWith('http://') && !clean.startsWith('https://')) {
      return '❌ URL must start with https:// / URL https:// से शुरू होना चाहिए';
    }
    final uri = Uri.tryParse(clean);
    if (uri == null || !uri.hasAuthority) {
      return '❌ Please enter a valid URL / कृपया सही URL दर्ज करें';
    }
    return null;
  }
}
