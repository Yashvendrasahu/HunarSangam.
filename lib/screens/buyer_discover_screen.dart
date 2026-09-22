// lib/screens/buyer_discover_screen.dart
// Screen d1: Bulk Buyer Discover Screen
// 100% UI Match to 'd1 - bulk- Discover.png'

import 'package:flutter/material.dart';
import '../models/buyer_onboarding_model.dart';
import '../widgets/buyer_bottom_nav_bar.dart';

class BuyerDiscoverScreen extends StatefulWidget {
  final BuyerOnboardingModel? model;
  final VoidCallback? onBack;
  final VoidCallback? onOpenSearch;
  final VoidCallback? onOpenFeaturedArtisans;
  final VoidCallback? onOpenArtisanProfile;
  final VoidCallback? onOpenBusinessSourcing;
  final Function(int)? onTabChange;

  const BuyerDiscoverScreen({
    super.key,
    this.model,
    this.onBack,
    this.onOpenSearch,
    this.onOpenFeaturedArtisans,
    this.onOpenArtisanProfile,
    this.onOpenBusinessSourcing,
    this.onTabChange,
  });

  @override
  State<BuyerDiscoverScreen> createState() => _BuyerDiscoverScreenState();
}

class _BuyerDiscoverScreenState extends State<BuyerDiscoverScreen> {
  int _currentNavIndex = 1; // 1 = Discover tab active
  final TextEditingController _searchController = TextEditingController();

  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFAF7F5);
  static const Color _cardBg = Colors.white;
  static const Color _borderSubtle = Color(0xFFEFE2D8);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);
  static const Color _successGreen = Color(0xFF2E7D32);
  static const Color _peachLight = Color(0xFFFDEEE6);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: const Color(0xFF2D2421),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgCanvas,
      appBar: _buildTopAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Input Bar with Microphone
              _buildSearchInputBar(),
              const SizedBox(height: 20),

              // Section 1: Craft Categories
              _buildCraftCategoriesSection(),
              const SizedBox(height: 28),

              // Section 2: Featured Master Artisans
              _buildFeaturedMasterArtisansSection(),
              const SizedBox(height: 28),

              // Section 3: Popular Bulk Crafts
              _buildPopularBulkCraftsSection(),
              const SizedBox(height: 28),

              // Section 4: Popular Business Sourcing
              _buildPopularBusinessSourcingSection(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildTopAppBar() {
    return AppBar(
      backgroundColor: _bgCanvas,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: Row(
        children: [
          // Logo symbol
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE8DDD5)),
            ),
            padding: const EdgeInsets.all(2),
            child: ClipOval(
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const Icon(Icons.storefront, size: 18, color: _primaryRust),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'HunarSangam',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFF8C3A16),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFFDEEE6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFF5D6C6)),
            ),
            child: const Text(
              'Bulk Buyer',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: _primaryRust,
              ),
            ),
          ),
        ],
      ),
      actions: [
        // Language
        IconButton(
          onPressed: () => _showSnack('Language: English / Hindi'),
          icon: const Icon(Icons.translate, size: 20, color: Color(0xFF4A3830)),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            shape: const CircleBorder(),
            side: const BorderSide(color: Color(0xFFE5D7CD)),
          ),
        ),
        // Notifications with dot
        Stack(
          children: [
            IconButton(
              onPressed: () => _showSnack('2 new cluster updates available'),
              icon: const Icon(Icons.notifications_outlined, size: 20, color: Color(0xFF4A3830)),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const CircleBorder(),
                side: const BorderSide(color: Color(0xFFE5D7CD)),
              ),
            ),
            Positioned(
              top: 10,
              right: 12,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: Color(0xFFE65100),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        // Avatar
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 4),
          child: GestureDetector(
            onTap: () => _showSnack('Bulk Buyer Account'),
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFDFCFC4), width: 1.5),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchInputBar() {
    return GestureDetector(
      onTap: widget.onOpenSearch,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE5D7CD)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            const Icon(Icons.search, color: Color(0xFF8C7A70), size: 20),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Search craft makers, crafts or products...',
                style: TextStyle(
                  color: Color(0xFF8C7A70),
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: widget.onOpenSearch,
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: _primaryRust,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.mic, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCraftCategoriesSection() {
    final categories = [
      {
        'title': 'Pottery & Ceramics',
        'count': '340+ Craft Makers',
        'image': 'https://images.unsplash.com/photo-1565193566173-7a0ee3dbe261?auto=format&fit=crop&w=300&q=80',
      },
      {
        'title': 'Handloom & Textiles',
        'count': '510+ Craft Makers',
        'image': 'https://images.unsplash.com/photo-1606760227091-3dd870d97f1d?auto=format&fit=crop&w=300&q=80',
      },
      {
        'title': 'Bamboo & Cane',
        'count': '190+ Craft Makers',
        'image': 'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=300&q=80',
      },
      {
        'title': 'Woodcraft & Toys',
        'count': '260+ Craft Makers',
        'image': 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&w=300&q=80',
      },
      {
        'title': 'Metal & Dokra',
        'count': '140+ Craft Makers',
        'image': 'https://images.unsplash.com/photo-1610701596007-11502861dcfa?auto=format&fit=crop&w=300&q=80',
      },
      {
        'title': 'Leather & Tribal',
        'count': '115+ Craft Makers',
        'image': 'https://images.unsplash.com/photo-1549465220-1a8b9238cd48?auto=format&fit=crop&w=300&q=80',
      },
      {
        'title': 'Jewellery',
        'count': '180+ Craft Makers',
        'image': 'https://images.unsplash.com/photo-1535632066927-ab7c9ab60908?auto=format&fit=crop&w=300&q=80',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Craft Categories',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: _textDark,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Procure directly across verified craft maker domains',
                  style: TextStyle(fontSize: 11.5, color: _textMuted),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => _showSnack('Browsing all 28 craft categories'),
              child: const Text(
                'View All >',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: _primaryRust,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Grid of first 6 items
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.5,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            final cat = categories[index];
            return _buildCategoryCard(cat);
          },
        ),
        const SizedBox(height: 10),
        // 7th category: Jewellery (centered)
        Center(
          child: SizedBox(
            width: (MediaQuery.of(context).size.width - 42) / 2,
            height: ((MediaQuery.of(context).size.width - 42) / 2) / 1.5,
            child: _buildCategoryCard(categories[6]),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(Map<String, String> cat) {
    return GestureDetector(
      onTap: () {
        if (cat['title'] == 'Bamboo & Cane') {
          widget.onOpenSearch?.call();
        } else {
          _showSnack('Selected category: ${cat['title']}');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _borderSubtle),
          boxShadow: const [
            BoxShadow(
              color: Color(0x06000000),
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFF6ECE4),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                cat['image']!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.category, color: _primaryRust),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              cat['title']!,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: _textDark,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 1),
            Text(
              cat['count']!,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: _textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedMasterArtisansSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Featured Master Craft Makers',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                          color: _textDark,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.verified, size: 16, color: _successGreen),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Verified producers ready for enterprise contracts & large batch orders',
                    style: TextStyle(fontSize: 11.5, color: _textMuted),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _buildCircleIconButton(Icons.arrow_back_ios_new, () => widget.onOpenFeaturedArtisans?.call()),
                const SizedBox(width: 6),
                _buildCircleIconButton(Icons.arrow_forward_ios, () => widget.onOpenFeaturedArtisans?.call()),
              ],
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Artisan Card 1: Ramesh Kumar
        _buildArtisanCard(
          name: 'Ramesh Kumar',
          craft: 'Bamboo Craft & Utility',
          location: 'Barpeta, Assam',
          imageUrl: 'https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=200&q=80',
          monthlyCapacity: '500 pcs/mo',
          leadTime: '5 business days',
          specialty: 'FSC Certified Bamboo',
          onViewArtisan: widget.onOpenArtisanProfile,
          audioDuration: '0:42',
        ),
        const SizedBox(height: 12),

        // Artisan Card 2: Mohan Lal
        _buildArtisanCard(
          name: 'Mohan Lal',
          craft: 'Jaipur Blue Pottery',
          location: 'Jaipur, Rajasthan',
          imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=200&q=80',
          monthlyCapacity: '1,200 pcs/mo',
          leadTime: '4 business days',
          specialty: 'Lead-free Food Grade',
          onViewArtisan: widget.onOpenFeaturedArtisans,
          audioDuration: '0:58',
        ),
        const SizedBox(height: 12),

        // Artisan Card 3: Sunita Devi
        _buildArtisanCard(
          name: 'Sunita Devi',
          craft: 'Madhubani Art & Decor',
          location: 'Madhubani, Bihar',
          imageUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=200&q=80',
          monthlyCapacity: '350 pcs/mo',
          leadTime: '6 business days',
          specialty: 'Organic Plant Dyes',
          onViewArtisan: widget.onOpenFeaturedArtisans,
          audioDuration: '1:05',
        ),
      ],
    );
  }

  Widget _buildCircleIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFF3ECE4),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE5D8CD)),
        ),
        child: Icon(icon, size: 12, color: _textDark),
      ),
    );
  }

  Widget _buildArtisanCard({
    required String name,
    required String craft,
    required String location,
    required String imageUrl,
    required String monthlyCapacity,
    required String leadTime,
    required String specialty,
    required VoidCallback? onViewArtisan,
    required String audioDuration,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderSubtle),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color(0xFFF3ECE4),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.person, color: _primaryRust),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: _successGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, size: 10, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: _textDark,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      craft,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _primaryRust,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 12, color: _textMuted),
                        const SizedBox(width: 2),
                        Text(
                          location,
                          style: const TextStyle(fontSize: 11, color: _textMuted),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Specs container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF5F0),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFEFE6DE)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Monthly Bulk Capacity:', style: TextStyle(fontSize: 11, color: _textMuted)),
                    Text(monthlyCapacity, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _textDark)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Avg. Sample Lead Time:', style: TextStyle(fontSize: 11, color: _textMuted)),
                    Text(leadTime, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _textDark)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Specialty:', style: TextStyle(fontSize: 11, color: _textMuted)),
                    Text(specialty, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _successGreen)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Action Buttons: View Artisan + Audio button
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onViewArtisan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryRust,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    minimumSize: const Size.fromHeight(40),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text(
                    'View Craft Maker',
                    style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () => _showSnack('Playing audio intro by $name ($audioDuration)'),
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: 44,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDEEE6),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFF7D9CB)),
                  ),
                  child: const Icon(Icons.volume_up, color: _primaryRust, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPopularBulkCraftsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Popular Bulk Crafts',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: _textDark,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Pre-negotiated cluster pricing with reliable volume fulfillment',
                  style: TextStyle(fontSize: 11.5, color: _textMuted),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => _showSnack('Opening Wholesale Catalog'),
              child: const Text(
                'Explore Catalog >',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: _primaryRust,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Craft 1: Stoneware & Terracotta Dinnerware
        _buildBulkCraftCard(
          title: 'Stoneware & Terracotta Dinnerware',
          description: 'Lead-free, microwave-safe handcrafted tableware crafted by village pottery guilds.',
          cluster: 'Khurja Cluster, UP',
          tag: 'Ready to Ship',
          tagColor: _successGreen,
          imageUrl: 'https://images.unsplash.com/photo-1615486511484-92e172cc4fe0?auto=format&fit=crop&w=500&q=80',
          tierLabel: '50–200 pcs',
          tierPrice: '₹320',
          onChat: () => _showSnack('Opening chat with Khurja Pottery Guild'),
          onQuote: () => _showSnack('Requesting bulk quote for Stoneware Dinnerware'),
        ),
        const SizedBox(height: 14),

        // Craft 2: Dabu & Bagru Block Print Throws
        _buildBulkCraftCard(
          title: 'Dabu & Bagru Block Print Throws',
          description: '100% organic cotton, natural indigo & harda dyes using heritage carved teak wood blocks.',
          cluster: 'Bagru Cluster, Rajasthan',
          tag: 'Verified GI',
          tagColor: _successGreen,
          imageUrl: 'https://images.unsplash.com/photo-1606760227091-3dd870d97f1d?auto=format&fit=crop&w=500&q=80',
          tierLabel: '30–100 pcs',
          tierPrice: '₹680',
          onChat: () => _showSnack('Opening chat with Bagru Block Print Collective'),
          onQuote: () => _showSnack('Requesting bulk quote for Block Print Throws'),
        ),
        const SizedBox(height: 14),

        // Craft 3: Hammered Brass Dining Vessels
        _buildBulkCraftCard(
          title: 'Hammered Brass Dining Vessels',
          description: 'Pure bell metal and virgin brass hammered by master metal beaters with food-safe tin lining.',
          cluster: 'Moradabad, UP',
          tag: 'Export Tier',
          tagColor: const Color(0xFF1565C0),
          imageUrl: 'https://images.unsplash.com/photo-1610701596007-11502861dcfa?auto=format&fit=crop&w=500&q=80',
          tierLabel: '40–150 pcs',
          tierPrice: '₹850',
          onChat: () => _showSnack('Opening chat with Moradabad Brass Cluster'),
          onQuote: () => _showSnack('Requesting bulk quote for Brass Dining Vessels'),
        ),
      ],
    );
  }

  Widget _buildBulkCraftCard({
    required String title,
    required String description,
    required String cluster,
    required String tag,
    required Color tagColor,
    required String imageUrl,
    required String tierLabel,
    required String tierPrice,
    required VoidCallback onChat,
    required VoidCallback onQuote,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderSubtle),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with cluster and status tag
          Stack(
            children: [
              SizedBox(
                height: 160,
                width: double.infinity,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: const Color(0xFFF3ECE4)),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on, size: 12, color: _primaryRust),
                      const SizedBox(width: 3),
                      Text(
                        cluster,
                        style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: _textDark),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFA5D6A7)),
                  ),
                  child: Text(
                    tag,
                    style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: tagColor),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: _textDark),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 11.5, color: _textMuted, height: 1.35),
                ),
                const SizedBox(height: 12),

                // Bulk Price Tier Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF5F0),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFEFE6DE)),
                  ),
                  child: Column(
                    children: [
                      const Text('Bulk Price Tiers:', style: TextStyle(fontSize: 10.5, color: _textMuted)),
                      const SizedBox(height: 2),
                      Text(
                        '$tierLabel\n$tierPrice',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _textDark),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Dual buttons: Chat with him + Bulk Quote
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onChat,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFDCCDC2)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          minimumSize: const Size.fromHeight(40),
                        ),
                        child: const Text('chat with him', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _textDark)),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onQuote,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryRust,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          minimumSize: const Size.fromHeight(40),
                        ),
                        child: const Text('Bulk Quote', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
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

  Widget _buildPopularBusinessSourcingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: widget.onOpenBusinessSourcing,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Popular Business Sourcing',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: _textDark,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Turnkey curated bundles designed for enterprise gifting, hospitality, and seasonal retail',
                      style: TextStyle(fontSize: 11.5, color: _textMuted),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 14, color: _primaryRust),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Bundle 1: Corporate Gifting Sets
        _buildBusinessSourcingCard(
          title: 'Corporate Gifting Sets',
          tag: 'Custom Branding Available',
          description: 'Curated artisanal desk essentials, handmade notebooks, brass penholders, and tea-light accents packed in recycled handmade box packaging.',
          tier: 'Bulk Tier (100 – 500 sets): ₹799 / set',
          imageUrl: 'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&w=500&q=80',
          buttonText: 'Inquire Bulk Gifting',
          onInquire: widget.onOpenBusinessSourcing ?? () => _showSnack('Inquiring Corporate Gifting Sets'),
        ),
        const SizedBox(height: 14),

        // Bundle 2: Eco-friendly Hospitality Amenities
        _buildBusinessSourcingCard(
          title: 'Eco-friendly Hospitality Amenities',
          tag: 'Zero Plastic / Compostable',
          description: 'Terracotta liquid soap dispensers, water carafes, woven bamboo guest trays, and organic handwoven linen laundry bags for boutique resorts.',
          tier: 'Bulk Tier (200 – 1000 units): ₹420 / kit',
          imageUrl: 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=500&q=80',
          buttonText: 'Inquire Hospitality Kits',
          onInquire: widget.onOpenBusinessSourcing ?? () => _showSnack('Inquiring Hospitality Amenities'),
        ),
        const SizedBox(height: 14),

        // Bundle 3: Festive Retail Hampers
        _buildBusinessSourcingCard(
          title: 'Festive Retail Hampers',
          tag: 'Diwali & Festive Ready',
          description: 'Hand-painted terracotta diyas, organic dry-fruit earthen pots, brass decorative torans, and handmade seed paper festive cards for retail chains.',
          tier: 'Bulk Tier (250 – 800 hampers): ₹950 / box',
          imageUrl: 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&w=500&q=80',
          buttonText: 'Inquire Festive Hampers',
          onInquire: widget.onOpenBusinessSourcing ?? () => _showSnack('Inquiring Festive Hampers'),
        ),
      ],
    );
  }

  Widget _buildBusinessSourcingCard({
    required String title,
    required String tag,
    required String description,
    required String tier,
    required String imageUrl,
    required String buttonText,
    required VoidCallback onInquire,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _borderSubtle),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: const Color(0xFFF3ECE4)),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: _textDark)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(fontSize: 11.5, color: _textMuted, height: 1.35)),
                const SizedBox(height: 10),

                // Bulk tier pricing line
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF5F0),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFEFE6DE)),
                  ),
                  child: Text(
                    tier,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: _primaryRust),
                  ),
                ),
                const SizedBox(height: 12),

                ElevatedButton(
                  onPressed: onInquire,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryRust,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    minimumSize: const Size.fromHeight(40),
                  ),
                  child: Text(buttonText, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BuyerBottomNavBar(
      currentIndex: _currentNavIndex,
      onTap: (idx) {
        setState(() => _currentNavIndex = idx);
        widget.onTabChange?.call(idx);
        if (idx == 0) {
          widget.onBack?.call();
        } else if (idx == 2) {
          _showSnack('Opening Requirements');
        } else if (idx == 3) {
          _showSnack('Opening Orders');
        } else if (idx == 4) {
          _showSnack('Opening Profile');
        }
      },
    );
  }
}
