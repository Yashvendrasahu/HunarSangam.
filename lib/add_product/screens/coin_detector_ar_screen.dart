// lib/add_product/screens/coin_detector_ar_screen.dart

import 'package:flutter/material.dart';
import '../models/product_draft.dart';
import '../widgets/artisan_bottom_navigation.dart';
import '../widgets/artisan_studio_tips.dart';

/// Screen matching 'p3 — Camera-First Add Photo with 10 rupes.png'
/// Step 1 of 2 • Product Photography • ₹10 Coin Size Detector with Live AR Overlay
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
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF1F1612)),
                      onPressed: onBack,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'STEP 1 OF 2',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFBA4B20),
                          letterSpacing: 0.8,
                        ),
                      ),
                      Text(
                        'Product Photography',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1F1612),
                        ),
                      ),
                      Text(
                        '₹10 Coin Size Detector',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1F1612),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Live AR Viewfinder Frame with measurement overlays
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=800&auto=format&fit=crop&q=80',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Corner Brackets
                    Positioned(
                      top: 14,
                      right: 14,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.white, width: 2.5),
                            right: BorderSide(color: Colors.white, width: 2.5),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 14,
                      left: 14,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.white, width: 2.5),
                            left: BorderSide(color: Colors.white, width: 2.5),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 14,
                      right: 14,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.white, width: 2.5),
                            right: BorderSide(color: Colors.white, width: 2.5),
                          ),
                        ),
                      ),
                    ),

                    // Top Left Live 60fps pill
                    Positioned(
                      top: 14,
                      left: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.65),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.videocam_outlined, size: 13, color: Colors.white),
                            SizedBox(width: 4.0),
                            Text(
                              'Live\n60fps',
                              style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.w700, height: 1.1),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Top Measurement Line & Tag: Top 12.4 in (31.5 cm)
                    Positioned(
                      top: 70,
                      left: 45,
                      right: 45,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF69F0AE), shape: BoxShape.circle)),
                              Expanded(child: Container(height: 2, color: const Color(0xFF69F0AE))),
                              Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFF69F0AE), shape: BoxShape.circle)),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.75),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.straighten, size: 11, color: Color(0xFF69F0AE)),
                                SizedBox(width: 4.0),
                                Text(
                                  'Top: 12.4 in (31.5 cm)',
                                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Base Measurement Line & Tag: Base 8.1 in (20.5 cm)
                    Positioned(
                      bottom: 120,
                      left: 75,
                      right: 75,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Container(width: 5, height: 5, decoration: const BoxDecoration(color: Color(0xFF69F0AE), shape: BoxShape.circle)),
                              Expanded(child: Container(height: 1.5, color: const Color(0xFF69F0AE))),
                              Container(width: 5, height: 5, decoration: const BoxDecoration(color: Color(0xFF69F0AE), shape: BoxShape.circle)),
                            ],
                          ),
                          const SizedBox(height: 3.0),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Text(
                              'Base: 8.1 in (20.5 cm)',
                              style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Height Vertical Guide and Tag
                    Positioned(
                      right: 25,
                      top: 85,
                      bottom: 125,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 2,
                            color: const Color(0xFF69F0AE),
                          ),
                          const SizedBox(width: 6.0),
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.75),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Height', style: TextStyle(fontSize: 9, color: Color(0xFF69F0AE), fontWeight: FontWeight.w700)),
                                Text('6.2 in (15.7 cm)', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Colors.white)),
                                Text('±0.1 cm', style: TextStyle(fontSize: 8, color: Colors.white70)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Bottom-left Coin Lock Indicator
                    Positioned(
                      bottom: 25,
                      left: 20,
                      child: Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: const Color(0xFF69F0AE), width: 2),
                              color: Colors.black.withOpacity(0.4),
                            ),
                            child: const Center(
                              child: Icon(Icons.check, size: 18, color: Color(0xFF69F0AE)),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.75),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text(
                                  '● ₹10 Coin Locked',
                                  style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF69F0AE)),
                                ),
                                Text(
                                  'Standard 27.00 mm scale',
                                  style: TextStyle(fontSize: 8.5, color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Artisan Studio Tips Box
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: ArtisanStudioTips(),
            ),

            // Shutter Button
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 10.0),
              child: GestureDetector(
                onTap: onCapture,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF3D5C5),
                    border: Border.all(color: const Color(0xFFE5BFA8), width: 3),
                  ),
                  child: Center(
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF9C3C18),
                      ),
                      child: const Center(
                        child: Text(
                          'Click',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ArtisanBottomNavigation(
        currentIndex: 1, // Products
        onTap: onNavigateTab,
      ),
    );
  }
}
