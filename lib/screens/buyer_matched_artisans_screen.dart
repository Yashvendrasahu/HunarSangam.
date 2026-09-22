// lib/screens/buyer_matched_artisans_screen.dart
// 100% UI Match for 'r5-bulk— Find Artisan Matches.png'
// Artisan Matches Found - 3 clusters matched for 500 Bamboo Baskets

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';

class BuyerMatchedArtisansScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onCompare;
  final Function(String id) onViewArtisan;
  final VoidCallback onOpenRequirements;
  final VoidCallback onOpenDiscover;
  final VoidCallback onOpenHome;
  final VoidCallback? onOpenOrders;
  final VoidCallback? onOpenProfile;
  final Function(String id)? onMessageArtisan;
  final Function(String id)? onPlaceOrder;

  const BuyerMatchedArtisansScreen({
    super.key,
    required this.onBack,
    required this.onCompare,
    required this.onViewArtisan,
    required this.onOpenRequirements,
    required this.onOpenDiscover,
    required this.onOpenHome,
    this.onOpenOrders,
    this.onOpenProfile,
    this.onMessageArtisan,
    this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    const bgWarm = Color(0xFFFCF9F6);
    const textDark = Color(0xFF1E1714);
    const terracotta = Color(0xFF9E401A);
    const borderBeige = Color(0xFFEDE4DC);

    return Scaffold(
      backgroundColor: bgWarm,
      appBar: AppBar(
        backgroundColor: bgWarm,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textDark, size: 22),
          onPressed: onBack,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Artisan Matches Found',
              style: TextStyle(
                color: terracotta,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
            Text(
              '3 clusters matched for 500 Bamboo Baskets',
              style: TextStyle(
                color: Color(0xFF7A6D66),
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: ElevatedButton.icon(
              onPressed: onCompare,
              icon: const Icon(Icons.balance, size: 14, color: terracotta),
              label: const Text(
                'Compare (3)',
                style: TextStyle(color: terracotta, fontSize: 12, fontWeight: FontWeight.w800),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFBECE4),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: [
            // 1. AI Match Banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFC8E6C9)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFF2E7D32),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'AI Cluster Capacity & GI Match Active',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1B5E20),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Ranked by skill authenticity, past on-time delivery record, and available kiln/loom capacity for your timeline.',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF2E7D32),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Card 1: Barpeta Bamboo Guild
            _buildArtisanMatchCard(
              id: 'art_barpeta_1',
              title: 'Barpeta Bamboo Guild (Assam)',
              matchScore: '98% MATCH',
              matchBg: const Color(0xFFE8F5E9),
              matchColor: const Color(0xFF2E7D32),
              leader: 'Led by Master Craftsman Ramesh Kumar • 24 Artisans',
              badges: [
                _buildMiniBadge('✔ GI Tag Verified', const Color(0xFFE8F5E9), const Color(0xFF2E7D32)),
                _buildMiniBadge('★ 4.9 (142 orders)', const Color(0xFFFBF1EB), terracotta),
                _buildMiniBadge('🛡 Top Tier', const Color(0xFFF5EBE1), const Color(0xFF70645E)),
              ],
              quote: '₹385',
              leadTime: '38 Days',
              capacity: '800 / mo',
              highlights: [
                'Can handle custom laser logo engraving in-house',
                'Direct video QC check enabled before final packing',
              ],
              onMessage: () => onMessageArtisan?.call('art_barpeta_1'),
              onPlaceOrder: () => onPlaceOrder?.call('art_barpeta_1'),
            ),

            const SizedBox(height: 14),

            // Card 2: Kutch Artisans Collective
            _buildArtisanMatchCard(
              id: 'art_kutch_2',
              title: 'Kutch Artisans Collective (Gujarat)',
              matchScore: '94% MATCH',
              matchBg: const Color(0xFFE8F5E9),
              matchColor: const Color(0xFF2E7D32),
              leader: 'Led by Master Weaver Devji Vankar • 18 Artisans',
              badges: [
                _buildMiniBadge('✔ GI Tag Verified', const Color(0xFFE8F5E9), const Color(0xFF2E7D32)),
                _buildMiniBadge('★ 4.8 (96 orders)', const Color(0xFFFBF1EB), terracotta),
              ],
              quote: '₹395',
              leadTime: '42 Days',
              capacity: '600 / mo',
              highlights: [
                'Organic vegetable dye finish included',
                'Ready export packaging experience',
              ],
              onMessage: () => onMessageArtisan?.call('art_kutch_2'),
              onPlaceOrder: () => onPlaceOrder?.call('art_kutch_2'),
            ),

            const SizedBox(height: 14),

            // Card 3: Tripura Cane & Bamboo Co-op
            _buildArtisanMatchCard(
              id: 'art_tripura_3',
              title: 'Tripura Cane & Bamboo Co-op',
              matchScore: '89% MATCH',
              matchBg: const Color(0xFFFFF3E0),
              matchColor: const Color(0xFFE65100),
              leader: 'Led by Subhash Debbarma • 15 Artisans',
              badges: [
                _buildMiniBadge('★ 4.7 (72 orders)', const Color(0xFFFBF1EB), terracotta),
                _buildMiniBadge('🌿 100% Eco Certified', const Color(0xFFE8F5E9), const Color(0xFF2E7D32)),
              ],
              quote: '₹410',
              leadTime: '45 Days',
              capacity: '500 / mo',
              highlights: [
                'Special double-layered bottom weave for extra load',
              ],
              onMessage: () => onMessageArtisan?.call('art_tripura_3'),
              onPlaceOrder: () => onPlaceOrder?.call('art_tripura_3'),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BuyerBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) onOpenHome();
          if (index == 1) onOpenDiscover();
          if (index == 2) onOpenRequirements();
          if (index == 3 && onOpenOrders != null) onOpenOrders!();
          if (index == 4 && onOpenProfile != null) onOpenProfile!();
        },
      ),
    );
  }

  static Widget _buildMiniBadge(String text, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildArtisanMatchCard({
    required String id,
    required String title,
    required String matchScore,
    required Color matchBg,
    required Color matchColor,
    required String leader,
    required List<Widget> badges,
    required String quote,
    required String leadTime,
    required String capacity,
    required List<String> highlights,
    required VoidCallback onMessage,
    required VoidCallback onPlaceOrder,
  }) {
    const terracotta = Color(0xFF9E401A);
    const borderBeige = Color(0xFFEDE4DC);
    const textDark = Color(0xFF1E1714);

    return GestureDetector(
      onTap: () => onViewArtisan(id),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderBeige),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: textDark,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: matchBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  matchScore,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: matchColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            leader,
            style: const TextStyle(fontSize: 12, color: Color(0xFF70645E)),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: badges,
          ),
          const SizedBox(height: 14),

          // 3 Metric Boxes
          Row(
            children: [
              Expanded(
                child: _buildMetricBox('QUOTE / PC', quote, isHighlight: true),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMetricBox('LEAD TIME', leadTime),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildMetricBox('CAPACITY', capacity),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Highlights
          ...highlights.map((h) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check, size: 14, color: Color(0xFF2E7D32)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        h,
                        style: const TextStyle(fontSize: 12, color: Color(0xFF5A4E47)),
                      ),
                    ),
                  ],
                ),
              )),

          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFF3ECE5)),
          const SizedBox(height: 12),

          // Actions
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: onMessage,
                icon: const Icon(Icons.chat_bubble_outline, size: 14, color: textDark),
                label: const Text(
                  'Message / Chat',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: textDark),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD4C5B9)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: onPlaceOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: terracotta,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Select & Place Escrow',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 14, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      ),
    );
  }

  static Widget _buildMetricBox(String label, String value, {bool isHighlight = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      decoration: BoxDecoration(
        color: isHighlight ? const Color(0xFFFBECE4) : const Color(0xFFF8F3ED),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: Color(0xFF8D8078), letterSpacing: 0.4),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: isHighlight ? const Color(0xFF9E401A) : const Color(0xFF1E1714),
            ),
          ),
        ],
      ),
    );
  }
}
