// lib/add_product/screens/dimension_review_screen.dart

import 'package:flutter/material.dart';
import '../models/product_draft.dart';
import '../widgets/artisan_bottom_navigation.dart';
import '../../widgets/craft_image.dart';

/// Screen matching 'p4— photo and dimension review.png'
/// Step 2 of 2 • Dimension Tool • ₹10 Coin Size Detector
class DimensionReviewScreen extends StatelessWidget {
  final ProductDraft draft;
  final VoidCallback onAccept;
  final VoidCallback onRetake;
  final VoidCallback onBack;
  final Function(int)? onNavigateTab;

  const DimensionReviewScreen({
    super.key,
    required this.draft,
    required this.onAccept,
    required this.onRetake,
    required this.onBack,
    this.onNavigateTab,
  });

  @override
  Widget build(BuildContext context) {
    final craftCategory = draft.category.isNotEmpty ? draft.category : draft.title;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF1F1612)),
                    onPressed: onBack,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'STEP 2 OF 2 • DIMENSION TOOL',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFBA4B20),
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(height: 2),
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
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6EAE2),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(color: const Color(0xFFE5D5CB)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.volume_up, size: 16, color: Color(0xFF8C3A16)),
                        SizedBox(width: 4.0),
                        Text(
                          'मदद',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF8C3A16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Two side-by-side photos
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 175,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CraftImage(
                                  imageSource: draft.photoUrl,
                                  craftCategoryOrTitle: craftCategory,
                                  fit: BoxFit.cover,
                                ),
                                // Corner Guides on coin detection photo
                                Positioned(
                                  top: 10,
                                  left: 10,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(color: Colors.white, width: 2),
                                        left: BorderSide(color: Colors.white, width: 2),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        top: BorderSide(color: Colors.white, width: 2),
                                        right: BorderSide(color: Colors.white, width: 2),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  left: 10,
                                  child: Container(
                                    width: 16,
                                    height: 16,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.white, width: 2),
                                        left: BorderSide(color: Colors.white, width: 2),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Container(
                            height: 175,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: CraftImage(
                              imageSource: draft.secondaryPhotoUrl.isNotEmpty ? draft.secondaryPhotoUrl : draft.photoUrl,
                              craftCategoryOrTitle: craftCategory,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12.0),

                    // Retake Photo Button
                    SizedBox(
                      width: double.infinity,
                      height: 42.0,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.refresh, size: 16, color: Color(0xFF3B2A22)),
                        label: const Text(
                          'Retake Photo',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF3B2A22),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFF9EFE9),
                          side: const BorderSide(color: Color(0xFFE4D3C6)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: onRetake,
                      ),
                    ),

                    const SizedBox(height: 12.0),

                    // Zero-Typing Voice Correction Card
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBF2EC),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(color: const Color(0xFFECDACF)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              color: Color(0xFF9C3C18),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.mic, color: Colors.white, size: 18),
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Zero-Typing Voice Correction',
                                  style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF221C19),
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                RichText(
                                  text: const TextSpan(
                                    text: 'Say: ',
                                    style: TextStyle(fontSize: 11.5, color: Color(0xFF6B584E)),
                                    children: [
                                      TextSpan(
                                        text: '"ऊंचाई 6 इंच करो"',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFFBA4B20),
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' or tap values to fine-tune.',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.hearing_outlined, color: Color(0xFF8C3A16), size: 22),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14.0),

                    // Computer Vision Output Container
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color(0xFFEADFD6)),
                      ),
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'COMPUTER VISION OUTPUT',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF2E7D32),
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  SizedBox(height: 2.0),
                                  Text(
                                    'Detected Dimensions',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF221C19),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD4EDDA),
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 12),
                                    SizedBox(width: 4.0),
                                    Text(
                                      'Auto-Calculated',
                                      style: TextStyle(
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF1E6B24),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12.0),

                          // 3 Metric Boxes: Diameter, Height, Est. Weight
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFAF3EE),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('Diameter', style: TextStyle(fontSize: 10.5, color: Color(0xFF6B584E))),
                                          Icon(Icons.swap_horiz, size: 14, color: Color(0xFF6B584E)),
                                        ],
                                      ),
                                      const SizedBox(height: 4.0),
                                      RichText(
                                        text: TextSpan(
                                          text: '${draft.diameterIn.toStringAsFixed(1)} ',
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF221C19)),
                                          children: const [
                                            TextSpan(text: 'in', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '${(draft.diameterIn * 2.54).toStringAsFixed(1)} cm',
                                        style: const TextStyle(fontSize: 10.0, color: Color(0xFF8B776E)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFAF3EE),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('Height', style: TextStyle(fontSize: 10.5, color: Color(0xFF6B584E))),
                                          Icon(Icons.swap_vert, size: 14, color: Color(0xFF6B584E)),
                                        ],
                                      ),
                                      const SizedBox(height: 4.0),
                                      RichText(
                                        text: TextSpan(
                                          text: '${draft.heightIn.toStringAsFixed(1)} ',
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF221C19)),
                                          children: const [
                                            TextSpan(text: 'in', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        '${(draft.heightIn * 2.54).toStringAsFixed(1)} cm',
                                        style: const TextStyle(fontSize: 10.0, color: Color(0xFF8B776E)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFAF3EE),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('Est. Weight', style: TextStyle(fontSize: 10.5, color: Color(0xFF6B584E))),
                                          Icon(Icons.scale_outlined, size: 14, color: Color(0xFF6B584E)),
                                        ],
                                      ),
                                      const SizedBox(height: 4.0),
                                      RichText(
                                        text: TextSpan(
                                          text: '~${draft.estWeightGrams.toInt()} ',
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF221C19)),
                                          children: const [
                                            TextSpan(text: 'g', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      const Text(
                                        'Light Cane',
                                        style: TextStyle(fontSize: 10.0, color: Color(0xFF2E7D32), fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12.0),

                          // Packaging Box Recommendation Card
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDF7F3),
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: const Color(0xFFECDACF)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF3E4DA),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: const Icon(Icons.archive_outlined, size: 18, color: Color(0xFF9C3C18)),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            'Recommended Packaging Box',
                                            style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Color(0xFF221C19)),
                                          ),
                                          const SizedBox(width: 6.0),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.5),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFFE8DC),
                                              borderRadius: BorderRadius.circular(4.0),
                                            ),
                                            child: const Text(
                                              'B2B Ready',
                                              style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w700, color: Color(0xFFBA4B20)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 2.0),
                                      const Text(
                                        '14 × 14 × 8 in Corrugated Carton.',
                                        style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: Color(0xFF6B584E)),
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

                    const SizedBox(height: 16.0),

                    // Accept Dimensions & Proceed Button
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF9C3C18),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        onPressed: onAccept,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Accept Dimensions & Proceed',
                              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(width: 8.0),
                            Icon(Icons.arrow_forward, size: 18),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16.0),
                  ],
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
