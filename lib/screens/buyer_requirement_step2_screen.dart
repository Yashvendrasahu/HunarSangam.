// lib/screens/buyer_requirement_step2_screen.dart
// 100% UI Match for 'r7-bulk ai artisan matching in bulk side.png'
// Post Bulk Requirement - Step 2 of 3: Requirement Description

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';

class BuyerRequirementStep2Screen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onContinue;
  final VoidCallback onOpenRequirements;
  final VoidCallback onOpenDiscover;
  final VoidCallback onOpenHome;
  final VoidCallback? onOpenOrders;
  final VoidCallback? onOpenProfile;

  const BuyerRequirementStep2Screen({
    super.key,
    required this.onBack,
    required this.onContinue,
    required this.onOpenRequirements,
    required this.onOpenDiscover,
    required this.onOpenHome,
    this.onOpenOrders,
    this.onOpenProfile,
  });

  @override
  State<BuyerRequirementStep2Screen> createState() => _BuyerRequirementStep2ScreenState();
}

class _BuyerRequirementStep2ScreenState extends State<BuyerRequirementStep2Screen> {
  int _quantity = 500;
  int _timelineDays = 45;

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
          onPressed: widget.onBack,
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
              'Step 2 of 3: Requirement Description',
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
                Icon(Icons.record_voice_over, size: 14, color: Color(0xFF2E7D32)),
                SizedBox(width: 4),
                Text(
                  'AI Voice',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.translate, color: terracotta, size: 20),
            onPressed: () {},
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          children: [
            // 1. Direct Access Banner
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFBF4ED),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFEFE4DA)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E7DC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.layers_outlined, size: 18, color: terracotta),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Specify your sourcing needs to connect directly with verified master artisan clusters.',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF5A4E47),
                            fontWeight: FontWeight.w600,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: const [
                            Icon(Icons.circle, size: 6, color: Color(0xFF2E7D32)),
                            SizedBox(width: 5),
                            Text(
                              'Bulk Buyer Direct Access',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // 2. Quick Voice-Fill Card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFBF4ED),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEFE4DA)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: terracotta,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.mic, color: Colors.white, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'QUICK VOICE-FILL',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: terracotta,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3ECE4),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Any Language',
                                style: TextStyle(fontSize: 10, color: Color(0xFF7A6D66), fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '“Mujhe 500 bamboo baskets chahiye for corporate gifting by next month.”',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: textDark,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Tap mic to autofill this entire screen in seconds',
                          style: TextStyle(fontSize: 11, color: Color(0xFF8D8078)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 3. What do you need? Card
            _buildSectionCard(
              title: 'What do you need?',
              icon: Icons.category_outlined,
              actionText: 'Change',
              actionIcon: Icons.edit_outlined,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCFAF7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEFE7DE)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7EBE1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.shopping_bag_outlined, color: terracotta, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Handmade Bamboo Fruit Baskets',
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w800,
                              color: textDark,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Eco-friendly • Lacquered Natural Finish',
                            style: TextStyle(fontSize: 12, color: Color(0xFF70645E)),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 20),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // 4. Craft & Artisan Cluster Card
            _buildSectionCard(
              title: 'Craft & Artisan Cluster',
              icon: Icons.palette_outlined,
              pillBadge: 'Verified GI Craft',
              pillColor: const Color(0xFF2E7D32),
              pillBg: const Color(0xFFE8F5E9),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCFAF7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEFE7DE)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Bamboo & Cane Craft',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: textDark,
                          ),
                        ),
                        Icon(Icons.chevron_right, color: Color(0xFFA89E97), size: 20),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Icon(Icons.location_on_outlined, size: 14, color: terracotta),
                        SizedBox(width: 4),
                        Text(
                          'Assam (Barpeta) & West Bengal clusters',
                          style: TextStyle(fontSize: 12.5, color: Color(0xFF70645E)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 1, color: Color(0xFFF0E7DF)),
                    const SizedBox(height: 8),
                    const Text(
                      'Active Artisan Cooperatives: 14 Master Guilds Available',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: terracotta,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // 5. Quantity Needed Card
            _buildSectionCard(
              title: 'Quantity Needed',
              icon: Icons.inventory_2_outlined,
              pillBadge: 'Standard Bulk Tier',
              pillColor: const Color(0xFF70645E),
              pillBg: const Color(0xFFF5EBE1),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCFAF7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEFE7DE)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '$_quantity',
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w900,
                                color: textDark,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'pieces',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF70645E),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Wholesale pricing bracket active (₹380 – ₹410/pc)',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFD4C5B9)),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove, size: 16, color: textDark),
                            onPressed: () {
                              if (_quantity > 50) {
                                setState(() => _quantity -= 50);
                              }
                            },
                          ),
                          const Text(
                            'Edit',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: textDark),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add, size: 16, color: textDark),
                            onPressed: () {
                              setState(() => _quantity += 50);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            // 6. Required Delivery Timeline
            _buildSectionCard(
              title: 'Required Delivery Timeline',
              icon: Icons.calendar_today_outlined,
              actionText: 'Adjust',
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCFAF7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEFE7DE)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3E7DC),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.schedule, color: terracotta, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$_timelineDays Days',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: textDark,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Estimated arrival: Mid Next Month',
                            style: TextStyle(fontSize: 12, color: Color(0xFF70645E)),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3ECE4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Flexible (± 5 days)',
                        style: TextStyle(fontSize: 11, color: Color(0xFF6E5F57), fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onContinue,
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
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
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
                'Step 2 will cover reference photos, budget & customization.',
                style: TextStyle(fontSize: 12, color: Color(0xFF8D8078)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BuyerBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) widget.onOpenHome();
          if (index == 1) widget.onOpenDiscover();
          if (index == 2) widget.onOpenRequirements();
          if (index == 3 && widget.onOpenOrders != null) widget.onOpenOrders!();
          if (index == 4 && widget.onOpenProfile != null) widget.onOpenProfile!();
        },
      ),
    );
  }

  static Widget _buildSectionCard({
    required String title,
    required IconData icon,
    String? actionText,
    IconData? actionIcon,
    String? pillBadge,
    Color? pillColor,
    Color? pillBg,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEDE4DC)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, size: 16, color: const Color(0xFF9E401A)),
                  const SizedBox(width: 6),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E1714),
                    ),
                  ),
                ],
              ),
              if (actionText != null)
                TextButton.icon(
                  onPressed: () {},
                  icon: actionIcon != null ? Icon(actionIcon, size: 13, color: const Color(0xFF9E401A)) : const SizedBox.shrink(),
                  label: Text(
                    actionText,
                    style: const TextStyle(color: Color(0xFF9E401A), fontWeight: FontWeight.w700, fontSize: 12.5),
                  ),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(40, 30)),
                )
              else if (pillBadge != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: pillBg ?? const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    pillBadge,
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: pillColor ?? const Color(0xFF2E7D32),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
