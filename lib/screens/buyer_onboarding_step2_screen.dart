// lib/screens/buyer_onboarding_step2_screen.dart

import 'package:flutter/material.dart';
import '../models/buyer_onboarding_model.dart';
import '../widgets/brand_logo_card.dart';

/// Screen: Bulk Buyer Registration - Step 2 of 3: Sourcing Preferences
/// Matches the bespoke enterprise styling of Step 1 & Step 3 with HunarSangam design language
class BuyerOnboardingStep2Screen extends StatefulWidget {
  final BuyerOnboardingModel model;
  final VoidCallback onBack;
  final ValueChanged<BuyerOnboardingModel> onContinue;

  const BuyerOnboardingStep2Screen({
    super.key,
    required this.model,
    required this.onBack,
    required this.onContinue,
  });

  @override
  State<BuyerOnboardingStep2Screen> createState() => _BuyerOnboardingStep2ScreenState();
}

class _BuyerOnboardingStep2ScreenState extends State<BuyerOnboardingStep2Screen> {
  late List<String> _selectedCategories;
  late String _volumeRequirement;

  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFDFBF9);
  static const Color _headerBg = Color(0xFFFAF5F0);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);

  final List<Map<String, dynamic>> _craftOptions = [
    {'name': 'Pottery & Ceramics', 'icon': Icons.palette_outlined, 'desc': 'Khurja & Blue Pottery'},
    {'name': 'Bamboo & Cane', 'icon': Icons.forest_outlined, 'desc': 'Northeast & Barabanki Baskets'},
    {'name': 'Handloom & Textiles', 'icon': Icons.dry_cleaning_outlined, 'desc': 'Chanderi, Pashmina & Khadi'},
    {'name': 'Brass & Metal Craft', 'icon': Icons.hardware_outlined, 'desc': 'Moradabad & Dhokra Metal'},
    {'name': 'Woodcarving', 'icon': Icons.carpenter_outlined, 'desc': 'Saharanpur Sheesham Craft'},
    {'name': 'Leather Craft', 'icon': Icons.shopping_bag_outlined, 'desc': 'Kolhapuri & Kanpur Tanning'},
    {'name': 'Stone & Marble Inlay', 'icon': Icons.diamond_outlined, 'desc': 'Agra Pietra Dura & Carving'},
    {'name': 'Zari & Zardozi', 'icon': Icons.auto_awesome_outlined, 'desc': 'Varanasi Gold Threading'},
  ];

  final List<Map<String, String>> _volumeTiers = [
    {
      'title': '10 - 50 pcs / order',
      'subtitle': 'Boutique & Sample Orders',
      'tag': 'Fast Turnaround',
    },
    {
      'title': '50 - 200 pcs / order',
      'subtitle': 'Retail Stores & Corporate Gifting',
      'tag': 'Most Popular',
    },
    {
      'title': '200 - 1,000+ pcs / order',
      'subtitle': 'Wholesale, Hospitality & Export Lots',
      'tag': 'Cluster Guild',
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategories = List.from(widget.model.selectedCategories);
    _volumeRequirement = widget.model.volumeRequirement ?? '50 - 200 pcs / order';
  }

  void _handleContinue() {
    widget.onContinue(widget.model.copyWith(
      selectedCategories: _selectedCategories,
      volumeRequirement: _volumeRequirement,
    ));
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
                    // Badge & Logo
                    Row(
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
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                      'Sourcing Preferences',
                      style: TextStyle(
                        color: _textDark,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'Select the GI craft categories and order volume your procurement team needs.',
                      style: TextStyle(
                        color: _textMuted,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 18.0),

                    // Section 1: Craft disciplines
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Craft Disciplines of Interest',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: _textDark),
                        ),
                        Text(
                          '${_selectedCategories.length} selected',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _primaryRust),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2.2,
                      ),
                      itemCount: _craftOptions.length,
                      itemBuilder: (context, index) {
                        final craft = _craftOptions[index];
                        final name = craft['name'] as String;
                        final isSelected = _selectedCategories.contains(name);

                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedCategories.remove(name);
                              } else {
                                _selectedCategories.add(name);
                              }
                            });
                          },
                          borderRadius: BorderRadius.circular(14),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFFFF6F0) : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected ? _primaryRust : const Color(0xFFEADFD6),
                                width: isSelected ? 1.6 : 1.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: isSelected ? _primaryRust : const Color(0xFFFAF5F0),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    craft['icon'] as IconData,
                                    size: 16,
                                    color: isSelected ? Colors.white : _primaryRust,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.w800,
                                          color: isSelected ? _primaryRust : _textDark,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        craft['desc'] as String,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 9.5, color: _textMuted),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 22.0),

                    // Section 2: Order volume tiers
                    const Text(
                      'Typical Order Volume per Procurement Cycle',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: _textDark),
                    ),
                    const SizedBox(height: 10.0),
                    ..._volumeTiers.map((tier) {
                      final isSelected = _volumeRequirement == tier['title'];

                      return InkWell(
                        onTap: () => setState(() => _volumeRequirement = tier['title']!),
                        borderRadius: BorderRadius.circular(14),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFFFFF6F0) : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected ? _primaryRust : const Color(0xFFEADFD6),
                              width: isSelected ? 1.6 : 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                                color: isSelected ? _primaryRust : const Color(0xFFBCAAA4),
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tier['title']!,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color: isSelected ? _primaryRust : _textDark,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      tier['subtitle']!,
                                      style: const TextStyle(fontSize: 11, color: _textMuted),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0xFFFBECE2) : const Color(0xFFF5F0EB),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  tier['tag']!,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: isSelected ? _primaryRust : const Color(0xFF6D4C41),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
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
        onPressed: widget.onBack,
      ),
      title: const Text(
        'Sourcing Preferences',
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
            '2 of 3',
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
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Step 2: Sourcing Preferences',
                style: TextStyle(
                  color: _primaryRust,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                '66% completed',
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
              widthFactor: 0.66,
              child: Container(color: _primaryRust),
            ),
          ),
        ),
      ],
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
                'Review Buyer Profile',
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
}
