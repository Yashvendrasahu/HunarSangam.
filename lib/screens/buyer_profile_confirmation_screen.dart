// lib/screens/buyer_profile_confirmation_screen.dart

import 'package:flutter/material.dart';
import '../models/buyer_onboarding_model.dart';

/// Screen: Bulk Buyer Profile Confirmation / Ready Screen
/// Visually reproduces 'bulk buyer profile confirmation after register.png'
class BuyerProfileConfirmationScreen extends StatelessWidget {
  final BuyerOnboardingModel model;
  final VoidCallback onGoToDashboard;
  final VoidCallback onViewProfile;
  final VoidCallback? onBack;

  const BuyerProfileConfirmationScreen({
    super.key,
    required this.model,
    required this.onGoToDashboard,
    required this.onViewProfile,
    this.onBack,
  });

  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFDFBF9);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgCanvas,
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12.0),
              // Big Green Checkmark
              Center(
                child: Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2E6B47),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2E6B47).withOpacity(0.25),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.check, color: Colors.white, size: 50),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),

              // Title
              const Text(
                'Your Bulk Buyer Profile is\nReady',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: _textDark,
                  letterSpacing: -0.5,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 8.0),

              // Subtitle
              const Text(
                'Now discover artisans, explore handmade products and send bulk requirements directly to craft clusters.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.5,
                  color: _textMuted,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 14.0),

              // Wholesale tier pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7EFE9),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2E7D32),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    const Text(
                      'Wholesale Tier: Direct-to-Cluster Access Enabled',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: _textDark,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),

              // Section header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'BULK BUYER CAPABILITIES',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF4A3B32),
                      letterSpacing: 0.5,
                    ),
                  ),
                  Row(
                    children: const [
                      Icon(Icons.verified_user_outlined, size: 14, color: Color(0xFF9C3C18)),
                      SizedBox(width: 4.0),
                      Text(
                        'Enterprise Protected',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF9C3C18),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12.0),

              // Capability Cards
              _buildCapabilityCard(
                icon: Icons.groups_outlined,
                title: 'Discover Artisans',
                desc: 'Explore master artisans from 120+ GI craft clusters across India.',
                tag1: 'Verified Guilds',
                tag1Green: true,
                tag2: 'Direct cluster contacts',
                onTap: onGoToDashboard,
              ),
              const SizedBox(height: 10.0),

              _buildCapabilityCard(
                icon: Icons.inventory_2_outlined,
                title: 'Find Products',
                desc: 'Browse authentic catalog items with transparent wholesale bulk tiers.',
                tag1: 'Tiered B2B Pricing',
                tag1Green: true,
                tag2: 'MOQ transparency',
                onTap: onGoToDashboard,
              ),
              const SizedBox(height: 10.0),

              _buildCapabilityCard(
                icon: Icons.post_add_outlined,
                title: 'Post a Requirement',
                desc: 'Specify custom designs, sample requests, and batch quantities directly.',
                tag1: 'Custom RFQs',
                tag1Green: false,
                tag2: 'Audio notes supported',
                onTap: onGoToDashboard,
              ),
              const SizedBox(height: 20.0),

              // Footnote
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.handshake_outlined, size: 16, color: Color(0xFF2E7D32)),
                  SizedBox(width: 8.0),
                  Flexible(
                    child: Text(
                      'Direct settlements directly empowering rural artisan clusters.',
                      style: TextStyle(
                        fontSize: 11,
                        color: Color(0xFF5D4037),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),

              // Buttons
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: onGoToDashboard,
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
                        'Go to Dashboard',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                      ),
                      SizedBox(width: 8.0),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: onViewProfile,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: _textDark,
                    side: const BorderSide(color: Color(0xFFEADFD6)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.storefront_outlined, size: 18, color: _textDark),
                      SizedBox(width: 8.0),
                      Text(
                        'View My Profile',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const Text(
            'HunarSangam',
            style: TextStyle(
              color: Color(0xFF9C3C18),
              fontSize: 18,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(width: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.check, size: 12, color: Color(0xFF2E7D32)),
                SizedBox(width: 4.0),
                Text(
                  'Bulk Buyer',
                  style: TextStyle(
                    color: Color(0xFF2E7D32),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFAF5F0),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: const Color(0xFFEADFD6)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.translate, size: 14, color: Color(0xFF5D4037)),
              SizedBox(width: 4.0),
              Text(
                'EN',
                style: TextStyle(
                  color: Color(0xFF5D4037),
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

  Widget _buildCapabilityCard({
    required IconData icon,
    required String title,
    required String desc,
    required String tag1,
    required bool tag1Green,
    required String tag2,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.0),
      child: Container(
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: const Color(0xFFEFE8E2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFFAF0E9),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, color: const Color(0xFF9C3C18), size: 22),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: _textDark,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios, size: 13, color: Color(0xFFB0A298)),
                    ],
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                    desc,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: _textMuted,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: tag1Green ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (tag1Green) ...[
                              const Icon(Icons.verified, size: 10, color: Color(0xFF2E7D32)),
                              const SizedBox(width: 3.0),
                            ],
                            Text(
                              tag1,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: tag1Green ? const Color(0xFF2E7D32) : const Color(0xFFE65100),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        tag2,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF8D6E63),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
