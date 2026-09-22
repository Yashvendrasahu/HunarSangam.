// lib/screens/buyer_featured_artisans_screen.dart
// Screen d4: Featured Master Artisans Screen
// 100% UI Match to 'd4 - bulk — Featured Artisans - pagr from discover page flow.png'

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';

class BuyerFeaturedArtisansScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onOpenArtisanProfile;
  final VoidCallback? onSendRequirement;
  final Function(int)? onTabChange;

  const BuyerFeaturedArtisansScreen({
    super.key,
    this.onBack,
    this.onOpenArtisanProfile,
    this.onSendRequirement,
    this.onTabChange,
  });

  @override
  State<BuyerFeaturedArtisansScreen> createState() => _BuyerFeaturedArtisansScreenState();
}

class _BuyerFeaturedArtisansScreenState extends State<BuyerFeaturedArtisansScreen> {
  int _currentNavIndex = 1;
  final TextEditingController _searchController = TextEditingController();

  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFAF7F5);
  static const Color _cardBg = Colors.white;
  static const Color _borderSubtle = Color(0xFFEFE2D8);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);
  static const Color _successGreen = Color(0xFF2E7D32);

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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Direct Cluster Procurement Badge
              _buildBadge(),
              const SizedBox(height: 6),

              // Title & Subtitle
              const Text(
                'Featured Master Craft Makers',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: _textDark,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Curated national awardees & high-capacity cluster leads ready for bulk contracts.',
                style: TextStyle(fontSize: 12.5, color: _textMuted, height: 1.35),
              ),
              const SizedBox(height: 14),

              // Search & Filter Row
              _buildSearchFilterRow(),
              const SizedBox(height: 18),

              // Artisan 1: Ramesh Kumar
              _buildArtisanCard(
                name: 'Ramesh Kumar',
                subtitle: 'Master Craftsman (Bamboo Craft & Cane)',
                location: 'Barpeta, Assam',
                experience: '28 Years Experience',
                imageUrl: 'https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=600&q=80',
                badges: [
                  {'label': 'GI Cluster Lead', 'color': _successGreen, 'bg': const Color(0xFFE8F5E9), 'icon': Icons.verified},
                  {'label': '32 Weavers Network', 'color': const Color(0xFF6A4028), 'bg': const Color(0xFFF3ECE4), 'icon': Icons.people},
                ],
                audioText: 'Listen to Craft Maker (Assamese/Hindi)  0:42',
                stat1Label: 'Production Capacity',
                stat1Value: '500 pcs/month',
                stat2Label: 'Bulk Order Lead Time',
                stat2Value: '18–24 Days',
                specialties: ['Ergonomic bamboo baskets', 'Fruit hampers', 'Corporate event storage'],
                onViewProfile: widget.onOpenArtisanProfile,
                onSendReq: widget.onSendRequirement ?? () => _showSnack('Posting requirement to Ramesh Kumar'),
              ),
              const SizedBox(height: 18),

              // Artisan 2: Mohan Lal
              _buildArtisanCard(
                name: 'Mohan Lal',
                subtitle: 'Master Ceramist (Jaipur Blue Pottery)',
                location: 'Kot Jewar, Rajasthan',
                experience: '22 Years Experience',
                imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=600&q=80',
                badges: [
                  {'label': 'State Awardee', 'color': const Color(0xFFD87D10), 'bg': const Color(0xFFFFF3E0), 'icon': Icons.emoji_events},
                  {'label': 'Lead-Free Certified', 'color': _successGreen, 'bg': const Color(0xFFE8F5E9), 'icon': Icons.check_circle},
                ],
                audioText: 'Listen to Craft Maker (Hindi/Rajasthani)  0:58',
                stat1Label: 'Production Capacity',
                stat1Value: '1,200 units/month',
                stat2Label: 'Export Packaging',
                stat2Value: 'Drop-tested crates',
                specialties: ['Ceramic tableware', 'Glazed planters', 'Bathroom sets'],
                onViewProfile: () => _showSnack('Viewing profile for Mohan Lal'),
                onSendReq: widget.onSendRequirement ?? () => _showSnack('Posting requirement to Mohan Lal'),
              ),
              const SizedBox(height: 18),

              // Artisan 3: Sunita Devi
              _buildArtisanCard(
                name: 'Sunita Devi',
                subtitle: 'Folk Artist & Master Weaver (Madhubani & Sikki Grass)',
                location: 'Madhubani, Bihar',
                experience: 'Collective Cluster',
                imageUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=600&q=80',
                badges: [
                  {'label': 'Women Self-Help Group Head (45 Craft Makers)', 'color': _successGreen, 'bg': const Color(0xFFE8F5E9), 'icon': Icons.groups},
                  {'label': '100% Organic Pigments', 'color': const Color(0xFFC2410C), 'bg': const Color(0xFFFFF7ED), 'icon': Icons.eco},
                ],
                audioText: 'Listen to Craft Maker (Maithili/Hindi)  0:35',
                stat1Label: 'Production Capacity',
                stat1Value: '400 pcs/month',
                stat2Label: 'Direct Cluster Impact',
                stat2Value: '45 Rural Livelihoods',
                specialties: ['Natural vegetable dye wall art', 'Utility boxes', 'Festive packaging'],
                onViewProfile: () => _showSnack('Viewing profile for Sunita Devi'),
                onSendReq: widget.onSendRequirement ?? () => _showSnack('Posting requirement to Sunita Devi'),
              ),
              const SizedBox(height: 28),
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
      titleSpacing: 12,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: _textDark),
        onPressed: widget.onBack,
      ),
      title: Row(
        children: [
          Container(
            width: 26,
            height: 26,
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
                errorBuilder: (_, __, ___) => const Icon(Icons.storefront, size: 14, color: _primaryRust),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'HunarSangam',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF8C3A16),
            ),
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

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFDEEE6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF7D9CB)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.workspace_premium, size: 13, color: _primaryRust),
          SizedBox(width: 4),
          Text(
            'Direct Cluster Procurement',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: _primaryRust,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchFilterRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE5D7CD)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.search, color: Color(0xFF8C7A70), size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(fontSize: 13, color: _textDark),
                    decoration: const InputDecoration(
                      hintText: 'Search craft, cluster or state...',
                      hintStyle: TextStyle(fontSize: 12.5, color: Color(0xFF8C7A70)),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5D7CD)),
          ),
          child: Row(
            children: const [
              Icon(Icons.tune, size: 16, color: _textDark),
              SizedBox(width: 4),
              Text(
                'Filters',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _textDark),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildArtisanCard({
    required String name,
    required String subtitle,
    required String location,
    required String experience,
    required String imageUrl,
    required List<Map<String, dynamic>> badges,
    required String audioText,
    required String stat1Label,
    required String stat1Value,
    required String stat2Label,
    required String stat2Value,
    required List<String> specialties,
    required VoidCallback? onViewProfile,
    required VoidCallback onSendReq,
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
          // Image with location and experience overlay
          Stack(
            children: [
              SizedBox(
                height: 180,
                width: double.infinity,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: const Color(0xFFF3ECE4)),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on, size: 12, color: Colors.white),
                      const SizedBox(width: 3),
                      Text(
                        location,
                        style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9C3C18).withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    experience,
                    style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.white),
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
                // Badges row
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: badges.map((badge) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: badge['bg'] as Color,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(badge['icon'] as IconData, size: 12, color: badge['color'] as Color),
                          const SizedBox(width: 3),
                          Text(
                            badge['label'] as String,
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                              color: badge['color'] as Color,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),

                // Name & Subtitle
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: _primaryRust,
                  ),
                ),
                const SizedBox(height: 10),

                // Audio Bar
                GestureDetector(
                  onTap: () => _showSnack('Playing audio intro for $name'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDEEE6),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFF7D9CB)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.volume_up, size: 16, color: _primaryRust),
                        const SizedBox(width: 6),
                        const Icon(Icons.mic, size: 14, color: _primaryRust),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            audioText,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5C2B14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Two-column Stat Box
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF5F0),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFEFE6DE)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(stat1Label, style: const TextStyle(fontSize: 10.5, color: _textMuted)),
                            const SizedBox(height: 2),
                            Text(
                              stat1Value,
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w900,
                                color: _primaryRust,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 30, color: const Color(0xFFE5D7CD)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(stat2Label, style: const TextStyle(fontSize: 10.5, color: _textMuted)),
                            const SizedBox(height: 2),
                            Text(
                              stat2Value,
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w900,
                                color: _textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // SPECIALTIES & BULK CATALOG
                const Text(
                  'SPECIALTIES & BULK CATALOG',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.6,
                    color: _textMuted,
                  ),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: specialties.map((spec) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE5D7CD)),
                      ),
                      child: Text(
                        spec,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _textDark,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 14),

                // Action buttons: View Artisan Profile & Send Requirement
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: onViewProfile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryRust,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        minimumSize: const Size.fromHeight(42),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('View Craft Maker Profile', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Icon(Icons.arrow_forward, size: 16),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      onPressed: onSendReq,
                      icon: const Icon(Icons.assignment, size: 15, color: _textDark),
                      label: const Text('Send Requirement', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: _textDark)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFDCCDC2)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        minimumSize: const Size.fromHeight(40),
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
