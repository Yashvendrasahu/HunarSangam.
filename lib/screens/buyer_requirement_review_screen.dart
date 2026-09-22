// lib/screens/buyer_requirement_review_screen.dart
// 100% UI Match for 'r3-bulk — Create Bulk Requirement review.png'

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
        titleSpacing: 0,
        title: Row(
          children: [
            const Text(
              'Review & Match',
              style: TextStyle(
                color: terracotta,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFA5D6A7)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2E7D32),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Ready to Match',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1B5E20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.translate, color: textDark, size: 20),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            const Text(
              'Requirement Ready for Matching',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: textDark,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Review your bulk sourcing specifications before our algorithm identifies suitable artisan clusters.',
              style: TextStyle(
                fontSize: 12.5,
                color: Color(0xFF70645E),
                height: 1.35,
              ),
            ),
            const SizedBox(height: 14),

            // Main Details Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderBeige),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=160&q=80',
                          width: 54,
                          height: 54,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3ECE5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.check, size: 10, color: Color(0xFF70645E)),
                                  SizedBox(width: 3),
                                  Text(
                                    'Bamboo Handicraft',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF70645E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Handwoven Bamboo Fruit Basket',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: textDark,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'ID: HS-BLK-883492',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF8D8078),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFF3ECE5)),
                  const SizedBox(height: 12),

                  // Quantity
                  _buildSpecItem(
                    icon: Icons.inventory_2_outlined,
                    label: 'QUANTITY',
                    child: Row(
                      children: [
                        const Text(
                          '500 pieces',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: textDark,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF9EDE4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Medium Bulk Tier',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: terracotta,
                            ),
                          ),
                        ),
                      ],
                    ),
                    onEdit: onEdit ?? onBack,
                  ),
                  const SizedBox(height: 14),

                  // Delivery Date
                  _buildSpecItem(
                    icon: Icons.calendar_today_outlined,
                    label: 'TARGET DELIVERY DATE',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '28 October 2026',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w800,
                            color: textDark,
                          ),
                        ),
                        Text(
                          '(Flexible ±7 days)',
                          style: TextStyle(
                            fontSize: 11.5,
                            color: Color(0xFF8D8078),
                          ),
                        ),
                      ],
                    ),
                    onEdit: onEdit ?? onBack,
                  ),
                  const SizedBox(height: 14),

                  // Target Budget
                  _buildSpecItem(
                    icon: Icons.account_balance_wallet_outlined,
                    label: 'TARGET BUDGET',
                    child: const Text(
                      '₹380 / pc (~₹1,90,000 total)',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: textDark,
                      ),
                    ),
                    onEdit: onEdit ?? onBack,
                  ),
                  const SizedBox(height: 14),

                  // Customizations
                  _buildSpecItem(
                    icon: Icons.tune,
                    label: 'CUSTOMIZATIONS',
                    child: Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        _buildCustomTag('Custom 10-inch size'),
                        _buildCustomTag('Logo kraft hangtag'),
                        _buildCustomTag('Recycled individual box'),
                      ],
                    ),
                    onEdit: onEdit ?? onBack,
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFF3ECE5)),
                  const SizedBox(height: 12),

                  // Attached Visual Reference
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.attach_file, size: 16, color: terracotta),
                          SizedBox(width: 6),
                          Text(
                            'ATTACHED VISUAL REFERENCE',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF70645E),
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        '1 File attached',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8D8078),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDF9F5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFEDE4DC)),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=120&q=80',
                            width: 44,
                            height: 44,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'bamboo_basket_dualrim_spec.jpg',
                                style: TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: textDark,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2),
                              Text(
                                '2.4 MB • Reference Image',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF8D8078),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove_red_eye_outlined, size: 18, color: terracotta),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFF3ECE5)),
                  const SizedBox(height: 12),

                  // Buyer Audio Brief & Transcript
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.graphic_eq, size: 16, color: terracotta),
                          SizedBox(width: 6),
                          Text(
                            'BUYER AUDIO BRIEF & TRANSCRIPT',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF70645E),
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          '✔ Verified Voice',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Audio player bar
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: terracotta,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.play_arrow, color: Colors.white, size: 18),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: const LinearProgressIndicator(
                            value: 0.41,
                            backgroundColor: Color(0xFFEADBCE),
                            valueColor: AlwaysStoppedAnimation<Color>(terracotta),
                            minHeight: 5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        '0:24 / 0:58',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF70645E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Transcript quote
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF4EE),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFEFE2D6)),
                    ),
                    child: const Text(
                      '"Need 500 handwoven natural bamboo fruit baskets with reinforced dual-rim finish. Should comfortably hold 3-4 kg weight. Delivery needed in Delhi warehouse by late October with food-safe organic polish."',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF5A4C45),
                        fontStyle: FontStyle.italic,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Large CTA
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: onContinue,
                icon: const Text(
                  'Publish & Find Matching Artisans',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                label: const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                style: ElevatedButton.styleFrom(
                  backgroundColor: terracotta,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.sensors, size: 14, color: terracotta),
                SizedBox(width: 6),
                Text(
                  'Ready to connect with qualified master artisans across India.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF70645E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
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

  static Widget _buildSpecItem({
    required IconData icon,
    required String label,
    required Widget child,
    required VoidCallback onEdit,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: const Color(0xFFF9EDE4),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: const Color(0xFF9E401A)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF8D8078),
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 3),
              child,
            ],
          ),
        ),
        GestureDetector(
          onTap: onEdit,
          child: Row(
            children: const [
              Icon(Icons.edit_outlined, size: 13, color: Color(0xFF9E401A)),
              SizedBox(width: 2),
              Text(
                'Edit',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF9E401A),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildCustomTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5EBE1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE5D7CA)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF4E4039),
        ),
      ),
    );
  }
}
