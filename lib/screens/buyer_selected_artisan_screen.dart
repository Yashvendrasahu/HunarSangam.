// lib/screens/buyer_selected_artisan_screen.dart

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';

class BuyerSelectedArtisanScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onSelectAndReviewOrder;
  final VoidCallback onMessageArtisan;
  final VoidCallback onOpenRequirements;
  final VoidCallback onOpenDiscover;
  final VoidCallback onOpenHome;

  const BuyerSelectedArtisanScreen({
    super.key,
    required this.onBack,
    required this.onSelectAndReviewOrder,
    required this.onMessageArtisan,
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
        title: const Text('Matched Artisan Selected', style: TextStyle(color: Color(0xFF2D2421), fontSize: 16, fontWeight: FontWeight.w800)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEADFD6)),
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80'),
                  ),
                  SizedBox(height: 10),
                  Text('Ramu Kumar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF2D2421))),
                  Text('Master Bamboo Weaver (Barabanki)', style: TextStyle(fontSize: 13, color: Color(0xFFA84318), fontWeight: FontWeight.w700)),
                  SizedBox(height: 12),
                  Text('Quote for 200 pcs: ₹56,000 (₹280/pc)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF2E7D32))),
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
                onPressed: onSelectAndReviewOrder,
                child: const Text('Generate Escrow Agreement & Pay 40%', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFA84318),
                  side: const BorderSide(color: Color(0xFFA84318)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: onMessageArtisan,
                child: const Text('Chat with Artisan First', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5)),
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
