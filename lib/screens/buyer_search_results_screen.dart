// lib/screens/buyer_search_results_screen.dart
// Screen d3: Bulk Buyer Search Results Screen
// 100% UI Match to 'd3 - bulk — Search Results.png'

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';

class BuyerSearchResultsScreen extends StatefulWidget {
  final String searchQuery;
  final VoidCallback? onBack;
  final VoidCallback? onViewArtisanProfile;
  final VoidCallback? onAddRequirement;
  final Function(int)? onTabChange;

  const BuyerSearchResultsScreen({
    super.key,
    this.searchQuery = 'Bamboo fruit baskets',
    this.onBack,
    this.onViewArtisanProfile,
    this.onAddRequirement,
    this.onTabChange,
  });

  @override
  State<BuyerSearchResultsScreen> createState() => _BuyerSearchResultsScreenState();
}

class _BuyerSearchResultsScreenState extends State<BuyerSearchResultsScreen> {
  int _currentNavIndex = 1;
  late TextEditingController _searchController;
  bool _filterActive = true;

  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFAF7F5);
  static const Color _cardBg = Colors.white;
  static const Color _borderSubtle = Color(0xFFEFE2D8);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);
  static const Color _successGreen = Color(0xFF2E7D32);

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchQuery);
  }

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
      appBar: _buildTopHeader(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar with back button & clear
              _buildSearchBarRow(),
              const SizedBox(height: 10),

              // Voice Prompt Suggestion
              _buildVoicePromptPill(),
              const SizedBox(height: 12),

              // Filter & Sort Pills
              _buildFilterSortRow(),
              const SizedBox(height: 6),

              // Result Count
              const Text(
                'Showing 24 verified artisan clusters & products',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _textMuted,
                ),
              ),
              const SizedBox(height: 14),

              // Result 1: Artisan Card (Ramesh Kumar)
              _buildArtisanClusterCard(),
              const SizedBox(height: 16),

              // Result 2: Product Card (Handwoven Natural Bamboo Fruit Basket)
              _buildProductResultCard(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildTopHeader() {
    return AppBar(
      backgroundColor: _bgCanvas,
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 28,
            height: 28,
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
                errorBuilder: (_, __, ___) => const Icon(Icons.storefront, size: 16, color: _primaryRust),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'HunarSangam',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF8C3A16),
                ),
              ),
              Text(
                'Bulk Buyer Portal',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: _textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () => _showSnack('Notifications'),
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
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildSearchBarRow() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5D7CD)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onBack,
            icon: const Icon(Icons.arrow_back, color: _textDark, size: 20),
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(32, 32),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: _textDark,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _searchController.clear();
              });
            },
            child: const Icon(Icons.close, color: Color(0xFF8C7A70), size: 18),
          ),
          const SizedBox(width: 8),
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: _primaryRust,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.mic, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildVoicePromptPill() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5EE),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF7DECD)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFFDEEE6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFF4CEBA)),
            ),
            child: Row(
              children: const [
                Icon(Icons.record_voice_over, size: 12, color: _primaryRust),
                SizedBox(width: 4),
                Text(
                  'Voice Prompt',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    color: _primaryRust,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Try saying: ',
            style: TextStyle(fontSize: 11, color: _textMuted),
          ),
          GestureDetector(
            onTap: () => _showSnack('Filter applied: Under ₹200'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFE5D7CD)),
              ),
              child: const Text(
                '"Filter under ₹200"',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  color: _textDark,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSortRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          // Filter button
          GestureDetector(
            onTap: () => setState(() => _filterActive = !_filterActive),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: _filterActive ? _primaryRust : Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: _filterActive ? _primaryRust : const Color(0xFFDCCDC2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.tune, size: 14, color: _filterActive ? Colors.white : _textDark),
                  const SizedBox(width: 5),
                  Text(
                    'Filter (2 active)',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: _filterActive ? Colors.white : _textDark,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Sort button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFDCCDC2)),
            ),
            child: Row(
              children: const [
                Icon(Icons.swap_vert, size: 14, color: _textDark),
                SizedBox(width: 4),
                Text(
                  'Sort: Recommended ⇅',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: _textDark,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Bamboo Craft pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFFFDEEE6),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFF7D9CB)),
            ),
            child: Row(
              children: const [
                Text(
                  'Bamboo Craft',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.bold,
                    color: _primaryRust,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.close, size: 14, color: _primaryRust),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtisanClusterCard() {
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
          // Image of Ramesh Kumar working with bamboo in workshop
          Stack(
            children: [
              SizedBox(
                height: 180,
                width: double.infinity,
                child: Image.network(
                  'https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=600&q=80',
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
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFA5D6A7)),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.verified, size: 12, color: _successGreen),
                      SizedBox(width: 4),
                      Text(
                        'GI Certified Cluster',
                        style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: _successGreen),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.volume_up, size: 14, color: _primaryRust),
                      SizedBox(width: 4),
                      Text(
                        'Craft Audio',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _primaryRust),
                      ),
                    ],
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
                const Text(
                  'CLUSTER LEAD • MASTER CRAFTSMAN',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                    color: _primaryRust,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Ramesh Kumar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: const [
                    Icon(Icons.location_on, size: 13, color: _textMuted),
                    SizedBox(width: 3),
                    Text(
                      'Barpeta Craft Cluster, Assam',
                      style: TextStyle(fontSize: 12, color: _textMuted),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Monthly Volume Box
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDEEE6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Monthly Volume: 500 pcs/month',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: _primaryRust,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                const Text(
                  'Craft: Split Bamboo Weaving & Baskets',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '28 years experience in eco-friendly bulk bamboo packaging and home storage. Specializes in kiln-treated, fungal-resistant split bamboo utility ware for hospitality and export packaging.',
                  style: TextStyle(fontSize: 11.5, color: _textMuted, height: 1.35),
                ),
                const SizedBox(height: 10),

                // Stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Batch Lead Time', style: TextStyle(fontSize: 10, color: _textMuted)),
                        Text('15–20 days', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _textDark)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text('Craft Makers Engaged', style: TextStyle(fontSize: 10, color: _textMuted)),
                        Text('32 Women Weavers', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _textDark)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Quality Audit
                Row(
                  children: const [
                    Icon(Icons.check_circle, size: 14, color: _successGreen),
                    SizedBox(width: 4),
                    Text(
                      'Passed GI Standard',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _successGreen),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Action Buttons: Inquire & View Profile
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showSnack('Starting inquiry with Ramesh Kumar'),
                        icon: const Icon(Icons.chat_bubble_outline, size: 14, color: _textDark),
                        label: const Text('Inquire', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _textDark)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFDCCDC2)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          minimumSize: const Size.fromHeight(42),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: widget.onViewArtisanProfile,
                        icon: const Icon(Icons.arrow_forward, size: 14),
                        label: const Text('View Profile', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryRust,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          minimumSize: const Size.fromHeight(42),
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

  Widget _buildProductResultCard() {
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
          // Image of bamboo baskets
          Stack(
            children: [
              SizedBox(
                height: 180,
                width: double.infinity,
                child: Image.network(
                  'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80',
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
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFA5D6A7)),
                  ),
                  child: const Text(
                    'Ready Stock Available',
                    style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: _successGreen),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'MOQ: 50 pcs',
                    style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.white),
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
                const Text(
                  'ASSAM HANDLOOM & HANDICRAFTS',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.6,
                    color: _primaryRust,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Handwoven Natural Bamboo Fruit Basket',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: const [
                    Icon(Icons.people, size: 13, color: _textMuted),
                    SizedBox(width: 4),
                    Text(
                      'Craft Maker: Ramesh Kumar Collective',
                      style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: _textDark),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Wholesale Rate line
                RichText(
                  text: const TextSpan(
                    text: 'Wholesale Rate ',
                    style: TextStyle(fontSize: 12, color: _textMuted),
                    children: [
                      TextSpan(
                        text: 'From ₹180',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: _primaryRust,
                        ),
                      ),
                      TextSpan(
                        text: ' / unit',
                        style: TextStyle(fontSize: 12, color: _textMuted),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Volume Tier Boxes
                Row(
                  children: [
                    _buildTierBox('50–200 pcs', '₹210', false),
                    const SizedBox(width: 6),
                    _buildTierBox('201–500 pcs', '₹195', false),
                    const SizedBox(width: 6),
                    _buildTierBox('500+ pcs', '₹180', true),
                  ],
                ),
                const SizedBox(height: 10),

                // Stock Info Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.inventory_2, size: 14, color: _primaryRust),
                        SizedBox(width: 4),
                        Text('Ready stock: ', style: TextStyle(fontSize: 11, color: _textMuted)),
                        Text('150 pcs', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _textDark)),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.precision_manufacturing, size: 14, color: _primaryRust),
                        SizedBox(width: 4),
                        Text('Custom batch: ', style: TextStyle(fontSize: 11, color: _textMuted)),
                        Text('Up to 1,000 pcs', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: _textDark)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Dual Buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: widget.onAddRequirement ?? () => _showSnack('Added 50 Bamboo Baskets to Requirements'),
                        icon: const Icon(Icons.assignment, size: 14, color: _textDark),
                        label: const Text('Add to Requirement', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: _textDark)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF5EBE1),
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          minimumSize: const Size.fromHeight(42),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: widget.onViewArtisanProfile,
                        icon: const Icon(Icons.north_east, size: 14),
                        label: const Text('View Product', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryRust,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          minimumSize: const Size.fromHeight(42),
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

  Widget _buildTierBox(String qty, String price, bool isBest) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        decoration: BoxDecoration(
          color: isBest ? const Color(0xFFFDEEE6) : const Color(0xFFFAF5F0),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: isBest ? const Color(0xFFF7D9CB) : const Color(0xFFEFE6DE)),
        ),
        child: Column(
          children: [
            Text(
              qty,
              style: const TextStyle(fontSize: 10, color: _textMuted),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 1),
            Text(
              price,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: isBest ? _primaryRust : _textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BuyerBottomNavBar(
      currentIndex: _currentNavIndex,
      onTap: (idx) {
        setState(() => _currentNavIndex = idx);
        widget.onTabChange?.call(idx);
        if (idx == 0) widget.onBack?.call();
      },
    );
  }
}
