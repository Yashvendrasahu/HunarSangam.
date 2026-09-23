// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import '../models/onboarding_state.dart';
import '../models/buyer_onboarding_model.dart';
import '../services/auth_service.dart';
import '../services/supabase_service.dart';
import '../services/supabase_config.dart';
import '../widgets/brand_logo_card.dart';
import '../widgets/api_config_dialog.dart';
import 'artisan_home_screen.dart';

/// Dynamic Login Screen supporting Artisan & Bulk Buyer Login,
/// Phone OTP verification, Password authentication, Quick Demo credentials,
/// and bidirectional session redirection.
class LoginScreen extends StatefulWidget {
  final OnboardingState? initialState;
  final VoidCallback? onLoginSuccess;
  final ValueChanged<OnboardingState>? onLoginSuccessWithState;
  final ValueChanged<BuyerOnboardingModel>? onBuyerLoginSuccess;
  final VoidCallback? onCreateAccount;
  final VoidCallback? onBack;
  final String currentLanguage;

  const LoginScreen({
    super.key,
    this.initialState,
    this.onLoginSuccess,
    this.onLoginSuccessWithState,
    this.onBuyerLoginSuccess,
    this.onCreateAccount,
    this.onBack,
    this.currentLanguage = 'English',
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _isBuyerRole = false;
  bool _useOtpMode = false;
  bool _otpSent = false;
  String? _generatedOtp;
  bool _obscurePassword = true;
  bool _isLoading = false;
  String _selectedLanguage = 'English';
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.currentLanguage;
    if (widget.initialState != null &&
        (widget.initialState!.email.isNotEmpty || widget.initialState!.phoneNumber.isNotEmpty)) {
      _contactController.text = widget.initialState!.email.isNotEmpty
          ? widget.initialState!.email
          : widget.initialState!.phoneNumber;
    }
  }

  @override
  void dispose() {
    _contactController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _fillDemoArtisan() {
    setState(() {
      _isBuyerRole = false;
      _useOtpMode = false;
      _contactController.text = 'ramukumar@hunarsangam.in';
      _passwordController.text = 'password123';
      _errorMessage = null;
    });
  }

  void _fillDemoBuyer() {
    setState(() {
      _isBuyerRole = true;
      _useOtpMode = false;
      _contactController.text = 'buyer@fabcraft.in';
      _passwordController.text = 'password123';
      _errorMessage = null;
    });
  }

  void _showForgotPasswordDialog() {
    final resetController = TextEditingController(text: _contactController.text.contains('@') ? _contactController.text : '');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        title: Row(
          children: const [
            Icon(Icons.lock_reset, color: Color(0xFFA84318)),
            SizedBox(width: 8),
            Text('Reset Password', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your registered email address. We will send you a secure password reset link via Supabase Auth.',
              style: TextStyle(fontSize: 13, color: Color(0xFF5D4037)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: resetController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'name@example.com',
                prefixIcon: const Icon(Icons.email_outlined, color: Color(0xFFA84318)),
                filled: true,
                fillColor: const Color(0xFFF9F5F1),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE5D5CB))),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () async {
              final email = resetController.text.trim();
              if (email.isNotEmpty && email.contains('@')) {
                Navigator.pop(ctx);
                await SupabaseService().sendPasswordReset(email);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('📨 Password reset link sent to $email via Supabase Auth!'),
                      backgroundColor: const Color(0xFF2E7D32),
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA84318),
              foregroundColor: Colors.white,
            ),
            child: const Text('Send Reset Link'),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSendOtp() async {
    final contact = _contactController.text.trim();
    if (contact.isEmpty) {
      setState(() => _errorMessage = 'Please enter your phone number to receive OTP');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final otp = await AuthService().sendOtp(phone: contact);

    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _otpSent = true;
      _generatedOtp = otp;
      _otpController.text = otp; // Pre-fill for instant frictionless convenience
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.sms_outlined, color: Colors.white, size: 20.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                '📱 OTP sent: $otp (Auto-filled for testing)',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2E7D32),
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();
    final contact = _contactController.text.trim();

    if (contact.isEmpty) {
      setState(() => _errorMessage = 'Please enter your email or phone number');
      return;
    }

    if (_useOtpMode) {
      final otp = _otpController.text.trim();
      if (otp.length < 4) {
        setState(() => _errorMessage = 'Please enter the 6-digit OTP code');
        return;
      }
    } else {
      final password = _passwordController.text.trim();
      if (password.isEmpty) {
        setState(() => _errorMessage = 'Please enter your password');
        return;
      }
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (_useOtpMode) {
        await AuthService().verifyOtp(
          phone: contact,
          otp: _otpController.text.trim(),
          role: _isBuyerRole ? 'buyer' : 'artisan',
        );
      } else {
        await AuthService().loginWithEmailOrPhone(
          contact: contact,
          password: _passwordController.text.trim(),
          preferredRole: _isBuyerRole ? 'buyer' : 'artisan',
        );
      }

      if (!mounted) return;

      final isEmail = contact.contains('@');
      final authUser = AuthService().currentUser;

      if (_isBuyerRole) {
        final buyerModel = AuthService().currentBuyer ??
            BuyerOnboardingModel(
              yourName: authUser?.name.isNotEmpty == true ? authUser!.name : 'Vikram Mehra',
              businessName: 'FabCraft Living & Export',
              workEmail: isEmail ? contact : 'buyer@fabcraft.in',
              phoneNumber: !isEmail ? contact : '+91 98111 22334',
            );

        setState(() => _isLoading = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('🎉 Welcome back, ${buyerModel.yourName}!'),
            backgroundColor: const Color(0xFF2E7D32),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
          ),
        );

        if (widget.onBuyerLoginSuccess != null) {
          widget.onBuyerLoginSuccess!(buyerModel);
          return;
        }
      }

      // Artisan flow
      final baseState = widget.initialState ?? const OnboardingState();
      final artisanProfile = AuthService().currentArtisan;

      final updatedSessionState = baseState.copyWith(
        email: isEmail ? contact : (artisanProfile?.email ?? baseState.email),
        phoneNumber: !isEmail ? contact : (artisanProfile?.phone ?? baseState.phoneNumber),
        password: _passwordController.text.trim(),
        selectedLanguage: _selectedLanguage,
        selectedRole: UserRole.artisan,
        artisanName: artisanProfile?.name.isNotEmpty == true
            ? artisanProfile!.name
            : (baseState.artisanName.isNotEmpty ? baseState.artisanName : 'Ramu Kumar'),
        artisanLocation: artisanProfile?.location.isNotEmpty == true
            ? artisanProfile!.location
            : (baseState.artisanLocation.isNotEmpty ? baseState.artisanLocation : 'Barabanki, Uttar Pradesh'),
        experienceYears: artisanProfile?.experienceYears ?? '10+ Years',
        selectedCraftIds: baseState.selectedCraftIds.isNotEmpty ? baseState.selectedCraftIds : const ['bamboo_cane'],
        bulkProductionReady: true,
        hasProfilePhoto: true,
      );

      setState(() => _isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🎉 Welcome back, ${updatedSessionState.artisanName}!'),
          backgroundColor: const Color(0xFF2E7D32),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );

      if (widget.onLoginSuccessWithState != null) {
        widget.onLoginSuccessWithState!(updatedSessionState);
        return;
      }

      if (widget.onLoginSuccess != null) {
        widget.onLoginSuccess!();
        return;
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ArtisanHomeScreen(
            state: updatedSessionState,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = 'Login failed. Please check credentials.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with back, logo, language
            _buildTopBar(),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),

                    // Role Switcher Tabs (Artisan vs Bulk Buyer)
                    _buildRoleToggleTabs(),

                    const SizedBox(height: 20.0),

                    Text(
                      _isBuyerRole ? 'Bulk Buyer Login' : 'Craft Maker Sign In / लॉगिन करें',
                      style: const TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF221C19),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      _isBuyerRole
                          ? 'Access verified craft maker clusters, place bulk RFQs & track escrow orders.'
                          : 'Manage your craft listings, view bulk buyer purchase orders & production progress.',
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: Color(0xFF6B584E),
                        height: 1.35,
                      ),
                    ),

                    const SizedBox(height: 14.0),

                    // Quick Demo Credentials Fill Chips
                    _buildQuickDemoChips(),

                    if (_errorMessage != null) ...[
                      const SizedBox(height: 14.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEBEE),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: const Color(0xFFFFCDD2)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, color: Color(0xFFC62828), size: 18.0),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  color: Color(0xFFC62828),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 18.0),

                    // Contact Input (Email or Phone)
                    Text(
                      _useOtpMode ? 'Phone Number / मोबाइल नंबर' : 'Email or Phone / ईमेल या मोबाइल',
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2D2421),
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6ECE5),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color(0xFFE5D5CB)),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Row(
                        children: [
                          Icon(
                            _useOtpMode ? Icons.phone_outlined : Icons.person_outline_rounded,
                            color: const Color(0xFF6B584E),
                            size: 20.0,
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: TextField(
                              controller: _contactController,
                              keyboardType: _useOtpMode ? TextInputType.phone : TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: _useOtpMode
                                    ? 'Enter 10-digit mobile number'
                                    : 'Enter email or registered phone',
                                hintStyle: const TextStyle(
                                  fontSize: 14.0,
                                  color: Color(0xFF9E8D84),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          if (_contactController.text.isNotEmpty)
                            IconButton(
                              icon: const Icon(Icons.clear, size: 18.0, color: Color(0xFF9E8D84)),
                              onPressed: () => setState(() => _contactController.clear()),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16.0),

                    // Password or OTP Field
                    if (!_useOtpMode) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Password / पासवर्ड',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2D2421),
                            ),
                          ),
                          TextButton(
                            onPressed: () => setState(() => _useOtpMode = true),
                            style: TextButton.styleFrom(padding: EdgeInsets.zero),
                            child: const Text(
                              'Login via OTP instead',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFA84318),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF6ECE5),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: const Color(0xFFE5D5CB)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: Row(
                          children: [
                            const Icon(Icons.lock_outline_rounded, color: Color(0xFF6B584E), size: 20.0),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: TextField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                decoration: const InputDecoration(
                                  hintText: 'Enter your password',
                                  hintStyle: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF9E8D84),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                color: const Color(0xFF7A685F),
                                size: 20.0,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _showForgotPasswordDialog,
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: const Text(
                            'Forgot Password? / पासवर्ड भूल गए?',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFA84318),
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Enter 6-Digit OTP / ओटीपी कोड',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2D2421),
                            ),
                          ),
                          TextButton(
                            onPressed: () => setState(() => _useOtpMode = false),
                            style: TextButton.styleFrom(padding: EdgeInsets.zero),
                            child: const Text(
                              'Use Password instead',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFA84318),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFF6ECE5),
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(color: const Color(0xFFE5D5CB)),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 14.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.pin_outlined, color: Color(0xFF6B584E), size: 20.0),
                                  const SizedBox(width: 12.0),
                                  Expanded(
                                    child: TextField(
                                      controller: _otpController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        hintText: '6-digit OTP code',
                                        hintStyle: TextStyle(
                                          fontSize: 14.0,
                                          color: Color(0xFF9E8D84),
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          ElevatedButton(
                            onPressed: _isLoading ? null : _handleSendOtp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8C3A16),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                            ),
                            child: Text(
                              _otpSent ? 'Resend OTP' : 'Send OTP',
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.0),
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 28.0),

                    // Login Action Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA84318),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                          elevation: 2,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20.0,
                                width: 20.0,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _isBuyerRole ? 'Login to Bulk Buyer Hub' : 'Sign In / लॉगिन करें',
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Icon(Icons.arrow_forward_rounded, size: 20.0),
                                ],
                              ),
                      ),
                    ),

