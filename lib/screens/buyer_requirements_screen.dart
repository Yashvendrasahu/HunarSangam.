// lib/screens/buyer_requirements_screen.dart
// 100% UI Match for 'r1 - bulk - requriment section.png'

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';

class BuyerRequirementsScreen extends StatelessWidget {
  final VoidCallback onBackToHome;
  final VoidCallback onCreateRequirement;
  final VoidCallback onOpenDiscover;
  final VoidCallback onOpenOrders;
  final VoidCallback onOpenProfile;
  final Function(String reqId)? onViewDetails;

  const BuyerRequirementsScreen({
    super.key,
    required this.onBackToHome,
    required this.onCreateRequirement,
    required this.onOpenDiscover,
    required this.onOpenOrders,
    required this.onOpenProfile,
    this.onViewDetails,
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
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'My Requirements',
              style: TextStyle(
                color: textDark,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Manage your bulk sourcing requirements',
              style: TextStyle(
                color: Color(0xFF7A6D66),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF3ECE4),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'EN',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6E5F57)),
                ),
                Icon(Icons.arrow_drop_down, size: 16, color: Color(0xFF6E5F57)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            margin: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFF3ECE4),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.notifications_none, color: Color(0xFF6E5F57), size: 20),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // 1. Hero Terracotta Card
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8F3918), Color(0xFFB54F26)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8F3918).withValues(alpha: 0.25),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 16,
                    top: 16,
                    child: Icon(
                      Icons.architecture,
                      size: 70,
                      color: Colors.white.withValues(alpha: 0.12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.add, color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Add New Requirement',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Create a new bulk sourcing requirement',
                                  style: TextStyle(
                                    color: Color(0xFFFFDDD0),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Voice Prompt Bar
                        InkWell(
                          onTap: onCreateRequirement,
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.mic, color: Color(0xFFFFC5B2), size: 20),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Speak your requirement',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        '“Mujhe 500 handmade terracotta cups c...”',
                                        style: TextStyle(
                                          color: Color(0xFFFFD5C6),
                                          fontSize: 11.5,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.graphic_eq, color: terracotta, size: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        // Create Requirement Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: onCreateRequirement,
                            icon: const Icon(Icons.add, size: 18, color: terracotta),
                            label: const Text(
                              'Create Requirement',
                              style: TextStyle(
                                color: terracotta,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        // 4 Steps Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildStepMini(Icons.palette_outlined, 'Product'),
                            _buildStepArrow(),
                            _buildStepMini(Icons.inventory_2_outlined, 'Quantity'),
                            _buildStepArrow(),
                            _buildStepMini(Icons.calendar_today_outlined, 'Date'),
                            _buildStepArrow(),
                            _buildStepMini(Icons.groups_outlined, 'Artisans'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 2. Section Header: Previous Requirements
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Previous Requirements',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFE8E0),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        '3',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6E5F57)),
                      ),
                    ),
                  ],
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.tune, size: 14, color: Color(0xFF70645E)),
                  label: const Text(
                    'Filter & Sort',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF70645E)),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: borderBeige),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Card 1: Terracotta Cups
            _buildRequirementCard(
              title: 'Handmade Terracotta Cups',
              statusLabel: 'In Progress',
              statusBg: const Color(0xFFFFF8E1),
              statusTextColor: const Color(0xFFF57F17),
              piecesInfo: '500 pieces • Req: 20 Oct 2026',
              targetPrice: 'Target: ₹45/pc',
              iconOrImage: Icons.coffee,
              subGuildInfo: 'Kutch Traditional Pottery Guild',
              progressPercent: 0.65,
              progressLabel: '65% completed',
              onTap: () => onViewDetails?.call('REQ-TC-500'),
            ),

            const SizedBox(height: 14),

            // Card 2: Cotton Tote Bags
            _buildRequirementCard(
              title: 'Handwoven Cotton Tote Bags',
              statusLabel: 'Awaiting Response',
              statusBg: const Color(0xFFFFF3E0),
              statusTextColor: const Color(0xFFE65100),
              piecesInfo: '200 pieces • Req: 5 Nov 2026',
              targetPrice: 'Target: ₹180/pc',
              iconOrImage: Icons.shopping_bag_outlined,
              subText: 'Sent to 3 artisan clusters • 2 reviewing schedule',
              subIcon: Icons.groups_outlined,
              onTap: () => onViewDetails?.call('REQ-TB-200'),
            ),

            const SizedBox(height: 14),

            // Card 3: Wooden Desk Decor
            _buildRequirementCard(
              title: 'Traditional Wooden Desk Decor',
              statusLabel: 'Completed',
              statusBg: const Color(0xFFE8F5E9),
              statusTextColor: const Color(0xFF2E7D32),
              piecesInfo: '100 pieces • Delivered 15 Sep 2026',
              targetPrice: 'Total: ₹42,000',
              targetColor: const Color(0xFF2E7D32),
              iconOrImage: Icons.chair_outlined,
              subText: 'Delivered successfully to Mumbai warehouse',
              subIcon: Icons.local_shipping_outlined,
              showCreateSimilar: true,
              onCreateSimilar: onCreateRequirement,
              onTap: () => onViewDetails?.call('REQ-WD-100'),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BuyerBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) onBackToHome();
          if (index == 1) onOpenDiscover();
          if (index == 3) onOpenOrders();
          if (index == 4) onOpenProfile();
        },
      ),
    );
  }

  static Widget _buildStepMini(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Color(0xFFFFE0D6), fontSize: 10, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  static Widget _buildStepArrow() {
    return const Icon(Icons.chevron_right, size: 14, color: Color(0xFFFFBCA5));
  }

  static Widget _buildRequirementCard({
    required String title,
    required String statusLabel,
    required Color statusBg,
    required Color statusTextColor,
    required String piecesInfo,
    required String targetPrice,
    Color? targetColor,
    required IconData iconOrImage,
    String? subGuildInfo,
    double? progressPercent,
    String? progressLabel,
    String? subText,
    IconData? subIcon,
    bool showCreateSimilar = false,
    VoidCallback? onCreateSimilar,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEDE4DC), width: 1.1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Thumbnail / Icon
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFFFBF4ED),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFEFE6DE)),
                ),
                child: Icon(iconOrImage, size: 28, color: const Color(0xFF9E401A)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 15.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E1714),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: statusTextColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            statusLabel,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: statusTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            piecesInfo,
            style: const TextStyle(fontSize: 13, color: Color(0xFF6E5F57), fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 2),
          Text(
            targetPrice,
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w800,
              color: targetColor ?? const Color(0xFF9E401A),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFF3ECE5)),
          const SizedBox(height: 10),

          // Sub Progress / Guild Section
          if (progressPercent != null) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.check_circle_outline, size: 13, color: Color(0xFF2E7D32)),
                    const SizedBox(width: 4),
                    Text(
                      subGuildInfo ?? '',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF6E5F57), fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Text(
                  progressLabel ?? '',
                  style: const TextStyle(fontSize: 12, color: Color(0xFF9E401A), fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progressPercent,
                minHeight: 5,
                backgroundColor: const Color(0xFFEDE4DC),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF9E401A)),
              ),
            ),
            const SizedBox(height: 12),
          ],

          if (subText != null) ...[
            Row(
              children: [
                if (subIcon != null) ...[
                  Icon(subIcon, size: 14, color: const Color(0xFF7A6D66)),
                  const SizedBox(width: 6),
                ],
                Expanded(
                  child: Text(
                    subText,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF6E5F57)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],

          // Actions
          if (!showCreateSimilar) ...[
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onTap,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFD4C5B9)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'View Details',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF9E401A)),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 14, color: Color(0xFF9E401A)),
                  ],
                ),
              ),
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onTap,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFD4C5B9)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: const Text(
                      'View Details',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1E1714)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onCreateSimilar ?? onTap,
                    icon: const Icon(Icons.replay, size: 14, color: Color(0xFF9E401A)),
                    label: const Text(
                      '+ Create Similar',
                      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF9E401A)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFDECE5),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
