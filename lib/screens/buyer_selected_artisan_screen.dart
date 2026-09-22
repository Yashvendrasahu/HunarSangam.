// lib/screens/buyer_selected_artisan_screen.dart
// 100% UI Match for 'r8-bulk — Selected Artisan.png'

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';

class BuyerSelectedArtisanScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onSelectAndReviewOrder;
  final VoidCallback onMessageArtisan;
  final VoidCallback onOpenRequirements;
  final VoidCallback onOpenDiscover;
  final VoidCallback onOpenHome;
  final VoidCallback? onOpenOrders;
  final VoidCallback? onOpenProfile;

  const BuyerSelectedArtisanScreen({
    super.key,
    required this.onBack,
    required this.onSelectAndReviewOrder,
    required this.onMessageArtisan,
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
    const textMuted = Color(0xFF70645E);
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
              'Artisan Profile & Offer',
              style: TextStyle(
                color: terracotta,
                fontSize: 17,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
            Text(
              'Matched for #HS-BLK-883492',
              style: TextStyle(
                color: textMuted,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: textDark, size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: textDark, size: 20),
            onPressed: () {},
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // 1. Profile Header Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=200&q=80',
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: -2,
                            right: -2,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.verified, size: 18, color: Color(0xFF2E7D32)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'Ramesh Kumar',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    color: textDark,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'National Awardee Master Craftsman',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: terracotta,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: const [
                                Icon(Icons.location_on_outlined, size: 13, color: textMuted),
                                SizedBox(width: 3),
                                Expanded(
                                  child: Text(
                                    'Barpeta Bamboo Craft Cluster, Assam',
                                    style: TextStyle(fontSize: 11, color: textMuted),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Pill Badges
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      _buildPill('✔ GI Certified', const Color(0xFFE8F5E9), const Color(0xFF1B5E20)),
                      _buildPill('★ 4.9 (124 reviews)', const Color(0xFFFFF8E1), const Color(0xFFF57F17)),
                      _buildPill('⚡ 100% On-Time', const Color(0xFFE0F2FE), const Color(0xFF0284C7)),
                      _buildPill('22 Yrs Experience', const Color(0xFFF3ECE5), const Color(0xFF5D4E46)),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Divider(height: 1, color: Color(0xFFF3ECE5)),
                  const SizedBox(height: 12),

                  // Capacity & Guild Stats
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Production Capacity',
                              style: TextStyle(fontSize: 11, color: textMuted),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '800 pcs / month',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: textDark),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 28, color: const Color(0xFFF0E5DC)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Artisan SHG Size',
                              style: TextStyle(fontSize: 11, color: textMuted),
                            ),
                            SizedBox(height: 2),
                            Text(
                              '18 Master Weavers',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: textDark),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // 2. Direct Quote & Offer Card
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFF2DFC9), width: 1.2),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9EDE4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'EXCLUSIVE BULK QUOTE',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w800,
                            color: terracotta,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'Save ₹10/pc vs target',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1B5E20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: const [
                      Text(
                        '₹370',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: terracotta,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '/ piece',
                        style: TextStyle(fontSize: 13, color: textMuted),
                      ),
                      Spacer(),
                      Text(
                        'Total: ₹1,85,000',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: textDark,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'For 500 pcs • Estimated completion: 25 Oct 2026 (3 days early)',
                    style: TextStyle(fontSize: 11.5, color: Color(0xFF2E7D32), fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 14),
                  const Divider(height: 1, color: Color(0xFFF0DEC8)),
                  const SizedBox(height: 12),

                  const Text(
                    'Escrow Milestone Breakdown:',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: textDark),
                  ),
                  const SizedBox(height: 8),

                  _buildMilestoneRow('1', '30% Sourcing Advance', '₹55,500', 'Raw matured bamboo procurement'),
                  const SizedBox(height: 6),
                  _buildMilestoneRow('2', '40% Mid-Production Proof', '₹74,000', 'After 250 pcs woven with video QC'),
                  const SizedBox(height: 6),
                  _buildMilestoneRow('3', '30% Delivery QC Release', '₹55,500', 'On doorstep verification in Delhi'),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // 3. Artisan Voice / Story Note
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderBeige),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.format_quote, color: terracotta, size: 20),
                      SizedBox(width: 6),
                      Text(
                        'Artisan Statement on this Batch',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: textDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    '"We will use seasoned Assam Bhaluka bamboo. Every piece will feature the reinforced dual-rim you requested with an organic food-safe finish. Brand tags will be cleanly engraved at no additional charge."',
                    style: TextStyle(fontSize: 12, color: Color(0xFF5A4C45), height: 1.4, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // 4. Portfolio / Past Batch Gallery
            const Text(
              'Past Batch Samples (Barpeta Cluster)',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: textDark),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildGalleryImage('https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=240&q=80', 'Woven Basket'),
                  const SizedBox(width: 8),
                  _buildGalleryImage('https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=240&q=80', 'Bamboo Planter'),
                  const SizedBox(width: 8),
                  _buildGalleryImage('https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&w=240&q=80', 'Dual Rim Weave'),
                  const SizedBox(width: 8),
                  _buildGalleryImage('https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&w=240&q=80', 'Storage Bins'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: onMessageArtisan,
                      icon: const Icon(Icons.chat_bubble_outline, size: 16, color: terracotta),
                      label: const Text(
                        'Chat First',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: terracotta),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: terracotta, width: 1.2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: onSelectAndReviewOrder,
                      icon: const Text(
                        'Accept & Lock Escrow',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white),
                      ),
                      label: const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: terracotta,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                    ),
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
        onTap: (idx) {
          if (idx == 0) onOpenHome();
          if (idx == 1) onOpenDiscover();
          if (idx == 2) onOpenRequirements();
          if (idx == 3 && onOpenOrders != null) onOpenOrders!();
          if (idx == 4 && onOpenProfile != null) onOpenProfile!();
        },
      ),
    );
  }

  static Widget _buildPill(String label, Color bg, Color text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: text),
      ),
    );
  }

  static Widget _buildMilestoneRow(String step, String title, String amount, String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: const BoxDecoration(
            color: Color(0xFF9E401A),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            step,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Color(0xFF1E1714)),
                  ),
                  Text(
                    amount,
                    style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF9E401A)),
                  ),
                ],
              ),
              Text(
                desc,
                style: const TextStyle(fontSize: 10.5, color: Color(0xFF70645E)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _buildGalleryImage(String url, String caption) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        url,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