                    const SizedBox(height: 20.0),

                    // Don't have an account? Create one
                    Center(
                      child: InkWell(
                        onTap: widget.onCreateAccount,
                        borderRadius: BorderRadius.circular(12.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                          child: RichText(
                            text: const TextSpan(
                              text: "Don't have an account yet? ",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Color(0xFF6B584E),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Sign Up / खाता बनाएं',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFFB85324),
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (widget.onBack != null)
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Color(0xFF2D2421)),
                  onPressed: widget.onBack,
                ),
              const HunarSangamLogoBadge(size: 32.0, showText: true),
            ],
          ),

          // Quick language selector & Cloud Setup
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.tune_rounded, size: 20, color: Color(0xFF8C3A16)),
                tooltip: 'Cloud & AI Setup',
                onPressed: () => ApiConfigDialog.show(context),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E7DF),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFE5D5CB)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.language_rounded, size: 14.0, color: Color(0xFF8C3A16)),
                    const SizedBox(width: 4.0),
                    Text(
                      _selectedLanguage == 'English' ? 'EN' : 'हिन्दी',
                      style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF8C3A16)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRoleToggleTabs() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1E4DC),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFE5D5CB)),
      ),
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _isBuyerRole = false),
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: !_isBuyerRole ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: !_isBuyerRole
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4.0,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.palette_outlined,
                      size: 16.0,
                      color: !_isBuyerRole ? const Color(0xFFA84318) : const Color(0xFF7A685F),
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      'Craft Maker / कारीगर',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: !_isBuyerRole ? const Color(0xFFA84318) : const Color(0xFF7A685F),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () => setState(() => _isBuyerRole = true),
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: _isBuyerRole ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: _isBuyerRole
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4.0,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.storefront_outlined,
                      size: 16.0,
                      color: _isBuyerRole ? const Color(0xFFA84318) : const Color(0xFF7A685F),
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      'Bulk Buyer / खरीदार',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: _isBuyerRole ? const Color(0xFFA84318) : const Color(0xFF7A685F),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickDemoChips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Testing Demo Accounts:',
          style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Color(0xFF8C756B)),
        ),
        const SizedBox(height: 6.0),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _fillDemoArtisan,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  side: BorderSide(
                    color: !_isBuyerRole ? const Color(0xFFA84318) : const Color(0xFFE5D5CB),
                    width: 1.2,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  backgroundColor: !_isBuyerRole ? const Color(0xFFFFF2EC) : Colors.white,
                ),
                child: const Text(
                  '🎨 Craft Maker (Ramu)',
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Color(0xFF2D2421)),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: OutlinedButton(
                onPressed: _fillDemoBuyer,
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                  side: BorderSide(
                    color: _isBuyerRole ? const Color(0xFFA84318) : const Color(0xFFE5D5CB),
                    width: 1.2,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                  backgroundColor: _isBuyerRole ? const Color(0xFFFFF2EC) : Colors.white,
                ),
                child: const Text(
                  '🏢 Bulk Buyer (FabCraft)',
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Color(0xFF2D2421)),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
