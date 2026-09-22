// lib/screens/buyer_artisan_profile_screen.dart

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';

/// Screen d5: Public Artisan Profile
/// Exactly reproduces 'd5 bulk — Public Artisan Profile.png'
class BuyerArtisanProfileScreen extends StatefulWidget {
  final VoidCallback onBack;
  final Function(int)? onTabChange;
  final VoidCallback? onSendRequirement;

  const BuyerArtisanProfileScreen({
    super.key,
    required this.onBack,
    this.onTabChange,
    this.onSendRequirement,
  });

  @override
  State<BuyerArtisanProfileScreen> createState() => _BuyerArtisanProfileScreenState();
}

class _BuyerArtisanProfileScreenState extends State<BuyerArtisanProfileScreen> {
  bool _isPlayingAudio = false;

  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFDFBF9);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgCanvas,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Artisan Profile Hero Header
              _buildArtisanHero(),
              const SizedBox(height: 16.0),

              // Audio Note Player
              _buildVoiceStoryPlayer(),
              const SizedBox(height: 16.0),

              // 4 Metrics Grid
              _buildMetricsGrid(),
              const SizedBox(height: 20.0),

              // Verified Specialties
              const Text(
                'Verified Craft Specialties',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: _textDark,
                ),
              ),
              const SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  _buildSpecialtyChip('Ergonomic Baskets'),
                  _buildSpecialtyChip('Fruit Hampers'),
                  _buildSpecialtyChip('Storage Baskets'),
                  _buildSpecialtyChip('Natural Lacquer Finish'),
                  _buildSpecialtyChip('Custom Dye Weaves'),
                ],
              ),
              const SizedBox(height: 22.0),

              // Product Catalog & Wholesale Tiers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Product Catalog & Wholesale Tiers',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: _textDark,
                    ),
                  ),
                  Text(
                    '2 Lines',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _primaryRust),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),

              _buildProductCatalogCard(
                image: 'https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=600&q=80',
                title: 'Handwoven Natural Bamboo Fruit Basket',
                moq: '50 pcs',
                tier1: '50-100 pcs: ₹320',
                tier2: '101-500 pcs: ₹280',
                tier3: '500+ pcs: ₹240',
              ),
              const SizedBox(height: 14.0),

              _buildProductCatalogCard(
                image: 'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80',
                title: 'Cane Storage Hamper with Lid',
                moq: '30 pcs',
                tier1: '30-100 pcs: ₹450',
                tier2: '101-300 pcs: ₹390',
                tier3: '300+ pcs: ₹340',
              ),
              const SizedBox(height: 22.0),

              // Cluster Verification & Certifications
              _buildVerificationSection(),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
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
      title: const Text(
        'ARTISAN PROFILE',
        style: TextStyle(
          color: Color(0xFF6B5A51),
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined, color: _textDark, size: 20),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.bookmark_border, color: _textDark, size: 22),
          onPressed: () {},
        ),
        const SizedBox(width: 8.0),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: const Color(0xFFEFE8E2), height: 1.0),
      ),
    );
  }

  Widget _buildArtisanHero() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFEFE8E2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=600&q=80',
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D32),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Ramesh Kumar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: _textDark,
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      'Master Craftsman • Bamboo & Cane',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: _primaryRust,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '📍 Barpeta GI Cluster, Assam',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: _textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          const Text(
            '28 years craft experience • National Merit Certificate awardee • Specializing in treated structural bamboo and fine table-top weave collections.',
            style: TextStyle(
              fontSize: 12,
              color: _textMuted,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12.0),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.verified, size: 12, color: Color(0xFF2E7D32)),
                    SizedBox(width: 4.0),
                    Text(
                      'GI Registered Lead Maker',
                      style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Color(0xFF2E7D32)),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDECE5),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text(
                  '32 Cluster Weavers Network',
                  style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: _primaryRust),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceStoryPlayer() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F3EE),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFEFE8E2)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => setState(() => _isPlayingAudio = !_isPlayingAudio),
            child: Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: _primaryRust,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _isPlayingAudio ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Craft Story & Workshop Details',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: _textDark,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  'Recorded in Hindi / Assamese • 0:48 min',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: _textMuted,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.graphic_eq, color: _primaryRust, size: 24),
        ],
      ),
    );
  }

  Widget _buildMetricsGrid() {
    return Row(
      children: [
        Expanded(child: _buildMetricCard('Monthly Capacity', '500 pcs/mo')),
        const SizedBox(width: 8.0),
        Expanded(child: _buildMetricCard('Avg Lead Time', '18-24 Days')),
        const SizedBox(width: 8.0),
        Expanded(child: _buildMetricCard('Completed Orders', '140+ Lots')),
      ],
    );
  }

  Widget _buildMetricCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFEFE8E2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: _textMuted, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: _textDark),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialtyChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF7EFE9),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _textDark),
      ),
    );
  }

  Widget _buildProductCatalogCard({
    required String image,
    required String title,
    required String moq,
    required String tier1,
    required String tier2,
    required String tier3,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFEFE8E2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SizedBox(
              width: 84,
              height: 84,
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: _textDark),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4.0),
                Text('MOQ: $moq', style: const TextStyle(fontSize: 11, color: Color(0xFF2E7D32), fontWeight: FontWeight.w700)),
                const SizedBox(height: 6.0),
                Text(
                  '$tier1 • $tier2\n$tier3',
                  style: const TextStyle(fontSize: 10.5, color: _textMuted, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationSection() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FBF9),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFC8E6C9)),
      ),
      child: Row(
        children: const [
          Icon(Icons.shield_outlined, color: Color(0xFF2E7D32), size: 28),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cluster Verification & ONDC Ready',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF1B5E20)),
                ),
                SizedBox(height: 2.0),
                Text(
                  'Verified by Assam Bamboo Development Agency & Ministry of Textiles database.',
                  style: TextStyle(fontSize: 11, color: Color(0xFF2E7D32), height: 1.35),
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEFE8E2), width: 1.0)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 46,
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Opening direct message with Ramesh Kumar')),
                    );
                  },
                  icon: const Icon(Icons.chat_bubble_outline, size: 16, color: _primaryRust),
                  label: const Text('Chat', style: TextStyle(fontWeight: FontWeight.w800, color: _primaryRust)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE5D5CB)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 46,
                child: ElevatedButton.icon(
                  onPressed: widget.onSendRequirement ?? () => widget.onTabChange?.call(2),
                  icon: const Icon(Icons.assignment_outlined, size: 16),
                  label: const Text('Send Requirement', style: TextStyle(fontWeight: FontWeight.w800)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryRust,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
