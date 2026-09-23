// lib/add_product/screens/product_catalog_screen.dart

import 'package:flutter/material.dart';
import '../models/product_draft.dart';
import '../widgets/artisan_bottom_navigation.dart';
import '../../widgets/craft_image.dart';
import '../../utils/craft_assets.dart';

/// Screen 1: Matches 'ar--p1-Artisan Product Catalog.png'
/// Displays artisan cluster status, 4 key metrics, "Add products by clicking 🎙️" CTA,
/// search bar, filter tabs, and the full catalog of artisan products with ONDC & GI badges.
class ProductCatalogScreen extends StatefulWidget {
  final ProductDraft draft;
  final VoidCallback onStartAddProduct;
  final Function(int)? onNavigateTab;
  final String currentLanguage;

  const ProductCatalogScreen({
    super.key,
    required this.draft,
    required this.onStartAddProduct,
    this.onNavigateTab,
    this.currentLanguage = 'English',
  });

  @override
  State<ProductCatalogScreen> createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  int _selectedFilterIndex = 0;
  String _selectedLanguage = 'English';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'All (8)',
    'Published (6)',
    'ONDC Synced (5)',
    'Drafts (2)',
  ];

  @override
  void initState() {
    super.initState();
    _selectedLanguage = widget.currentLanguage;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Top App Bar
                _buildTopAppBar(),

                // Scrollable catalog body
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header card: "My Products" + Assam Cluster + Ramu Kumar Verified
                        _buildClusterCard(),

                        const SizedBox(height: 12.0),

                        // 4 Stat Cards in 2x2 grid
                        _buildStatsGrid(),

                        const SizedBox(height: 14.0),

                        // Primary Pill CTA: "Add products ➔" with mic circle
                        _buildAddProductButton(),

                        const SizedBox(height: 12.0),

                        // Voice Search Input Bar
                        _buildSearchBar(),

                        const SizedBox(height: 12.0),

                        // Filter tabs row
                        _buildFilterTabs(),

                        const SizedBox(height: 14.0),

                        // Product Cards
                        if (widget.draft.isPublished || (widget.draft.photoUrl.isNotEmpty && widget.draft.title.isNotEmpty))
                          _buildCardWrapper(
                            imageUrl: widget.draft.photoUrl,
                            badgeText: 'Active • ONDC Ready',
                            badgeColor: const Color(0xFF2E7D32),
                            sizeText: 'Size: ${widget.draft.diameterIn.toStringAsFixed(1)}" × ${widget.draft.heightIn.toStringAsFixed(1)}"',
                            title: widget.draft.title,
                            subtitle: 'GI Tag: ${widget.draft.giCluster} (${widget.draft.giRegNumber})',
                            price: '₹${widget.draft.basePrice.toInt()}',
                            unit: '/ piece',
                            moqText: 'Wholesale MOQ: ${widget.draft.dailyCapacityPcs > 0 ? widget.draft.dailyCapacityPcs : 20} pcs',
                            views: '12 Views (New)',
                            inquiries: 'Just Listed',
                            stock: '${widget.draft.dailyCapacityPcs * 5} in Stock',
                            hasAudio: widget.draft.voiceClipTranscription.isNotEmpty,
                          ),
                        if (widget.draft.isPublished || (widget.draft.photoUrl.isNotEmpty && widget.draft.title.isNotEmpty))
                          const SizedBox(height: 14.0),
                        _buildProductCard1(),
                        const SizedBox(height: 14.0),
                        _buildProductCard2(),
                        const SizedBox(height: 14.0),
                        _buildProductCard3(),
                        const SizedBox(height: 14.0),
                        _buildProductCard4(),
                        const SizedBox(height: 80.0), // Space for floating CTA
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Floating Pill: "+ Add Product (Voice-First 🎙)"
            Positioned(
              left: 0,
              right: 0,
              bottom: 16.0,
              child: Center(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: widget.onStartAddProduct,
                    borderRadius: BorderRadius.circular(28.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8C3A16),
                        borderRadius: BorderRadius.circular(28.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF8C3A16).withValues(alpha: 0.35),
                            blurRadius: 10.0,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.mic_rounded, color: Colors.white, size: 18.0),
                          SizedBox(width: 6.0),
                          Text(
                            '+ Add Product (Voice-First 🎙)',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ArtisanBottomNavigation(
        currentIndex: 1, // Products tab active
        onTap: widget.onNavigateTab,
      ),
    );
  }

  // 1. Top App Bar
  Widget _buildTopAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo + HunarSangam
          Row(
            children: [
              Container(
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF9),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color(0xFFE5D5CB), width: 1.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (ctx, err, stack) => const Center(
                    child: Text(
                      'हुनर',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF7C3F24),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              const Text(
                'HunarSangam',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF7C3F24),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),

          // Right Controls: Language, Notification, Avatar
          Row(
            children: [
              // Language pill
              PopupMenuButton<String>(
                onSelected: (val) {
                  setState(() {
                    _selectedLanguage = val;
                  });
                },
                itemBuilder: (ctx) => [
                  const PopupMenuItem(value: 'English', child: Text('English')),
                  const PopupMenuItem(value: 'Hindi', child: Text('हिंदी / Hindi')),
                  const PopupMenuItem(value: 'Assamese', child: Text('অসমীয়া / Assamese')),
                  const PopupMenuItem(value: 'Bengali', child: Text('বাংলা / Bengali')),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E7DF),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: const Color(0xFFE5D5CB)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedLanguage,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4A372D),
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      const Icon(Icons.arrow_drop_down, size: 16.0, color: Color(0xFF7B665C)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10.0),

              // Notification bell with red badge
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(7.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF2EC),
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFE5D5CB)),
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      size: 20.0,
                      color: Color(0xFF4A372D),
                    ),
                  ),
                  Positioned(
                    top: 5.0,
                    right: 6.0,
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFC53030),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10.0),

              // Avatar with live workshop green dot
              Stack(
                children: [
                  Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFEADFD6),
                      border: Border.all(color: const Color(0xFFD5C4B8), width: 1.5),
                    ),
                    child: const Center(
                      child: Text(
                        'RK',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF7C3F24),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D32),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 2. Cluster Card
  Widget _buildClusterCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDFB),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'My Products',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF221C19),
                  letterSpacing: -0.4,
                ),
              ),
              SizedBox(width: 8.0),
              Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 16.0),
              SizedBox(width: 4.0),
              Text(
                'Assam Cane & Bamboo Cluster',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B584E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8.0,
                    height: 8.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2E7D32),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  const Text(
                    'Ramu Kumar • Workshop Live Status',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A372D),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFD1F2D9),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text(
                  'Verified Artisan',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E6B24),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 3. Stats Grid (2x2)
  Widget _buildStatsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatItem(
                icon: Icons.inventory_2_outlined,
                iconColor: const Color(0xFFE87338),
                iconBg: const Color(0xFFFFE8DC),
                value: '8 Crafts',
                label: 'Total\nPublished',
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: _buildStatItem(
                icon: Icons.storefront_outlined,
                iconColor: const Color(0xFF2E7D32),
                iconBg: const Color(0xFFE8F5E9),
                value: '5 Crafts',
                label: 'ONDC Live',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: _buildStatItem(
                icon: Icons.visibility_outlined,
                iconColor: const Color(0xFF6B584E),
                iconBg: const Color(0xFFF3E7DF),
                value: '1,420',
                label: 'Bulk Buyer Views',
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: _buildStatItem(
                icon: Icons.local_shipping_outlined,
                iconColor: const Color(0xFFD97706),
                iconBg: const Color(0xFFFEF3C7),
                value: '18',
                label: 'Bulk Inquiries',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String value,
    required String label,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDFB),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      child: Row(
        children: [
          Container(
            width: 38.0,
            height: 38.0,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(icon, color: iconColor, size: 20.0),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF221C19),
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF7A685F),
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 4. Pill Action CTA: Add products
  Widget _buildAddProductButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onStartAddProduct,
        borderRadius: BorderRadius.circular(28.0),
        child: Container(
          width: double.infinity,
          height: 48.0,
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFBF2EE),
            borderRadius: BorderRadius.circular(28.0),
            border: Border.all(color: const Color(0xFFE5D5CB), width: 1.2),
          ),
          child: Row(
            children: [
              Container(
                width: 38.0,
                height: 38.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF7C3F24),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.mic_rounded, color: Colors.white, size: 20.0),
              ),
              const SizedBox(width: 14.0),
              const Expanded(
                child: Text(
                  'Add products',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF221C19),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: Icon(Icons.arrow_forward_rounded, color: Color(0xFF221C19), size: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 5. Search Bar with Mic and Filter
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFBF2EE),
        borderRadius: BorderRadius.circular(28.0),
        border: Border.all(color: const Color(0xFFE5D5CB), width: 1.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 38.0,
            height: 38.0,
            decoration: const BoxDecoration(
              color: Color(0xFF7C3F24),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.mic_rounded, color: Colors.white, size: 20.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: const TextStyle(fontSize: 13.5, color: Color(0xFF2D2421)),
              decoration: const InputDecoration(
                hintText: 'Tap to speak or search crafts...',
                hintStyle: TextStyle(fontSize: 13.0, color: Color(0xFF7A685F)),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.tune_rounded, color: Color(0xFF7A685F), size: 20.0),
            onPressed: () {},
            splashRadius: 20.0,
          ),
        ],
      ),
    );
  }

  // 6. Filter Tabs
  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(_filters.length, (index) {
          final isSelected = _selectedFilterIndex == index;
          final isOndc = index == 2;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFilterIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF8C3A16) : const Color(0xFFFFFDFB),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF8C3A16) : const Color(0xFFEADFD6),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isOndc && !isSelected) ...[
                      Container(
                        width: 6.0,
                        height: 6.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2E7D32),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5.0),
                    ],
                    Text(
                      _filters[index],
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? Colors.white : const Color(0xFF4A372D),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // 7. Product Card 1
  Widget _buildProductCard1() {
    return _buildCardWrapper(
      imageUrl: CraftAssets.bambooBasket,
      badgeText: 'Active • ONDC Ready',
      badgeColor: const Color(0xFF2E7D32),
      sizeText: 'Size: 12.4" × 6.2"',
      title: 'Handmade Woven Bamboo Fruit Basket',
      subtitle: 'GI Tag: Assam Cane & Bamboo Work (GI-429)',
      price: '₹280',
      unit: '/ piece',
      moqText: 'Wholesale MOQ: 20 pcs',
      views: '480 Views',
      inquiries: '8 Bulk Inquiries',
      stock: '140 in Stock',
      hasAudio: true,
    );
  }

  // 8. Product Card 2
  Widget _buildProductCard2() {
    return _buildCardWrapper(
      imageUrl: CraftAssets.bambooPlanter,
      badgeText: 'Active • ONDC Ready',
      badgeColor: const Color(0xFF2E7D32),
      sizeText: 'Size: 14" × 10"',
      title: 'Assam Golden Cane Planter Basket',
      subtitle: 'Natural Cane Weave • Water Resistant Finish',
      price: '₹420',
      unit: '/ piece',
      moqText: 'Wholesale MOQ: 15 pcs',
      views: '310 Views',
      inquiries: '4 Bulk Inquiries',
      stock: '65 in Stock',
      hasAudio: true,
    );
  }

  // 9. Product Card 3
  Widget _buildProductCard3() {
    return _buildCardWrapper(
      imageUrl: CraftAssets.bambooLamp,
      badgeText: 'Active • HunarSangam Live',
      badgeColor: const Color(0xFFA84318),
      sizeText: 'Size: 10" × 8"',
      title: 'Hand-plaited Bamboo Storage Box with Lid',
      subtitle: 'Durable Storage • Naturally Treated Cane',
      price: '₹350',
      unit: '/ piece',
      moqText: 'Wholesale MOQ: 25 pcs',
      views: '290 Views',
      inquiries: '3 Bulk Inquiries',
      stock: '90 in Stock',
      hasAudio: true,
    );
  }

  // 10. Product Card 4 (Draft)
  Widget _buildProductCard4() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDFB),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CraftImage(
                imageSource: CraftAssets.brassVase,
                craftCategoryOrTitle: 'Brass & Bell Metal',
                height: 140.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8.0,
                left: 8.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.circle, color: Color(0xFFD97706), size: 6.0),
                      SizedBox(width: 4.0),
                      Text(
                        'Draft (Need Photo Enhancer)',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 8.0,
                left: 8.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: const Text(
                    'Size: 4" dia',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Miniature Bamboo Tea Coaster Set (6 pcs)',
                  style: TextStyle(
                    fontSize: 15.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF221C19),
                  ),
                ),
                const SizedBox(height: 3.0),
                const Text(
                  'Listing incomplete • Add clear white studio background',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF7A685F),
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: const [
                        Text(
                          '₹180',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF8C3A16),
                          ),
                        ),
                        SizedBox(width: 3.0),
                        Text(
                          '/ set',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: Color(0xFF7A685F),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: const Color(0xFFFFE0B2)),
                      ),
                      child: const Text(
                        'Wholesale MOQ: 50 sets',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A372D),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: const [
                    Icon(Icons.visibility_outlined, size: 14.0, color: Color(0xFF7A685F)),
                    SizedBox(width: 4.0),
                    Text(
                      '0 Views',
                      style: TextStyle(fontSize: 11.0, color: Color(0xFF7A685F)),
                    ),
                    SizedBox(width: 12.0),
                    Icon(Icons.chat_bubble_outline_rounded, size: 13.0, color: Color(0xFF7A685F)),
                    SizedBox(width: 4.0),
                    Text(
                      '0 Inquiries',
                      style: TextStyle(fontSize: 11.0, color: Color(0xFF7A685F)),
                    ),
                    Spacer(),
                    Icon(Icons.warning_amber_rounded, size: 14.0, color: Color(0xFFD97706)),
                    SizedBox(width: 4.0),
                    Text(
                      'Needs Attention',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFD97706),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                SizedBox(
                  width: double.infinity,
                  height: 44.0,
                  child: ElevatedButton(
                    onPressed: widget.onStartAddProduct,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8C3A16),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.auto_awesome, size: 16.0),
                        SizedBox(width: 6.0),
                        Text(
                          'Enhance Photo with AI & Publish',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 6.0),
                        Icon(Icons.mic_rounded, size: 16.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardWrapper({
    required String imageUrl,
    required String badgeText,
    required Color badgeColor,
    required String sizeText,
    required String title,
    required String subtitle,
    required String price,
    required String unit,
    required String moqText,
    required String views,
    required String inquiries,
    required String stock,
    required bool hasAudio,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDFB),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CraftImage(
                imageSource: imageUrl,
                craftCategoryOrTitle: title,
                height: 150.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 8.0,
                left: 8.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle, color: badgeColor, size: 6.0),
                      const SizedBox(width: 4.0),
                      Text(
                        badgeText,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (hasAudio)
                Positioned(
                  top: 8.0,
                  right: 8.0,
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.volume_up_rounded, color: Colors.white, size: 16.0),
                  ),
                ),
              Positioned(
                bottom: 8.0,
                left: 8.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    sizeText,
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF221C19),
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 3.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF7A685F),
                  ),
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF8C3A16),
                          ),
                        ),
                        const SizedBox(width: 3.0),
                        Text(
                          unit,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Color(0xFF7A685F),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3E0),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: const Color(0xFFFFE0B2)),
                      ),
                      child: Text(
                        moqText,
                        style: const TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A372D),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    const Icon(Icons.visibility_outlined, size: 14.0, color: Color(0xFF7A685F)),
                    const SizedBox(width: 4.0),
                    Text(
                      views,
                      style: const TextStyle(fontSize: 11.0, color: Color(0xFF7A685F)),
                    ),
                    const SizedBox(width: 12.0),
                    const Icon(Icons.chat_bubble_outline_rounded,
                        size: 13.0, color: Color(0xFF7A685F)),
                    const SizedBox(width: 4.0),
                    Text(
                      inquiries,
                      style: const TextStyle(fontSize: 11.0, color: Color(0xFF7A685F)),
                    ),
                    const Spacer(),
                    const Icon(Icons.inventory_2_outlined, size: 14.0, color: Color(0xFF2E7D32)),
                    const SizedBox(width: 4.0),
                    Text(
                      stock,
                      style: const TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: widget.onStartAddProduct,
                        icon: const Icon(Icons.mic_rounded, size: 15.0, color: Color(0xFF4A372D)),
                        label: const Text(
                          'Edit (Voice 🎙️)',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4A372D),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          side: const BorderSide(color: Color(0xFFE5D5CB)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: widget.onStartAddProduct,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          side: const BorderSide(color: Color(0xFFE5D5CB)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: const Text(
                          'View Details',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF4A372D),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
