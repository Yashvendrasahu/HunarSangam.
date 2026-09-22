// lib/screens/account_creation_screen.dart

import 'package:flutter/material.dart';
import '../models/onboarding_state.dart';
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

  void _submit() {
    widget.onStateChanged(widget.state.copyWith(
      artisanName: _nameController.text.trim().isNotEmpty ? _nameController.text.trim() : 'Ramu Kumar',
      phoneNumber: _phoneController.text.trim().isNotEmpty ? _phoneController.text.trim() : '+91 98765 43210',
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    ));
    widget.onContinue();
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
              _buildInputField('Email (Optional)', _emailController, 'artisan@hunarsangam.in', Icons.email_outlined, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 14),
              _buildInputField('Create PIN / Password', _passwordController, '••••••••', Icons.lock_outline, obscureText: true),
              const SizedBox(height: 24),
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
      ],
    );
  }
}
