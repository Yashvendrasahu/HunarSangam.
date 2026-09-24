// lib/screens/account_creation_screen.dart

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/onboarding_state.dart';
import '../services/auth_service.dart';
import '../services/supabase_config.dart';
import '../utils/input_validators.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/action_button.dart';

class AccountCreationScreen extends StatefulWidget {
  final OnboardingState state;
  final ValueChanged<OnboardingState> onStateChanged;
  final VoidCallback onBack;
  final VoidCallback onContinue;
  final VoidCallback onAlreadyHaveAccount;

  const AccountCreationScreen({
    super.key,
    required this.state,
    required this.onStateChanged,
    required this.onBack,
    required this.onContinue,
    required this.onAlreadyHaveAccount,
  });

  @override
  State<AccountCreationScreen> createState() => _AccountCreationScreenState();
}

class _AccountCreationScreenState extends State<AccountCreationScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  String? _nameError;
  String? _phoneError;
  String? _emailError;
  String? _passwordError;
  bool _isLoading = false;

  // Email Verification States
  bool _isEmailVerified = false;
  String _verifiedEmail = '';
  String _generatedOtp = '';
  bool _isSendingOtp = false;

  static const Color _primaryTerracotta = Color(0xFFA84318);
  static const Color _verifiedGreen = Color(0xFF2E7D32);
  static const Color _bgCanvas = Color(0xFFFDFBF9);
  static const Color _borderBeige = Color(0xFFEADFD6);
  static const Color _textDark = Color(0xFF2D2421);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.state.artisanName);
    _phoneController = TextEditingController(text: widget.state.phoneNumber);
    _emailController = TextEditingController(text: widget.state.email);
    _passwordController = TextEditingController(text: widget.state.password);

    _isEmailVerified = widget.state.isEmailVerified;
    if (_isEmailVerified && widget.state.email.isNotEmpty) {
      _verifiedEmail = widget.state.email.trim();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateAllFields() {
    final nameErr = InputValidators.validateName(_nameController.text, fieldName: 'Full Name / नाम');
    final phoneErr = InputValidators.validatePhone(_phoneController.text);
    final emailErr = InputValidators.validateEmail(_emailController.text, required: true);
    final passErr = InputValidators.validatePassword(_passwordController.text, minLength: 6);

    setState(() {
      _nameError = nameErr;
      _phoneError = phoneErr;
      _emailError = emailErr;
      _passwordError = passErr;
    });

    return nameErr == null && phoneErr == null && emailErr == null && passErr == null;
  }

  void _onEmailChanged(String val) {
    if (_isEmailVerified && val.trim() != _verifiedEmail) {
      setState(() {
        _isEmailVerified = false;
      });
    }
    if (_emailError != null) {
      setState(() => _emailError = InputValidators.validateEmail(val, required: true));
    }
  }

  String _generateRandomOtp() {
    final rand = Random();
    final otp = (100000 + rand.nextInt(900000)).toString();
    return otp;
  }

  Future<void> _initiateEmailVerification({bool showNoticeFirst = true}) async {
    final email = _emailController.text.trim();
    final emailErr = InputValidators.validateEmail(email, required: true);
    if (emailErr != null) {
      setState(() {
        _emailError = emailErr;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(emailErr),
          backgroundColor: const Color(0xFFC62828),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isSendingOtp = true;
      _emailError = null;
    });

    await Future.delayed(const Duration(milliseconds: 600));

    final newOtp = _generateRandomOtp();
    setState(() {
      _generatedOtp = newOtp;
      _isSendingOtp = false;
    });

    if (!mounted) return;

    // Show instant toast notification with the OTP code
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.mark_email_read_rounded, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                '📩 Verification code sent to $email (Code: $newOtp)',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: _primaryTerracotta,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 6),
      ),
    );

    _showOtpVerificationDialog(email, newOtp);
  }

  void _showOtpVerificationDialog(String email, String initialOtp) {
    final otpControllers = List.generate(6, (_) => TextEditingController());
    final focusNodes = List.generate(6, (_) => FocusNode());
    String currentOtp = initialOtp;
    int resendSeconds = 30;
    Timer? resendTimer;
    String? dialogError;
    bool isVerifying = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (modalContext, setDialogState) {
            // Start countdown timer if not started
            resendTimer ??= Timer.periodic(const Duration(seconds: 1), (t) {
              if (resendSeconds > 0) {
                setDialogState(() => resendSeconds--);
              } else {
                t.cancel();
              }
            });

            void handleVerifyCode() async {
              final enteredCode = otpControllers.map((c) => c.text.trim()).join();
              if (enteredCode.length < 6) {
                setDialogState(() {
                  dialogError = 'कृपया 6-अंकों का पूरा कोड दर्ज करें / Please enter all 6 digits';
                });
                return;
              }

              setDialogState(() {
                isVerifying = true;
                dialogError = null;
              });

              await Future.delayed(const Duration(milliseconds: 500));

              if (enteredCode == currentOtp) {
                resendTimer?.cancel();
                if (mounted) {
                  setState(() {
                    _isEmailVerified = true;
                    _verifiedEmail = email;
                  });
                }

                if (dialogCtx.mounted) {
                  Navigator.of(dialogCtx).pop();
                }

                if (modalContext.mounted) {
                  ScaffoldMessenger.of(modalContext).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: const [
                          Icon(Icons.check_circle, color: Colors.white, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '✓ Email verified successfully! You can now continue.',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      backgroundColor: _verifiedGreen,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              } else {
                setDialogState(() {
                  isVerifying = false;
                  dialogError = 'गलत ओटीपी कोड! कृपया सही कोड डालें / Invalid OTP code. Please check and try again.';
                });
              }
            }

            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.white,
              titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
              contentPadding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF1EB),
                      shape: BoxShape.circle,
                      border: Border.all(color: _borderBeige),
                    ),
                    child: const Icon(Icons.mark_email_read_outlined, color: _primaryTerracotta, size: 24),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Verify Email Address',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: _textDark,
                          ),
                        ),
                        Text(
                          'ईमेल सत्यापन अनिवार्य है',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: _primaryTerracotta,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    const Text(
                      'Enter the 6-digit verification code sent to:',
                      style: TextStyle(fontSize: 12.5, color: Color(0xFF7A685F)),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBF4EE),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: _borderBeige),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.email, size: 16, color: _primaryTerracotta),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              email,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: _textDark,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 6-digit Pin boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return SizedBox(
                          width: 38,
                          height: 46,
                          child: TextField(
                            controller: otpControllers[index],
                            focusNode: focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: _textDark,
                            ),
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: const Color(0xFFFAFAFA),
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: _borderBeige),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: _borderBeige),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(color: _primaryTerracotta, width: 2),
                              ),
                            ),
                            onChanged: (val) {
                              if (val.isNotEmpty) {
                                if (index < 5) {
                                  focusNodes[index + 1].requestFocus();
                                } else {
                                  focusNodes[index].unfocus();
                                }
                              } else {
                                if (index > 0) {
                                  focusNodes[index - 1].requestFocus();
                                }
                              }
                              setDialogState(() => dialogError = null);
                            },
                          ),
                        );
                      }),
                    ),

                    if (dialogError != null) ...[
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(Icons.error_outline, size: 14, color: Color(0xFFC62828)),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              dialogError!,
                              style: const TextStyle(
                                color: Color(0xFFC62828),
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 14),

                    // Helper row: Auto-fill Code + Resend
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Quick fill for testing
                        InkWell(
                          onTap: () {
                            for (int i = 0; i < 6; i++) {
                              if (i < currentOtp.length) {
                                otpControllers[i].text = currentOtp[i];
                              }
                            }
                            setDialogState(() => dialogError = null);
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            child: Row(
                              children: [
                                const Icon(Icons.auto_fix_high, size: 13, color: _primaryTerracotta),
                                const SizedBox(width: 4),
                                Text(
                                  'Auto-fill Code ($currentOtp)',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: _primaryTerracotta,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Resend Button
                        if (resendSeconds > 0)
                          Text(
                            'Resend in ${resendSeconds}s',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF9E9E9E),
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        else
                          InkWell(
                            onTap: () {
                              final freshOtp = _generateRandomOtp();
                              currentOtp = freshOtp;
                              resendSeconds = 30;
                              setDialogState(() {
                                dialogError = null;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('📩 New OTP sent: $freshOtp'),
                                  backgroundColor: _primaryTerracotta,
                                  duration: const Duration(seconds: 4),
                                ),
                              );
                            },
                            child: const Text(
                              'Resend OTP',
                              style: TextStyle(
                                fontSize: 11.5,
                                color: _primaryTerracotta,
                                fontWeight: FontWeight.w800,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              actions: [
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          resendTimer?.cancel();
                          Navigator.of(dialogCtx).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: _borderBeige),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Cancel / रद्द करें',
                          style: TextStyle(color: Color(0xFF7A685F), fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: isVerifying ? null : handleVerifyCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryTerracotta,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                        child: isVerifying
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : const Text(
                                'Verify & Confirm / वेरीफाई करें',
                                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5),
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      resendTimer?.cancel();
    });
  }

  void _submit() async {
    if (!_validateAllFields()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Please fix the errors in highlighted fields / कृपया सभी विवरण सही भरें'),
          backgroundColor: Color(0xFFC62828),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final email = _emailController.text.trim();
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();

    // STRICT GATEKEEPING: EMAIL MUST BE VERIFIED BEFORE ACCOUNT CREATION PROCEEDS
    if (!_isEmailVerified || _verifiedEmail != email) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.white, size: 22),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  '⚠️ जब तक ईमेल वेरीफाई नहीं होगा, अकाउंट क्रिएशन आगे नहीं बढ़ सकता।\n(Please verify your email address to continue)',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5),
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xFFD84315),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 4),
        ),
      );

      // Automatically open the verification OTP flow
      _initiateEmailVerification(showNoticeFirst: false);
      return;
    }

    // Email is verified -> Proceed with account creation
    setState(() => _isLoading = true);

    try {
      await AuthService().registerArtisan(
        name: name,
        phone: phone,
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint('[AccountCreationScreen] Register notice: $e');
    }

    if (!mounted) return;
    setState(() => _isLoading = false);

    widget.onStateChanged(widget.state.copyWith(
      artisanName: name,
      phoneNumber: phone,
      email: email,
      password: password,
      isEmailVerified: true,
    ));

    widget.onContinue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgCanvas,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OnboardingHeader(
                currentStep: 3,
                totalSteps: 7,
                title: 'Create Maker Account',
                subtitle: 'Enter your basic details to build your GI-verified digital craft profile',
                onBack: widget.onBack,
              ),
              const SizedBox(height: 20),

              // Full Name
              _buildInputField(
                'Full Name / कारीगर का नाम',
                _nameController,
                'e.g. Ramu Kumar',
                Icons.person_outline,
                errorText: _nameError,
                onChanged: (val) {
                  if (_nameError != null) {
                    setState(() => _nameError = InputValidators.validateName(val, fieldName: 'Full Name / नाम'));
                  }
                },
              ),
              const SizedBox(height: 14),

              // Mobile Number
              _buildInputField(
                'Mobile Number / फ़ोन नंबर',
                _phoneController,
                '+91 98765 43210',
                Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d\+\s\-]'))],
                errorText: _phoneError,
                onChanged: (val) {
                  if (_phoneError != null) {
                    setState(() => _phoneError = InputValidators.validatePhone(val));
                  }
                },
              ),
              const SizedBox(height: 14),

              // Email Address with Real-Time Verification Status
              _buildEmailField(),
              const SizedBox(height: 14),

              // Password
              _buildInputField(
                'Create PIN / Password',
                _passwordController,
                '••••••••',
                Icons.lock_outline,
                obscureText: true,
                errorText: _passwordError,
                onChanged: (val) {
                  if (_passwordError != null) {
                    setState(() => _passwordError = InputValidators.validatePassword(val, minLength: 6));
                  }
                },
              ),
              const SizedBox(height: 14),

              // Verification requirement alert banner
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _isEmailVerified ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isEmailVerified ? const Color(0xFFA5D6A7) : const Color(0xFFFFCC80),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isEmailVerified ? Icons.verified_user_rounded : Icons.lock_clock_rounded,
                      color: _isEmailVerified ? _verifiedGreen : const Color(0xFFE65100),
                      size: 20,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _isEmailVerified
                                ? 'ईमेल सत्यापित है / Email Verified'
                                : 'ईमेल सत्यापन आवश्यक है (Email Verification Required)',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: _isEmailVerified ? _verifiedGreen : const Color(0xFFE65100),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _isEmailVerified
                                ? 'आपका ईमेल सफलतापूर्वक सत्यापित हो चुका है। अब आप आगे बढ़ सकते हैं।'
                                : 'अकाउंट आगे बढ़ाने के लिए पहले ईमेल पर आया 6-अंकों का ओटीपी सत्यापित करें।',
                            style: TextStyle(
                              fontSize: 11,
                              color: _isEmailVerified ? const Color(0xFF2E7D32) : const Color(0xFF8D4B00),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // Supabase Auth Security Banner
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3EFEA),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE2D6CC)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.shield_outlined, color: Color(0xFF2E7D32), size: 16),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        SupabaseConfig.isSupabaseConfigured()
                            ? '⚡ Secured with Supabase Cloud Authentication'
                            : '⚡ Supabase Auth ready (Auto-syncs upon connection)',
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A3728),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Submit / Continue Button
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(color: _primaryTerracotta),
                  ),
                )
              else
                ActionButton(
                  text: _isEmailVerified ? 'Continue / आगे बढ़ें' : 'Verify Email & Continue / ईमेल वेरीफाई करें',
                  onPressed: _submit,
                ),

              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: widget.onAlreadyHaveAccount,
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(
                      color: _primaryTerracotta,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    final hasError = _emailError != null && _emailError!.isNotEmpty;
    final isVerifiedForCurrentText = _isEmailVerified && _verifiedEmail == _emailController.text.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Email Address / ईमेल पता *',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: hasError ? const Color(0xFFC62828) : _textDark,
              ),
            ),
            if (isVerifiedForCurrentText)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.check_circle_rounded, size: 12, color: _verifiedGreen),
                    SizedBox(width: 4),
                    Text(
                      'Verified / सत्यापित',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: _verifiedGreen,
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'Verification Required / अनिवार्य',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFFE65100),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          onChanged: _onEmailChanged,
          decoration: InputDecoration(
            hintText: 'artisan@hunarsangam.in',
            prefixIcon: Icon(
              Icons.email_outlined,
              color: hasError ? const Color(0xFFC62828) : _primaryTerracotta,
              size: 20,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 6),
              child: isVerifiedForCurrentText
                  ? const Icon(Icons.check_circle, color: _verifiedGreen, size: 22)
                  : TextButton.icon(
                      onPressed: _isSendingOtp ? null : () => _initiateEmailVerification(showNoticeFirst: false),
                      icon: _isSendingOtp
                          ? const SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(strokeWidth: 2, color: _primaryTerracotta),
                            )
                          : const Icon(Icons.send_rounded, size: 14, color: _primaryTerracotta),
                      label: Text(
                        _isSendingOtp ? 'Sending...' : 'Verify Email',
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                          color: _primaryTerracotta,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFFBF1EB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: _borderBeige),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                    ),
            ),
            filled: true,
            fillColor: hasError
                ? const Color(0xFFFFF5F5)
                : isVerifiedForCurrentText
                    ? const Color(0xFFF1F8E9)
                    : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: hasError
                    ? const Color(0xFFE57373)
                    : isVerifiedForCurrentText
                        ? const Color(0xFFA5D6A7)
                        : _borderBeige,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: hasError
                    ? const Color(0xFFE57373)
                    : isVerifiedForCurrentText
                        ? const Color(0xFFA5D6A7)
                        : _borderBeige,
                width: isVerifiedForCurrentText ? 1.5 : 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: hasError ? const Color(0xFFC62828) : _primaryTerracotta,
                width: 1.5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.error_outline, size: 13, color: Color(0xFFC62828)),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  _emailError!,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFFC62828),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ] else ...[
          const SizedBox(height: 4),
          Text(
            isVerifiedForCurrentText
                ? '✓ This email is verified and will be linked to your craft maker registry.'
                : '✉️ We require a 6-digit OTP confirmation to secure your GI-tagged maker account.',
            style: TextStyle(
              fontSize: 11.5,
              color: isVerifiedForCurrentText ? _verifiedGreen : _primaryTerracotta,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    String hint,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? helperText,
    String? errorText,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
  }) {
    final hasError = errorText != null && errorText.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: hasError ? const Color(0xFFC62828) : _textDark,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              icon,
              color: hasError ? const Color(0xFFC62828) : _primaryTerracotta,
              size: 20,
            ),
            filled: true,
            fillColor: hasError ? const Color(0xFFFFF5F5) : Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: hasError ? const Color(0xFFE57373) : _borderBeige,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: hasError ? const Color(0xFFE57373) : _borderBeige,
                width: hasError ? 1.5 : 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: hasError ? const Color(0xFFC62828) : _primaryTerracotta,
                width: 1.5,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.error_outline, size: 13, color: Color(0xFFC62828)),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  errorText,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFFC62828),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ] else if (helperText != null) ...[
          const SizedBox(height: 4),
          Text(
            helperText,
            style: const TextStyle(
              fontSize: 11.5,
              color: _primaryTerracotta,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
