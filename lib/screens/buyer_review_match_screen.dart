// lib/screens/buyer_review_match_screen.dart

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';

class BuyerReviewMatchScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onPublishAndFind;
  final VoidCallback onOpenRequirements;
  final VoidCallback onOpenDiscover;
  final VoidCallback onOpenHome;

  const BuyerReviewMatchScreen({
    super.key,
    required this.onBack,
    required this.onPublishAndFind,
    required this.onOpenRequirements,
    required this.onOpenDiscover,
    required this.onOpenHome,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D2421)),
          onPressed: onBack,
        ),
        title: const Text('Find Artisan Matches (Step 4/4)', style: TextStyle(color: Color(0xFF2D2421), fontSize: 15, fontWeight: FontWeight.w800)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: const [
                  Icon(Icons.bolt, color: Color(0xFF2E7D32), size: 28),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '3 verified GI clusters matched your capacity & delivery timeline!',
                      style: TextStyle(color: Color(0xFF1B5E20), fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEADFD6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Matched Clusters Summary', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF2D2421))),
                  SizedBox(height: 8),
                  Text('• Barabanki Bamboo Cluster (UP) - 450 pcs/mo (Match score: 98%)', style: TextStyle(fontSize: 12, color: Color(0xFF7A685F))),
                  SizedBox(height: 4),
                  Text('• Tripura Cane Collective (NE) - 600 pcs/mo (Match score: 92%)', style: TextStyle(fontSize: 12, color: Color(0xFF7A685F))),
                  SizedBox(height: 4),
                  Text('• Wayanad Natural Fibres (Kerala) - 300 pcs/mo (Match score: 88%)', style: TextStyle(fontSize: 12, color: Color(0xFF7A685F))),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA84318),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: onPublishAndFind,
                child: const Text('View Matched Artisans & Quotes', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BuyerBottomNavBar(
        currentIndex: 2,
        onTap: (idx) {
          if (idx == 0) onOpenHome();
          if (idx == 1) onOpenDiscover();
          if (idx == 2) onOpenRequirements();
        },
      ),
    );
  }
}
