// lib/add_product/screens/coin_detector_ar_screen.dart

import 'package:flutter/material.dart';
import '../models/product_draft.dart';
import '../widgets/artisan_bottom_navigation.dart';

class CoinDetectorArScreen extends StatelessWidget {
  final ProductDraft draft;
  final VoidCallback onCapture;
  final VoidCallback onBack;
  final Function(int)? onNavigateTab;

  const CoinDetectorArScreen({
    super.key,
    required this.draft,
    required this.onCapture,
    required this.onBack,
    this.onNavigateTab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1614),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: onBack,
        ),
        title: const Text(
          '₹10 Coin AR Detector (Step 2 of 8)',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(draft.photoUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 60,
                  left: 40,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D32).withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.check_circle, color: Colors.white, size: 16),
                        SizedBox(width: 6),
                        Text(
                          '₹10 Coin Detected (27mm standard)',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 40,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('AI Estimated Dimensions:', style: TextStyle(color: Color(0xFFEADFD6), fontSize: 11)),
                        SizedBox(height: 4),
                        Text('Diameter: 12.0" (30.5 cm)', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800)),
                        Text('Height: 8.5" (21.6 cm)', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.black,
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA84318),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: onCapture,
                child: const Text('Confirm AI Measurements', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: onNavigateTab != null
          ? ArtisanBottomNavigation(
              currentIndex: 1,
              onTabSelected: onNavigateTab,
            )
          : null,
    );
  }
}
