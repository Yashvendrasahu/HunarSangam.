// lib/screens/buyer_onboarding_step1_screen.dart

import 'package:flutter/material.dart';
import '../models/buyer_onboarding_model.dart';
import '../services/hardware_service.dart';
import '../widgets/brand_logo_card.dart';

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

  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFDFBF9);
  static const Color _headerBg = Color(0xFFFAF5F0);
  static const Color _borderSubtle = Color(0xFFE5D5CB);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialModel.yourName);
    _businessNameController =
        TextEditingController(text: widget.initialModel.businessName);
    _phoneController =
        TextEditingController(text: widget.initialModel.phoneNumber);
    _emailController =
        TextEditingController(text: widget.initialModel.workEmail);
    _useWhatsApp = widget.initialModel.useWhatsAppNotifications;
    _selectedBusinessType = widget.initialModel.businessType;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _businessNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    final updatedModel = widget.initialModel.copyWith(
      yourName: _nameController.text.trim(),
      businessName: _businessNameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      workEmail: _emailController.text.trim(),
      useWhatsAppNotifications: _useWhatsApp,
      businessType: _selectedBusinessType,
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
                    const SizedBox(height: 20.0),
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
      backgroundColor: _headerBg,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: _textDark, size: 20),
        onPressed: widget.onBack ?? () => Navigator.maybePop(context),
      ),
      title: const Text(
        'Business Setup',
        style: TextStyle(
          color: _textDark,
          fontSize: 15,
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
        child: Container(color: const Color(0xFFE8DDD5), height: 1.0),
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
          height: 4.0,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const HunarSangamLogoBadge(size: 32.0, showText: true),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            border: Border.all(color: const Color(0xFFC8E6C9)),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32), size: 14),
              SizedBox(width: 5.0),
              Text(
                'Bulk Buyer Onboarding',
                style: TextStyle(
                  color: Color(0xFF2E7D32),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
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
          'Help craft makers understand your sourcing scale and procurement needs.',
          style: TextStyle(
            color: _textMuted,
            fontSize: 12,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Your Name'),
        const SizedBox(height: 6.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: _borderSubtle),
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              const Icon(Icons.person_outline, color: Color(0xFF8D6E63), size: 18),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  controller: _nameController,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Full Name',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBusinessNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Business / Organization Name'),
        const SizedBox(height: 6.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: _borderSubtle),
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              const Icon(Icons.storefront_outlined, color: Color(0xFF8D6E63), size: 18),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  controller: _businessNameController,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Company or Store Name',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Phone Number'),
        const SizedBox(height: 6.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: _borderSubtle),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFFAF5F0),
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(16.0)),
                  border: Border(right: BorderSide(color: _borderSubtle)),
                ),
                child: const Row(
                  children: [
                    Text('🇮🇳', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 4.0),
                    Text(
                      '+91',
                      style: TextStyle(
                        fontSize: 12,
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
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '98765 43210',
                      isDense: true,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Icon(Icons.mic_none, color: Color(0xFF8D6E63), size: 18),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6.0),
        InkWell(
          onTap: () => setState(() => _useWhatsApp = !_useWhatsApp),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: _useWhatsApp ? const Color(0xFF2E7D32) : Colors.white,
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    color: _useWhatsApp ? const Color(0xFF2E7D32) : const Color(0xFFC5B4A8),
                  ),
                ),
                child: _useWhatsApp
                    ? const Icon(Icons.check, size: 12, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 8.0),
              const Icon(Icons.chat_bubble_outline, color: Color(0xFF2E7D32), size: 14),
              const SizedBox(width: 4.0),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Work Email Address'),
        const SizedBox(height: 6.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: _borderSubtle),
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            children: [
              const Icon(Icons.mail_outline, color: Color(0xFF8D6E63), size: 18),
              const SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'procurement@organization.com',
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
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
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: _textDark,
          ),
        ),
        const SizedBox(height: 6.0),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  final img = await HardwareService().captureImageFromCamera();
                  if (img != null && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('📷 Logo captured: ${img.name}!'),
                        backgroundColor: const Color(0xFF2E7D32),
                      ),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(16.0),
                child: _buildDashedUploadBox(
                  icon: Icons.camera_alt_outlined,
                  label: 'Camera logo',
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: InkWell(
                onTap: () async {
                  final img = await HardwareService().pickImageFromGallery();
                  if (img != null && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('🖼️ Logo selected: ${img.name}!'),
                        backgroundColor: const Color(0xFF2E7D32),
                      ),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(16.0),
                child: _buildDashedUploadBox(
                  icon: Icons.folder_open_outlined,
                  label: 'Browse gallery',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDashedUploadBox({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFFD5C5BA),
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF8D6E63), size: 20),
          const SizedBox(height: 4.0),
          Text(
            label,
            style: const TextStyle(
              color: _textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
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
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: _textDark,
              ),
            ),
            Text(
              'Select primary model',
              style: TextStyle(
                fontSize: 10.5,
                color: Color(0xFF7A685F),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.45,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          children: BusinessType.values.map((type) {
            final isSelected = _selectedBusinessType == type;
            return InkWell(
              onTap: () => setState(() => _selectedBusinessType = type),
              borderRadius: BorderRadius.circular(16.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFFDF5F0) : Colors.white,
                  border: Border.all(
                    color: isSelected ? _primaryRust : _borderSubtle,
                    width: isSelected ? 2.0 : 1.0,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: isSelected ? _primaryRust : const Color(0xFFF4ECE5),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Icon(
                            _getBusinessTypeIcon(type),
                            size: 16,
                            color: isSelected ? Colors.white : const Color(0xFF5D4037),
                          ),
                        ),
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected ? _primaryRust : Colors.transparent,
                            border: Border.all(
                              color: isSelected ? _primaryRust : const Color(0xFFC5B4A8),
                            ),
                          ),
                          child: isSelected
                              ? const Icon(Icons.check, size: 11, color: Colors.white)
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
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: _textDark,
                          ),
                        ),
                        Text(
                          type.subtitle,
                          style: const TextStyle(
                            fontSize: 10,
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
        return Icons.store_mall_directory_outlined;
      case BusinessType.institutional:
        return Icons.account_balance_outlined;
      case BusinessType.other:
        return Icons.more_horiz;
    }
  }

  Widget _buildAssuranceFootnote() {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5F0),
        border: Border.all(color: const Color(0xFFECDCCF)),
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Row(
        children: const [
          Icon(Icons.lock_outline, color: Color(0xFF2E7D32), size: 16),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              'Your business information is verified to connect with certified GI craft maker clusters.',
              style: TextStyle(
                fontSize: 10.5,
                color: Color(0xFF4A3B32),
                fontWeight: FontWeight.w500,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE8DDD5))),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: _handleContinue,
          style: ElevatedButton.styleFrom(
            backgroundColor: _primaryRust,
            foregroundColor: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Continue to Sourcing Needs',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
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
          fontSize: 12,
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
