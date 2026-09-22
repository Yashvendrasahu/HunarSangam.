// lib/screens/buyer_business_sourcing_screen.dart
// Screen d6: Popular Business Sourcing Screen
// 100% UI Match to 'd6 bulk— Popular Business Sourcing.png'

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';

class BuyerBusinessSourcingScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onOrderSample;
  final Function(String title)? onInquireLot;
  final Function(int)? onTabChange;

  const BuyerBusinessSourcingScreen({
    super.key,
    this.onBack,
    this.onOrderSample,
    this.onInquireLot,
    this.onTabChange,
  });

  @override
  State<BuyerBusinessSourcingScreen> createState() => _BuyerBusinessSourcingScreenState();
}

class _BuyerBusinessSourcingScreenState extends State<BuyerBusinessSourcingScreen> {
  int _currentNavIndex = 1;

  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFAF7F5);
  static const Color _cardBg = Colors.white;
  static const Color _borderSubtle = Color(0xFFEFE2D8);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);
  static const Color _successGreen = Color(0xFF2E7D32);

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
              // Curated Commercial B2B Catalog Badge
              _buildBadge(),
              const SizedBox(height: 8),

              // Title
              const Text(
                'Popular Business Sourcing',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: _textDark,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 4),

              // Subtitle
              const Text(
                'Turnkey handmade categories curated for wholesale buyers, hospitality & retail with standardized quality controls and cluster dispatch tracking.',
                style: TextStyle(fontSize: 12.5, color: _textMuted, height: 1.35),
              ),
              const SizedBox(height: 10),

              // Active Mode Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAE3DC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.circle, size: 8, color: _successGreen),
                    SizedBox(width: 6),
                    Text(
                      'Active Mode: Bulk Buyer',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _textDark),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),

              // Frequently Sourced Crafts Section
              const Text(
                'Frequently Sourced Crafts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: _textDark,
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                'High-cadence lines pre-calibrated for corporate gifting, hotel chains, and retail store networks.',
                style: TextStyle(fontSize: 12, color: _textMuted),
              ),
              const SizedBox(height: 14),

              // Craft Card 1: Corporate Gifting Sets
              _buildCraftCard(
                categoryTag: 'PREMIUM GIFTING',
                statusBadge: 'In Stock Fabric',
                statusColor: _successGreen,
                statusBg: const Color(0xFFE8F5E9),
                title: 'Corporate Gifting Sets',
                description: 'Bamboo pen stands, solid brass bookmark, and botanical diary nestled in hand-embossed recycled paper gift box.',
                price: '₹680',
                priceUnit: '/ set',
                moq: '100 sets',
                leadTime: 'Lead Time: 12 Days',
                topBadge: 'GI Verified Cluster',
                topBadgeIcon: Icons.verified,
                imageUrl: 'https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&w=600&q=80',
                onOrderSample: widget.onOrderSample ?? () => _showSnack('Sample order initiated for Corporate Gifting Sets (₹680)'),
                onInquire: () => widget.onInquireLot?.call('Corporate Gifting Sets') ?? _showSnack('Inquiring lot for Corporate Gifting Sets'),
              ),
              const SizedBox(height: 18),

              // Craft Card 2: Hospitality Tableware & Amenities
              _buildCraftCard(
                categoryTag: 'HORECA SUPPLIES',
                statusBadge: 'High Volume',
                statusColor: const Color(0xFFC2410C),
                statusBg: const Color(0xFFFFF7ED),
                title: 'Hospitality Tableware & Amenities',
                description: 'Terracotta earthen carafes, authentic ribbed kulhad cups, and lead-free glazed dipping bowls for sustainable dining.',
                price: '₹120',
                priceUnit: '/ pc',
                moq: '250 pcs',
                leadTime: 'Lead Time: 14 Days',
                topBadge: 'Food-Grade Certified',
                topBadgeIcon: Icons.restaurant,
                imageUrl: 'https://images.unsplash.com/photo-1615486511484-92e172cc4fe0?auto=format&fit=crop&w=600&q=80',
                onOrderSample: widget.onOrderSample ?? () => _showSnack('Sample order initiated for Hospitality Amenities (₹120)'),
                onInquire: () => widget.onInquireLot?.call('Hospitality Tableware & Amenities') ?? _showSnack('Inquiring lot for Hospitality Tableware'),
              ),
              const SizedBox(height: 18),

              // Craft Card 3: Festive Hampers & Dry Fruit Trays
              _buildCraftCard(
                categoryTag: 'FESTIVE WHOLESALE',
                statusBadge: 'Trending Q4',
                statusColor: const Color(0xFFC2410C),
                statusBg: const Color(0xFFFFF7ED),
                title: 'Festive Hampers & Dry Fruit Trays',
                description: 'Intricate brass & pure copper trays with natural reclaimed wood lids, tarnish-resistant coating for heirloom hampers.',
                price: '₹950',
                priceUnit: '/ set',
                moq: '50 sets',
                leadTime: 'Lead Time: 18 Days',
                topBadge: 'Moradabad Cluster',
                topBadgeIcon: Icons.location_on,
                imageUrl: 'https://images.unsplash.com/photo-1610701596007-11502861dcfa?auto=format&fit=crop&w=600&q=80',
                onOrderSample: widget.onOrderSample ?? () => _showSnack('Sample order initiated for Festive Hampers (₹950)'),
                onInquire: () => widget.onInquireLot?.call('Festive Hampers & Dry Fruit Trays') ?? _showSnack('Inquiring lot for Festive Hampers'),
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
        children: const [
          Text(
            'HunarSangam',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFF8C3A16),
            ),
          ),
        ],
      ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE5D7CD)),
          ),
          child: Row(
            children: const [
              Text('EN', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: _textDark)),
              Icon(Icons.keyboard_arrow_down, size: 16, color: _textDark),
            ],
          ),
        ),
        const SizedBox(width: 8),
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
          Icon(Icons.check_circle_outline, size: 13, color: _primaryRust),
          SizedBox(width: 4),
          Text(
            'Curated Commercial B2B Catalog',
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

  Widget _buildCraftCard({
    required String categoryTag,
    required String statusBadge,
    required Color statusColor,
    required Color statusBg,
    required String title,
    required String description,
    required String price,
    required String priceUnit,
    required String moq,
    required String leadTime,
    required String topBadge,
    required IconData topBadgeIcon,
    required String imageUrl,
    required VoidCallback onOrderSample,
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
          // Image with lead time and top badge
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
                top: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.95),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(topBadgeIcon, size: 12, color: _primaryRust),
                      const SizedBox(width: 4),
                      Text(
                        topBadge,
                        style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: _textDark),
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
                    color: Colors.black.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    leadTime,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      categoryTag,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.6,
                        color: _primaryRust,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2.5),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        statusBadge,
                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: statusColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: _textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 11.5, color: _textMuted, height: 1.35),
                ),
                const SizedBox(height: 12),

                // Pricing row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Bulk Starting At', style: TextStyle(fontSize: 10.5, color: _textMuted)),
                        const SizedBox(height: 1),
                        RichText(
                          text: TextSpan(
                            text: price,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: _primaryRust),
                            children: [
                              TextSpan(
                                text: ' $priceUnit',
                                style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold, color: _textMuted),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Minimum Order', style: TextStyle(fontSize: 10.5, color: _textMuted)),
                        const SizedBox(height: 1),
                        Text(
                          moq,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: _textDark),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Dual Buttons: Order Sample & Inquire Lot
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onOrderSample,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF3ECE4),
                          foregroundColor: _textDark,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          minimumSize: const Size.fromHeight(42),
                        ),
                        child: const Text('Order Sample', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onInquire,
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
                            Text('Inquire Lot', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold)),
                            SizedBox(width: 4),
                            Icon(Icons.north_east, size: 14),
                          ],
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
