// lib/screens/buyer_onboarding_step3_screen.dart

import 'package:flutter/material.dart';
import '../models/buyer_onboarding_model.dart';
import '../widgets/brand_logo_card.dart';

/// Screen: Bulk Buyer Registration - Step 3 of 3: Review your profile
/// Exactly matches 'bulk buyer step 3 register.png'
class BuyerOnboardingStep3Screen extends StatelessWidget {
  final BuyerOnboardingModel model;
  final VoidCallback? onBack;
  final VoidCallback? onEditStep1;
  final VoidCallback? onEditStep2;
  final VoidCallback? onCreateProfile;

  const BuyerOnboardingStep3Screen({
    super.key,
    required this.model,
    this.onBack,
    this.onEditStep1,
    this.onEditStep2,
    this.onCreateProfile,
  });

  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFDFBF9);
  static const Color _headerBg = Color(0xFFFAF5F0);
  static const Color _cardBg = Color(0xFFFFFDFB);
  static const Color _borderSubtle = Color(0xFFF0E4DA);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgCanvas,
      appBar: _buildAppBar(context),
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
                    _buildHeading(),
                    const SizedBox(height: 14.0),
                    _buildReviewCard(),
                    const SizedBox(height: 14.0),
                    _buildAssuranceBox(),
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: _headerBg,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: _textDark, size: 20),
        onPressed: onBack ?? () => Navigator.maybePop(context),
      ),
      title: const Text(
        'Step 3 of 3',
        style: TextStyle(
          color: _textDark,
          fontSize: 14,
          fontWeight: FontWeight.w900,
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
            'Bulk Buyer',
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
    return Container(
      height: 4.0,
      color: _primaryRust,
    );
  }

  Widget _buildHeading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HunarSangamLogoBadge(size: 32.0, showText: true),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'Review your profile',
          style: TextStyle(
            color: _textDark,
            fontSize: 22,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Verify your business and sourcing preferences before connecting with craft clusters.',
          style: TextStyle(
            color: _textMuted,
            fontSize: 12,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard() {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: _borderSubtle),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row with Emblem, Business Name and Buyer Badge
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFEBF7FF),
                  border: Border.all(color: const Color(0xFFBBE3FC)),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.verified, color: Color(0xFF0077CC), size: 18),
                    Text(
                      'CIRRS',
                      style: TextStyle(
                        fontSize: 6.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0077CC),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.businessName,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w900,
                        color: _textDark,
                      ),
                    ),
                    Text(
                      'Bulk Buyer ID: ${model.buyerId}',
                      style: const TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFF7A685F),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF4E5),
                  border: Border.all(color: const Color(0xFFC8E6C9)),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  model.businessType.title,
                  style: const TextStyle(
                    color: Color(0xFF1B7339),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          const Divider(color: Color(0xFFF5ECE5), height: 1.0),
          const SizedBox(height: 12.0),

          // YOUR NAME
          _buildReviewRow(
            label: 'YOUR NAME',
            child: Text(
              model.yourName,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: _textDark,
              ),
            ),
            onEdit: onEditStep1,
          ),
          const SizedBox(height: 12.0),
          const Divider(color: Color(0xFFF5ECE5), height: 1.0),
          const SizedBox(height: 12.0),

          // CONTACT
          _buildReviewRow(
            label: 'CONTACT',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.countryCode} ${model.phoneNumber}',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: _textDark,
                  ),
                ),
                Text(
                  model.workEmail,
                  style: const TextStyle(
                    fontSize: 11,
                    color: _textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            onEdit: onEditStep1,
          ),
          const SizedBox(height: 12.0),
          const Divider(color: Color(0xFFF5ECE5), height: 1.0),
          const SizedBox(height: 12.0),

          // BUSINESS TYPE
          _buildReviewRow(
            label: 'BUSINESS TYPE',
            child: Text(
              '${model.businessType.title} (${model.businessType.subtitle})',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: _textDark,
              ),
            ),
            onEdit: onEditStep1,
          ),
          const SizedBox(height: 12.0),
          const Divider(color: Color(0xFFF5ECE5), height: 1.0),
          const SizedBox(height: 12.0),

          // LOOKING FOR
          _buildReviewRow(
            label: 'LOOKING FOR',
            child: Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: model.selectedCategories.map((category) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF0E8),
                    border: Border.all(color: const Color(0xFFECD9CE)),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 3,
                        backgroundColor: _primaryRust,
                      ),
                      const SizedBox(width: 6.0),
                      Text(
                        category,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: _primaryRust,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            onEdit: onEditStep2,
          ),
        ],
      ),
    );
  }

  Widget _buildReviewRow({
    required String label,
    required Widget child,
    VoidCallback? onEdit,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF8D6E63),
                  letterSpacing: 0.8,
                ),
              ),
              const SizedBox(height: 4.0),
              child,
            ],
          ),
        ),
        IconButton(
          onPressed: onEdit,
          icon: const Icon(Icons.edit_outlined, color: _primaryRust, size: 16),
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildAssuranceBox() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF5F0),
        border: Border.all(color: _borderSubtle),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD1F2D9),
            ),
            child: const Icon(Icons.shield_outlined, color: Color(0xFF2E7D32), size: 16),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Cluster Direct Assurance',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: _textDark,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  'Verified GST and bulk escrow protection enabled for authenticated craft orders.',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: _textMuted,
                    height: 1.3,
                  ),
                ),
              ],
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: onCreateProfile,
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
                    'Create Profile',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(width: 6.0),
                  Icon(Icons.arrow_forward, size: 16),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          TextButton(
            onPressed: onEditStep1,
            child: const Text(
              'Make adjustments',
              style: TextStyle(
                color: Color(0xFF6D4C41),
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
