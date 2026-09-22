// lib/screens/buyer_requirement_review_screen.dart
// 100% UI Match for 'r3-bulk — Create Bulk Requirement review.png'
// Post Bulk Requirement - Step 4 of 4: Review & Confirm

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';

class BuyerRequirementReviewScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onContinue;
  final VoidCallback onOpenRequirements;
  final VoidCallback onOpenDiscover;
  final VoidCallback onOpenHome;
  final VoidCallback? onOpenOrders;
  final VoidCallback? onOpenProfile;
  final VoidCallback? onEdit;

  const BuyerRequirementReviewScreen({
    super.key,
    required this.onBack,
    required this.onContinue,
    required this.onOpenRequirements,
    required this.onOpenDiscover,
    required this.onOpenHome,
    this.onOpenOrders,
    this.onOpenProfile,
    this.onEdit,
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
              'Post Bulk Requirement',
              style: TextStyle(
                color: terracotta,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
            Text(
              'Step 4 of 4: Review & Confirm',
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
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.check, size: 14, color: Color(0xFF2E7D32)),
                SizedBox(width: 4),
                Text(
                  'Draft Saved',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          children: [
            // 1. Ready Banner
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
                    child: const Icon(Icons.check, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Requirement Ready for Cluster Broadcast',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1B5E20),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'AI has mapped your requirement to 3 verified GI artisan clusters with open production capacity.',
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

            const SizedBox(height: 18),

            // 2. Requirement Summary Card
            Container(
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
                      const Text(
                        'Requirement Summary',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: textDark,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: onEdit ?? onBack,
                        icon: const Icon(Icons.edit_outlined, size: 14, color: terracotta),
                        label: const Text(
                          'Edit',
                          style: TextStyle(color: terracotta, fontWeight: FontWeight.w700, fontSize: 13),
                        ),
                        style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(40, 30)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildSummaryRow('Product / Craft', 'Handwoven Bamboo Fruit Basket'),
                  const Divider(height: 16, color: Color(0xFFF3ECE5)),
                  _buildSummaryRow('Total Order Quantity', '500 pieces'),
                  const Divider(height: 16, color: Color(0xFFF3ECE5)),
                  _buildSummaryRow('Estimated Budget', '₹1,90,000 – ₹2,05,000 (₹380–₹410/pc)', valueColor: terracotta, isBold: true),
                  const Divider(height: 16, color: Color(0xFFF3ECE5)),
                  _buildSummaryRow('Target Delivery', '45 Days (By Mid Next Month)'),
                  const Divider(height: 16, color: Color(0xFFF3ECE5)),
                  _buildSummaryRow('Delivery Destination', 'CraftHouse Central Warehouse, Indore (MP)'),
                  const Divider(height: 16, color: Color(0xFFF3ECE5)),
                  _buildSummaryRow('Customization', 'Brand Tag Engraving + Eco Box Packaging'),
                  const Divider(height: 16, color: Color(0xFFF3ECE5)),
                  _buildSummaryRow('Reference Files', '2 attached (CAD & weave pattern)'),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // 3. AI Cluster Match Preview
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFBF4ED),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFEFE4DA)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'AI Cluster Match Preview',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: textDark),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          '3 Certified Guilds Ready',
                          style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Color(0xFF2E7D32)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildClusterMatchItem(
                    name: 'Barpeta Bamboo Cluster (Assam)',
                    rating: '★ 4.9 (124 reviews)',
                    capacity: 'Capacity: 800 pcs/mo',
                  ),
                  const SizedBox(height: 8),
                  _buildClusterMatchItem(
                    name: 'Kutch Artisans Collective (Gujarat)',
                    rating: '★ 4.8 (88 reviews)',
                    capacity: 'Capacity: 600 pcs/mo',
                  ),
                  const SizedBox(height: 8),
                  _buildClusterMatchItem(
                    name: 'Tripura Cane & Bamboo Guild',
                    rating: '★ 4.7 (65 reviews)',
                    capacity: 'Capacity: 450 pcs/mo',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // 4. Protection Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderBeige),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.shield_outlined, color: terracotta, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'HunarSangam Bulk Buyer Protection',
                        style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: textDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildProtectionPoint('Milestone-based Escrow Payment — Pay only after stage verification.'),
                  const SizedBox(height: 6),
                  _buildProtectionPoint('Video & Photo QC Proofs directly from the workshop.'),
                  const SizedBox(height: 6),
                  _buildProtectionPoint('Logistics & Doorstep Delivery Insurance included.'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 5. Broadcast Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: terracotta,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Broadcast Requirement to Artisans',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 6),
            const Center(
              child: Text(
                'No upfront commitment. Compare artisan proposals before confirming.',
                style: TextStyle(fontSize: 11.5, color: Color(0xFF8D8078)),
              ),
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

  static Widget _buildSummaryRow(String label, String value, {Color? valueColor, bool isBold = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Text(
            label,
            style: const TextStyle(fontSize: 12.5, color: Color(0xFF8D8078), fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isBold ? FontWeight.w800 : FontWeight.w700,
              color: valueColor ?? const Color(0xFF1E1714),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildClusterMatchItem({
    required String name,
    required String rating,
    required String capacity,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFEDE4DC)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1E1714)),
                ),
                const SizedBox(height: 2),
                Text(
                  '$rating • $capacity',
                  style: const TextStyle(fontSize: 11.5, color: Color(0xFF70645E)),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 12, color: Color(0xFFA89E97)),
        ],
      ),
    );
  }

  static Widget _buildProtectionPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle, size: 14, color: Color(0xFF2E7D32)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, color: Color(0xFF5A4E47), height: 1.35),
          ),
        ),
      ],
    );
  }
}
