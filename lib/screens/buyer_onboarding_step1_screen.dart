// lib/screens/buyer_onboarding_step1_screen.dart

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/buyer_onboarding_model.dart';
import '../utils/input_validators.dart';

/// Screen: Bulk Buyer Registration - Step 1 of 3: Basic Details
/// Exactly matches 'bulk buyer setp 1 register.png'
class BuyerOnboardingStep1Screen extends StatefulWidget {
  final BuyerOnboardingModel initialModel;
  final ValueChanged<BuyerOnboardingModel>? onContinue;
  final VoidCallback? onBack;

  const BuyerOnboardingStep1Screen({
    super.key,
    this.initialModel = const BuyerOnboardingModel(),
    this.onContinue,
    this.onBack,
  });

  @override
  State<BuyerOnboardingStep1Screen> createState() =>
      _BuyerOnboardingStep1ScreenState();
}

class _BuyerOnboardingStep1ScreenState
    extends State<BuyerOnboardingStep1Screen> {
  late final TextEditingController _nameController;
  late final TextEditingController _businessNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;
  late bool _useWhatsApp;
  late BusinessType _selectedBusinessType;

  String? _nameError;
  String? _businessNameError;
  String? _phoneError;
  String? _emailError;

  bool _isEmailVerified = false;
  String _verifiedEmail = '';
  String _generatedOtp = '';
  bool _isSendingOtp = false;

  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFDFBF9);
  static const Color _borderSubtle = Color(0xFFE5D5CB);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.initialModel.yourName.isNotEmpty
          ? widget.initialModel.yourName
          : 'Vikram Malhotra',
    );
    _businessNameController = TextEditingController(
      text: widget.initialModel.businessName.isNotEmpty
          ? widget.initialModel.businessName
          : 'FabCraft Living Pvt. Ltd.',
    );
    _phoneController = TextEditingController(
      text: widget.initialModel.phoneNumber.isNotEmpty
          ? widget.initialModel.phoneNumber
          : '98765 43210',
    );
    _emailController = TextEditingController(
      text: widget.initialModel.workEmail.isNotEmpty
          ? widget.initialModel.workEmail
          : 'procurement@fabcraft.in',
    );
    _useWhatsApp = widget.initialModel.useWhatsAppNotifications;
    _selectedBusinessType = widget.initialModel.businessType;
    _isEmailVerified = widget.initialModel.isVerified;
    if (_isEmailVerified && widget.initialModel.workEmail.isNotEmpty) {
      _verifiedEmail = widget.initialModel.workEmail.trim();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _businessNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool _validateFields() {
    final nameErr = InputValidators.validateName(_nameController.text, fieldName: 'Your Name');
    final bizErr = InputValidators.validateBusinessName(_businessNameController.text);
    final phoneErr = InputValidators.validatePhone(_phoneController.text);
    final emailErr = InputValidators.validateEmail(_emailController.text, required: true);

    setState(() {
      _nameError = nameErr;
      _businessNameError = bizErr;
      _phoneError = phoneErr;
      _emailError = emailErr;
    });

    return nameErr == null && bizErr == null && phoneErr == null && emailErr == null;
  }

  String _generateRandomOtp() {
    final rand = Random();
    return (100000 + rand.nextInt(900000)).toString();
  }

  Future<void> _initiateEmailVerification() async {
    final email = _emailController.text.trim();
    final emailErr = InputValidators.validateEmail(email, required: true);
    if (emailErr != null) {
      setState(() => _emailError = emailErr);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(emailErr), backgroundColor: const Color(0xFFC62828)),
      );
      return;
    }

    setState(() {
      _isSendingOtp = true;
      _emailError = null;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    final newOtp = _generateRandomOtp();

    setState(() {
      _generatedOtp = newOtp;
      _isSendingOtp = false;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('📩 Verification OTP sent to $email (Code: $newOtp)'),
        backgroundColor: _primaryRust,
        behavior: SnackBarBehavior.floating,
      ),
    );

    _showBuyerOtpDialog(email, newOtp);
  }

  void _showBuyerOtpDialog(String email, String initialOtp) {
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
                setDialogState(() => dialogError = 'Please enter complete 6-digit OTP');
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
                if (dialogCtx.mounted) Navigator.of(dialogCtx).pop();

                if (modalContext.mounted) {
                  ScaffoldMessenger.of(modalContext).showSnackBar(
                    const SnackBar(
                      content: Text('✓ Official Work Email verified successfully!'),
                      backgroundColor: Color(0xFF2E7D32),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              } else {
                setDialogState(() {
                  isVerifying = false;
                  dialogError = 'Invalid OTP code. Please enter the valid 6 digits.';
                });
              }
            }

            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              backgroundColor: Colors.white,
              title: Row(
                children: const [
                  Icon(Icons.verified_outlined, color: _primaryRust, size: 24),
                  SizedBox(width: 10),
                  Text('Verify Work Email', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _textDark)),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Enter the 6-digit code sent to $email:', style: const TextStyle(fontSize: 12.5, color: _textMuted)),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      return SizedBox(
                        width: 38,
                        height: 44,
                        child: TextField(
                          controller: otpControllers[index],
                          focusNode: focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _textDark),
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: const Color(0xFFFAFAFA),
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: _borderSubtle)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: _primaryRust, width: 2)),
                          ),
                          onChanged: (val) {
                            if (val.isNotEmpty && index < 5) {
                              focusNodes[index + 1].requestFocus();
                            } else if (val.isEmpty && index > 0) {
                              focusNodes[index - 1].requestFocus();
                            }
                            setDialogState(() => dialogError = null);
                          },
                        ),
                      );
                    }),
                  ),
                  if (dialogError != null) ...[
                    const SizedBox(height: 8),
                    Text(dialogError!, style: const TextStyle(color: Color(0xFFC62828), fontSize: 11.5, fontWeight: FontWeight.w600)),
                  ],
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          for (int i = 0; i < 6; i++) {
                            if (i < currentOtp.length) otpControllers[i].text = currentOtp[i];
                          }
                          setDialogState(() => dialogError = null);
                        },
                        child: Text('Auto-fill ($currentOtp)', style: const TextStyle(fontSize: 11, color: _primaryRust, fontWeight: FontWeight.bold)),
                      ),
                      Text(resendSeconds > 0 ? 'Resend in ${resendSeconds}s' : 'Ready to resend', style: const TextStyle(fontSize: 11, color: _textMuted)),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    resendTimer?.cancel();
                    Navigator.of(dialogCtx).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: isVerifying ? null : handleVerifyCode,
                  style: ElevatedButton.styleFrom(backgroundColor: _primaryRust, foregroundColor: Colors.white),
                  child: isVerifying ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Verify'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _handleContinue() {
    if (!_validateFields()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ Please fix the highlighted errors before continuing / कृपया सही जानकारी भरें'),
          backgroundColor: Color(0xFFC62828),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final email = _emailController.text.trim();
    if (!_isEmailVerified || _verifiedEmail != email) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('⚠️ जब तक ईमेल वेरीफाई नहीं होगा, प्रोसेस आगे नहीं बढ़ सकता। / Please verify work email to continue'),
          backgroundColor: Color(0xFFD84315),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 4),
        ),
      );
      _initiateEmailVerification();
      return;
    }

    final updatedModel = widget.initialModel.copyWith(
      yourName: _nameController.text.trim(),
      businessName: _businessNameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      workEmail: _emailController.text.trim(),
      useWhatsAppNotifications: _useWhatsApp,
      businessType: _selectedBusinessType,
      isVerified: true,
    );
    widget.onContinue?.call(updatedModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgCanvas,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            _buildProgressBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOnboardingBadge(),
                    const SizedBox(height: 12.0),
                    _buildHeaderSection(),
                    const SizedBox(height: 16.0),
                    _buildNameField(),
                    const SizedBox(height: 14.0),
                    _buildBusinessNameField(),
                    const SizedBox(height: 14.0),
                    _buildPhoneField(),
                    const SizedBox(height: 14.0),
                    _buildEmailField(),
                    const SizedBox(height: 16.0),
                    _buildLogoUploadSection(),
                    const SizedBox(height: 18.0),
                    _buildBusinessTypeGrid(),
                    const SizedBox(height: 18.0),
                    _buildAssuranceFootnote(),
                    const SizedBox(height: 12.0),
                  ],
                ),
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: _textDark, size: 22),
        onPressed: widget.onBack ?? () => Navigator.maybePop(context),
      ),
      title: const Text(
        'Business Setup',
        style: TextStyle(
          color: _textDark,
          fontSize: 16,
          fontWeight: FontWeight.w800,
        ),
      ),
      centerTitle: true,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF0E5DC),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: const Text(
            '1 of 3',
            style: TextStyle(
              color: Color(0xFF5D4037),
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: const Color(0xFFEFE8E2), height: 1.0),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Step 1: Basic Details',
                style: TextStyle(
                  color: _primaryRust,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '33% completed',
                style: TextStyle(
                  color: Color(0xFF6D4C41),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 3.5,
          color: const Color(0xFFEADFD6),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.33,
              child: Container(color: _primaryRust),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOnboardingBadge() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.verified, color: Color(0xFF2E7D32), size: 13),
            SizedBox(width: 4.0),
            Text(
              'Bulk Buyer Onboarding',
              style: TextStyle(
                color: Color(0xFF2E7D32),
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Tell us about your business',
          style: TextStyle(
            color: _textDark,
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Help artisans understand your sourcing scale and procurement needs.',
          style: TextStyle(
            color: _textMuted,
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    final hasErr = _nameError != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Your Name'),
        const SizedBox(height: 6.0),
        Container(
          decoration: BoxDecoration(
            color: hasErr ? const Color(0xFFFFF5F5) : Colors.white,
            border: Border.all(color: hasErr ? const Color(0xFFC62828) : _borderSubtle, width: hasErr ? 1.5 : 1.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Icon(Icons.person_outline, color: hasErr ? const Color(0xFFC62828) : const Color(0xFF8D6E63), size: 18),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  controller: _nameController,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _textDark),
                  onChanged: (val) {
                    if (_nameError != null) {
                      setState(() => _nameError = InputValidators.validateName(val, fieldName: 'Your Name'));
                    }
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (hasErr) ...[
          const SizedBox(height: 4.0),
          Text(
            _nameError!,
            style: const TextStyle(fontSize: 11.5, color: Color(0xFFC62828), fontWeight: FontWeight.w600),
          ),
        ],
      ],
    );
  }

  Widget _buildBusinessNameField() {
    final hasErr = _businessNameError != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Business / Organization Name'),
        const SizedBox(height: 6.0),
        Container(
          decoration: BoxDecoration(
            color: hasErr ? const Color(0xFFFFF5F5) : Colors.white,
            border: Border.all(color: hasErr ? const Color(0xFFC62828) : _borderSubtle, width: hasErr ? 1.5 : 1.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Icon(Icons.storefront_outlined, color: hasErr ? const Color(0xFFC62828) : const Color(0xFF8D6E63), size: 18),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  controller: _businessNameController,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _textDark),
                  onChanged: (val) {
                    if (_businessNameError != null) {
                      setState(() => _businessNameError = InputValidators.validateBusinessName(val));
                    }
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (hasErr) ...[
          const SizedBox(height: 4.0),
          Text(
            _businessNameError!,
            style: const TextStyle(fontSize: 11.5, color: Color(0xFFC62828), fontWeight: FontWeight.w600),
          ),
        ],
      ],
    );
  }

  Widget _buildPhoneField() {
    final hasErr = _phoneError != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Phone Number'),
        const SizedBox(height: 6.0),
        Container(
          decoration: BoxDecoration(
            color: hasErr ? const Color(0xFFFFF5F5) : Colors.white,
            border: Border.all(color: hasErr ? const Color(0xFFC62828) : _borderSubtle, width: hasErr ? 1.5 : 1.0),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFFAF5F0),
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(12.0)),
                  border: Border(right: BorderSide(color: _borderSubtle)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.format_align_justify, size: 14, color: _textDark),
                    SizedBox(width: 4.0),
                    Text(
                      '+91',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
                        color: _textDark,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d\s\-]'))],
                    onChanged: (val) {
                      if (_phoneError != null) {
                        setState(() => _phoneError = InputValidators.validatePhone(val));
                      }
                    },
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _textDark),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Icon(Icons.mic_none, color: Color(0xFF5D4037), size: 20),
              ),
            ],
          ),
        ),
        if (hasErr) ...[
          const SizedBox(height: 4.0),
          Text(
            _phoneError!,
            style: const TextStyle(fontSize: 11.5, color: Color(0xFFC62828), fontWeight: FontWeight.w600),
          ),
        ],
        const SizedBox(height: 8.0),
        InkWell(
          onTap: () => setState(() => _useWhatsApp = !_useWhatsApp),
          child: Row(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: _useWhatsApp ? const Color(0xFF2E7D32) : Colors.white,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    color: _useWhatsApp ? const Color(0xFF2E7D32) : const Color(0xFFC5B4A8),
                  ),
                ),
                child: _useWhatsApp
                    ? const Icon(Icons.check, size: 14, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 8.0),
              const Icon(Icons.chat_bubble, color: Color(0xFF2E7D32), size: 15),
              const SizedBox(width: 6.0),
              const Expanded(
                child: Text(
                  'Use this number for WhatsApp order updates and dispatch notices',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF4A3B32),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    final hasErr = _emailError != null;
    final isVerifiedForCurrentText = _isEmailVerified && _verifiedEmail == _emailController.text.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFieldLabel('Work Email Address *'),
            if (isVerifiedForCurrentText)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle_rounded, size: 12, color: Color(0xFF2E7D32)),
                    SizedBox(width: 4),
                    Text(
                      'Verified / सत्यापित',
                      style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
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
                  'Verification Required',
                  style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Color(0xFFE65100)),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6.0),
        Container(
          decoration: BoxDecoration(
            color: hasErr
                ? const Color(0xFFFFF5F5)
                : isVerifiedForCurrentText
                    ? const Color(0xFFF1F8E9)
                    : Colors.white,
            border: Border.all(
              color: hasErr
                  ? const Color(0xFFC62828)
                  : isVerifiedForCurrentText
                      ? const Color(0xFFA5D6A7)
                      : _borderSubtle,
              width: (hasErr || isVerifiedForCurrentText) ? 1.5 : 1.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              Icon(Icons.mail_outline, color: hasErr ? const Color(0xFFC62828) : _primaryRust, size: 18),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (val) {
                    if (_isEmailVerified && val.trim() != _verifiedEmail) {
                      setState(() => _isEmailVerified = false);
                    }
                    if (_emailError != null) {
                      setState(() => _emailError = InputValidators.validateEmail(val, required: true));
                    }
                  },
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: _textDark),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
              ),
              if (isVerifiedForCurrentText)
                const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 20)
              else
                TextButton(
                  onPressed: _isSendingOtp ? null : _initiateEmailVerification,
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFFBF1EB),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: _borderSubtle),
                    ),
                  ),
                  child: _isSendingOtp
                      ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: _primaryRust))
                      : const Text(
                          'Verify Email',
                          style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: _primaryRust),
                        ),
                ),
            ],
          ),
        ),
        if (hasErr) ...[
          const SizedBox(height: 4.0),
          Text(
            _emailError!,
            style: const TextStyle(fontSize: 11.5, color: Color(0xFFC62828), fontWeight: FontWeight.w600),
          ),
        ] else ...[
          const SizedBox(height: 4.0),
          Text(
            isVerifiedForCurrentText
                ? '✓ Work email verified and registered with Enterprise Sourcing Desk.'
                : '✉️ Email verification is required to build your verified corporate buyer profile.',
            style: TextStyle(
              fontSize: 11,
              color: isVerifiedForCurrentText ? const Color(0xFF2E7D32) : _primaryRust,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLogoUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload logo',
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w800,
            color: _textDark,
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: _borderSubtle),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Center(
                  child: Text(
                    'upload logo here',
                    style: TextStyle(
                      color: _textDark,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: _borderSubtle),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Center(
                  child: Text(
                    'Browse here',
                    style: TextStyle(
                      color: _textDark,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBusinessTypeGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Business Type *',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w800,
                color: _textDark,
              ),
            ),
            Text(
              'Select primary model',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFF7A685F),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.5,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          children: BusinessType.values.map((type) {
            final isSelected = _selectedBusinessType == type;
            return InkWell(
              onTap: () => setState(() => _selectedBusinessType = type),
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFDF5F0) : Colors.white,
                  border: Border.all(
                    color: isSelected ? _primaryRust : _borderSubtle,
                    width: isSelected ? 1.5 : 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: isSelected ? _primaryRust : const Color(0xFFFAF0E9),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(
                            _getBusinessTypeIcon(type),
                            size: 18,
                            color: isSelected ? Colors.white : const Color(0xFF5D4037),
                          ),
                        ),
                        Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected ? _primaryRust : Colors.transparent,
                            border: Border.all(
                              color: isSelected ? _primaryRust : const Color(0xFFC5B4A8),
                              width: 1.2,
                            ),
                          ),
                          child: isSelected
                              ? const Icon(Icons.check, size: 12, color: Colors.white)
                              : null,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          type.title,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                            color: _textDark,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          type.subtitle,
                          style: const TextStyle(
                            fontSize: 10.5,
                            color: _textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  IconData _getBusinessTypeIcon(BusinessType type) {
    switch (type) {
      case BusinessType.retailer:
        return Icons.shopping_bag_outlined;
      case BusinessType.eventOrganizer:
        return Icons.celebration_outlined;
      case BusinessType.corporateBuyer:
        return Icons.business_outlined;
      case BusinessType.shopOwner:
        return Icons.store_outlined;
      case BusinessType.institutional:
        return Icons.account_balance_outlined;
      case BusinessType.other:
        return Icons.more_horiz;
    }
  }

  Widget _buildAssuranceFootnote() {
    return Row(
      children: const [
        Icon(Icons.lock_outline, color: Color(0xFF2E7D32), size: 14),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(
            'Your business information is verified to connect with certified GI artisan clusters.',
            style: TextStyle(
              fontSize: 10.5,
              color: Color(0xFF5D4037),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFEFE8E2), width: 1.0),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: _handleContinue,
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryRust,
            foregroundColor: Colors.white,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Continue to Sourcing Needs',
                style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800),
              ),
              SizedBox(width: 6.0),
              Icon(Icons.arrow_forward, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          fontSize: 12.5,
          fontWeight: FontWeight.w800,
          color: _textDark,
        ),
        children: const [
          TextSpan(
            text: ' *',
            style: TextStyle(color: Color(0xFFC53030)),
          ),
        ],
      ),
    );
  }
}
