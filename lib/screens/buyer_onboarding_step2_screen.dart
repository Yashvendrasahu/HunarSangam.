// lib/screens/buyer_onboarding_step2_screen.dart

import 'package:flutter/material.dart';
import '../models/buyer_onboarding_model.dart';

/// Screen: Bulk Buyer Registration - Step 2 of 3: Sourcing Preferences
/// Exactly matches 'bulk buyer step 2 register.png'
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
  late Set<String> _selectedCategoryIds;

  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFDFBF9);
  static const Color _borderSubtle = Color(0xFFE5D5CB);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);

  final List<Map<String, dynamic>> _categories = [
    {
      'id': 'home_decor',
      'title': 'Home Decor',
      'subtitle': '140+ Clusters',
      'icon': Icons.chair_outlined,
      'image': 'https://images.unsplash.com/photo-1584589167171-541ce45f1eea?auto=format&fit=crop&w=600&q=80',
    },
    {
      'id': 'bamboo_craft',
      'title': 'Bamboo Craft',
      'subtitle': 'GI Certified',
      'icon': Icons.forest_outlined,
      'image': 'https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=600&q=80',
    },
    {
      'id': 'textiles',
      'title': 'Textiles',
      'subtitle': 'Weaves & Prints',
      'icon': Icons.dry_cleaning_outlined,
      'image': 'https://images.unsplash.com/photo-1615865417491-9941019fbc00?auto=format&fit=crop&w=600&q=80',
    },
    {
      'id': 'pottery',
      'title': 'Pottery',
      'subtitle': 'Studio & Clay',
      'icon': Icons.water_drop_outlined,
      'image': 'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80',
    },
    {
      'id': 'wood_craft',
      'title': 'Wood Craft',
      'subtitle': 'Carvings & Toys',
      'icon': Icons.carpenter_outlined,
      'image': 'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?auto=format&fit=crop&w=600&q=80',
    },
    {
      'id': 'metal_craft',
      'title': 'Metal Craft',
      'subtitle': 'Brass & Dokra',
      'icon': Icons.hardware_outlined,
      'image': 'https://images.unsplash.com/photo-1610701596007-11502861dcfa?auto=format&fit=crop&w=600&q=80',
    },
    {
      'id': 'jewelry',
      'title': 'Jewelry',
      'subtitle': 'Silver & Beads',
      'icon': Icons.diamond_outlined,
      'image': 'https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=600&q=80',
    },
    {
      'id': 'other',
      'title': 'Other',
      'subtitle': 'Leather, Paper & Stone',
      'icon': Icons.more_horiz,
      'isOther': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    // Pre-select the 3 categories shown in the screenshot: Home Decor, Bamboo Craft, Pottery
    _selectedCategoryIds = {'home_decor', 'bamboo_craft', 'pottery'};
  }

  void _handleContinue() {
    final categoriesList = _selectedCategoryIds.map((id) {
      final match = _categories.firstWhere((c) => c['id'] == id, orElse: () => {'title': id});
      return match['title'] as String;
    }).toList();

    widget.onContinue(widget.model.copyWith(
      selectedCategories: categoriesList,
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
                    // Header section
                    const Text(
                      'What are you looking for?',
                      style: TextStyle(
                        color: _textDark,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'Choose the craft categories and order volumes you want to source directly from certified artisan clusters.',
                      style: TextStyle(
                        color: _textMuted,
                        fontSize: 12.5,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // Section Title with 3 Selected pill
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.category_outlined, size: 16, color: _primaryRust),
                            SizedBox(width: 6.0),
                            Text(
                              'Product Categories',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: _textDark,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            '${_selectedCategoryIds.length} Selected',
                            style: const TextStyle(
                              color: Color(0xFF2E7D32),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'Tap multiple categories to personalize your wholesale direct-sourcing feed.',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: _textMuted,
                      ),
                    ),
                    const SizedBox(height: 14.0),

                    // 8-item Category Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.88,
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                      ),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final item = _categories[index];
                        final isSelected = _selectedCategoryIds.contains(item['id']);
                        final isOther = item['isOther'] == true;

                        return InkWell(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedCategoryIds.remove(item['id']);
                              } else {
                                _selectedCategoryIds.add(item['id'] as String);
                              }
                            });
                          },
                          borderRadius: BorderRadius.circular(16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFFDF7F3) : Colors.white,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(
                                color: isSelected ? _primaryRust : _borderSubtle,
                                width: isSelected ? 1.5 : 1.0,
                                style: isOther ? BorderStyle.solid : BorderStyle.solid,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  blurRadius: 4,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: isOther
                                ? _buildOtherCard(item, isSelected)
                                : _buildImageCategoryCard(item, isSelected),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 18.0),

                    // Guarantee footnote
                    Row(
                      children: const [
                        Icon(Icons.verified_user_outlined, size: 14, color: Color(0xFF2E7D32)),
                        SizedBox(width: 6.0),
                        Expanded(
                          child: Text(
                            'Cluster verify guarantee: Direct from verified artisan guilds',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF5D4037),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
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

  Widget _buildImageCategoryCard(Map<String, dynamic> item, bool isSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image with top-right checkmark badge if selected
        Expanded(
          flex: 6,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15.0)),
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.network(
                    item['image'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFFFAF0E9),
                      child: Icon(item['icon'] as IconData, color: const Color(0xFF9C3C18), size: 32),
                    ),
                  ),
                ),
              ),
              if (isSelected)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: _primaryRust,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check, size: 13, color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
        // Title, Subtitle, Icon row
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(item['icon'] as IconData, size: 14, color: isSelected ? _primaryRust : const Color(0xFF5D4037)),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: Text(
                        item['title'] as String,
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: _textDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2.0),
                Text(
                  item['subtitle'] as String,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? _primaryRust : _textMuted,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOtherCard(Map<String, dynamic> item, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: Color(0xFFF4ECE5),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.more_horiz, size: 24, color: Color(0xFF8D6E63)),
        ),
        const SizedBox(height: 10.0),
        Text(
          item['title'] as String,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: _textDark,
          ),
        ),
        const SizedBox(height: 2.0),
        Text(
          item['subtitle'] as String,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 10.5,
            color: _textMuted,
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: _textDark, size: 22),
        onPressed: widget.onBack,
      ),
      centerTitle: true,
      title: Column(
        children: const [
          Text(
            'ONBOARDING',
            style: TextStyle(
              color: Color(0xFF8D6E63),
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          SizedBox(height: 2.0),
          Text(
            'Step 2 of 3',
            style: TextStyle(
              color: _primaryRust,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16.0),
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF7EFE9),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: const Color(0xFFEADFD6)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.storefront_outlined, size: 14, color: Color(0xFF5D4037)),
              SizedBox(width: 4.0),
              Text(
                'Bulk Buyer',
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
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: const Color(0xFFEFE8E2), height: 1.0),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Container(
      height: 3.5,
      color: const Color(0xFFEADFD6),
      child: Align(
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: 0.66,
          child: Container(color: _primaryRust),
        ),
      ),
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
                'Continue to Step 3',
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
}
