// lib/screens/buyer_compare_artisans_screen.dart
// 100% UI Match for 'r6-bulk — Artisan Match & Comparison.png'
// Artisan Match & Comparison - Side-by-side proposal evaluation for 500 pcs

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';

class BuyerCompareArtisansScreen extends StatelessWidget {
  final VoidCallback onBack;
  final Function(String id) onSelectArtisan;
  final VoidCallback onMessageArtisans;
  final VoidCallback onOpenRequirements;
  final VoidCallback onOpenDiscover;
  final VoidCallback onOpenHome;
  final VoidCallback? onOpenOrders;
  final VoidCallback? onOpenProfile;

  const BuyerCompareArtisansScreen({
    super.key,
    required this.onBack,
    required this.onSelectArtisan,
    required this.onMessageArtisans,
    required this.onOpenRequirements,
    required this.onOpenDiscover,
    required this.onOpenHome,
    this.onOpenOrders,
    this.onOpenProfile,
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
              'Artisan Match & Comparison',
              style: TextStyle(
                color: terracotta,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
            Text(
              'Side-by-side proposal evaluation for 500 pcs',
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
            child: OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('🔍 Comparison filters: Price/pc, Lead Time, Reliability & GI Authenticity'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              icon: const Icon(Icons.tune, size: 14, color: Color(0xFF70645E)),
              label: const Text(
                'Filter',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF70645E)),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: borderBeige),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          children: [
            // 1. Two Header Cards Side-by-Side
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Artisan 1
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFF2E7D32), width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2E7D32).withValues(alpha: 0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            '★ 98% MATCH',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Barpeta Guild',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: textDark),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          '📍 Barpeta, Assam',
                          style: TextStyle(fontSize: 11, color: Color(0xFF70645E)),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Ramesh Kumar',
                          style: TextStyle(fontSize: 11, color: Color(0xFF8D8078)),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '★ 4.9 (142)',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: terracotta),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => onSelectArtisan('art_barpeta_1'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: terracotta,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text(
                              'Select Cluster',
                              style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Artisan 2
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: borderBeige),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFBF1EB),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            '94% MATCH',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              color: terracotta,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Kutch Collective',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: textDark),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          '📍 Bhuj, Gujarat',
                          style: TextStyle(fontSize: 11, color: Color(0xFF70645E)),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Devji Vankar',
                          style: TextStyle(fontSize: 11, color: Color(0xFF8D8078)),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '★ 4.8 (96)',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: terracotta),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () => onSelectArtisan('art_kutch_2'),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFD4C5B9)),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text(
                              'Select Cluster',
                              style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: textDark),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // 2. Comparison Matrix Container
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: borderBeige),
              ),
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section 1: Commercials & Pricing
                  _buildSectionHeader('COMMERCIALS & PRICING'),
                  const SizedBox(height: 8),
                  _buildMatrixRow('Unit Quote', '₹385 / pc', '₹395 / pc', isHighlight1: true),
                  const Divider(height: 14, color: Color(0xFFF3ECE5)),
                  _buildMatrixRow('Total Batch (500 pcs)', '₹1,92,500', '₹1,97,500', isBold1: true),
                  const Divider(height: 14, color: Color(0xFFF3ECE5)),
                  _buildMatrixRow('Sample Cost', 'Free (Refunded on Bulk)', '₹450 / sample'),

                  const SizedBox(height: 16),

                  // Section 2: Production & Timeline
                  _buildSectionHeader('PRODUCTION & TIMELINE'),
                  const SizedBox(height: 8),
                  _buildMatrixRow('Dispatch Timeline', '38 Days', '42 Days', isHighlight1: true),
                  const Divider(height: 14, color: Color(0xFFF3ECE5)),
                  _buildMatrixRow('Monthly Capacity', '800 pcs / mo', '600 pcs / mo'),
                  const Divider(height: 14, color: Color(0xFFF3ECE5)),
                  _buildMatrixRow('Advance Escrow', '25% Initial Milestone', '30% Initial Milestone'),

                  const SizedBox(height: 16),

                  // Section 3: Quality & Customization
                  _buildSectionHeader('QUALITY & CUSTOMIZATION'),
                  const SizedBox(height: 8),
                  _buildMatrixRow('GI Certification', '✔ Verified Govt Portal', '✔ Verified Govt Portal'),
                  const Divider(height: 14, color: Color(0xFFF3ECE5)),
                  _buildMatrixRow('Custom Brand Tag', '✔ Included (Laser)', '✔ ₹5 extra per piece'),
                  const Divider(height: 14, color: Color(0xFFF3ECE5)),
                  _buildMatrixRow('Eco Box Packaging', '✔ Included', '✔ Included'),
                  const Divider(height: 14, color: Color(0xFFF3ECE5)),
                  _buildMatrixRow('QC Inspection', '✔ Live 3-point video call', '✔ Photo proofs before dispatch'),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // 3. Trust Escrow Banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFBF4ED),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFEFE4DA)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.shield_outlined, size: 16, color: terracotta),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Protected by HunarSangam Craft Trust Escrow • Zero upfront risk',
                      style: TextStyle(fontSize: 11.5, color: Color(0xFF70645E), fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // 4. Action Row
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onMessageArtisans,
                    icon: const Icon(Icons.chat_bubble_outline, size: 15, color: textDark),
                    label: const Text(
                      'Chat with Both',
                      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: textDark),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFD4C5B9)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => onSelectArtisan('art_barpeta_1'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: terracotta,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Proceed (Barpeta)',
                          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Colors.white),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 14, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
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

  static Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF3EC),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w800,
          color: Color(0xFF9E401A),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  static Widget _buildMatrixRow(
    String metric,
    String val1,
    String val2, {
    bool isHighlight1 = false,
    bool isBold1 = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            metric,
            style: const TextStyle(fontSize: 12, color: Color(0xFF70645E), fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            val1,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isBold1 || isHighlight1 ? FontWeight.w800 : FontWeight.w600,
              color: isHighlight1 ? const Color(0xFF9E401A) : const Color(0xFF1E1714),
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            val2,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF70645E),
            ),
          ),
        ),
      ],
    );
  }
}
