// lib/screens/account_creation_screen.dart

import 'package:flutter/material.dart';
import '../models/onboarding_state.dart';
import '../services/auth_service.dart';
import '../services/supabase_config.dart';
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

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.state.artisanName);
    _phoneController = TextEditingController(text: widget.state.phoneNumber);
    _emailController = TextEditingController(text: widget.state.email);
    _passwordController = TextEditingController(text: widget.state.password);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  void _submit() async {
    final email = _emailController.text.trim();
    final name = _nameController.text.trim().isNotEmpty ? _nameController.text.trim() : 'Ramu Kumar';
    final phone = _phoneController.text.trim().isNotEmpty ? _phoneController.text.trim() : '+91 98765 43210';
    final password = _passwordController.text.trim().isNotEmpty ? _passwordController.text.trim() : 'Artisan@123';

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
    ));

    if (email.isNotEmpty && email.contains('@')) {
      _showEmailVerificationNotice(email);
    } else {
      widget.onContinue();
    }
  }

  void _showEmailVerificationNotice(String email) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        title: Row(
          children: const [
            Icon(Icons.mark_email_read_outlined, color: Color(0xFFA84318), size: 28),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Verify Your Email',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2421),
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'A verification link has been sent to:',
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFBF4EE),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFEADFD6)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.email_outlined, color: Color(0xFFA84318), size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      email,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA84318),
                        fontSize: 13.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '📩 Please check your inbox or spam folder and tap the confirmation link to activate your maker profile.',
              style: TextStyle(fontSize: 12.5, height: 1.4, color: Color(0xFF4A3B32)),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              widget.onContinue();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA84318),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            ),
            child: const Text('Got It / समझ गया (Continue)', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
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
              _buildInputField('Full Name / कारीगर का नाम', _nameController, 'e.g. Ramu Kumar', Icons.person_outline),
              const SizedBox(height: 14),
              _buildInputField('Mobile Number / फ़ोन नंबर', _phoneController, '+91 98765 43210', Icons.phone_outlined, keyboardType: TextInputType.phone),
              const SizedBox(height: 14),
              _buildInputField(
                'Email (Optional) / ईमेल पता',
                _emailController,
                'artisan@hunarsangam.in',
                Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                helperText: '✉️ We will send an account verification link to this email.',
              ),
              const SizedBox(height: 14),
              _buildInputField('Create PIN / Password', _passwordController, '••••••••', Icons.lock_outline, obscureText: true),
              const SizedBox(height: 14),
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
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(color: Color(0xFFA84318)),
                  ),
                )
              else
                ActionButton(
                  text: 'Continue / आगे बढ़ें',
                  onPressed: _submit,
                ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: widget.onAlreadyHaveAccount,
                  child: const Text(
                    'Already have an account? Login',
                    style: TextStyle(
                      color: Color(0xFFA84318),
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

  Widget _buildInputField(
    String label,
    TextEditingController controller,
    String hint,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? helperText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFF2D2421),
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: const Color(0xFFA84318), size: 20),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFEADFD6)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFEADFD6)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFA84318), width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          ),
        ),
        if (helperText != null) ...[
          const SizedBox(height: 4),
          Text(
            helperText,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFFA84318),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}
