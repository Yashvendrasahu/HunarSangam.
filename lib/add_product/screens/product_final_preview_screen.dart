// lib/add_product/screens/product_final_preview_screen.dart

import 'package:flutter/material.dart';
import '../models/product_draft.dart';
import '../widgets/distribution_channels_card.dart';
import '../widgets/artisan_bottom_navigation.dart';

/// Screen matching 'p9-final preview ar.png'
/// Preview Product • Active Listing
class ProductFinalPreviewScreen extends StatelessWidget {
  final ProductDraft draft;
  final VoidCallback onSubmitPublish;
  final VoidCallback onBack;
  final Function(int)? onNavigateTab;

  const ProductFinalPreviewScreen({
    super.key,
    required this.draft,
    required this.onSubmitPublish,
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
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF1F1612)),
                    onPressed: onBack,
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Preview Product',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1F1612),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4EDDA),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(color: Color(0xFF2E7D32), shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 4.0),
                        const Text(
                          'Active Listing',
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
            ),

            // Scrollable Body
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Summary Card
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF2EC),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color(0xFFECDACF)),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Photo with Verified Dimensions and ₹10 Coin badges
                          Stack(
                            children: [
                              Image.network(
                                draft.photoUrl.isNotEmpty
                                    ? draft.photoUrl
                                    : 'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=800&auto=format&fit=crop&q=80',
                                height: 165.0,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 10.0,
                                left: 10.0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.verified_outlined, color: Color(0xFF2E7D32), size: 13.0),
                                      SizedBox(width: 4.0),
                                      Text(
                                        'Verified Dimensions',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xFF221C19),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10.0,
                                right: 10.0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.75),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.camera_alt_outlined, color: Colors.white, size: 12.0),
                                      SizedBox(width: 4.0),
                                      Text(
                                        'Verified with ₹10 coin',
                                        style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Text Info
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'PRODUCT CATALOG SUMMARY',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFFBA4B20),
                                    letterSpacing: 0.6,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  draft.title.isNotEmpty ? draft.title : 'Handmade Woven Bamboo Fruit Basket',
                                  style: const TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF221C19),
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(height: 12.0),

                                // Two side-by-side white info containers
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10.0),
                                          border: Border.all(color: const Color(0xFFECDACF)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Wholesale Unit Price',
                                              style: TextStyle(fontSize: 10.5, color: Color(0xFF7A685F)),
                                            ),
                                            const SizedBox(height: 2),
                                            RichText(
                                              text: TextSpan(
                                                text: '₹${draft.basePrice > 0 ? draft.basePrice.toInt() : 280}',
                                                style: const TextStyle(
                                                  fontSize: 16.5,
                                                  fontWeight: FontWeight.w900,
                                                  color: Color(0xFF9C3C18),
                                                ),
                                                children: const [
                                                  TextSpan(
                                                    text: ' / pc',
                                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF6B584E)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10.0),
                                          border: Border.all(color: const Color(0xFFECDACF)),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Specifications',
                                              style: TextStyle(fontSize: 10.5, color: Color(0xFF7A685F)),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              '${draft.diameterIn > 0 ? draft.diameterIn : 12.4}" W × ${draft.heightIn > 0 ? draft.heightIn : 6.2}" H',
                                              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF221C19)),
                                            ),
                                            Text(
                                              'Weight: ${draft.estWeightGrams > 0 ? draft.estWeightGrams : 420}g',
                                              style: const TextStyle(fontSize: 10.5, color: Color(0xFF6B584E)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10.0),

                                // Capacity & Lead Time Row
                                Row(
                                  children: [
                                    const Icon(Icons.inbox_outlined, size: 14, color: Color(0xFF9C3C18)),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Capacity: ${draft.dailyCapacityPcs > 0 ? draft.dailyCapacityPcs : 15} pcs / day',
                                      style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Color(0xFF221C19)),
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.access_time, size: 14, color: Color(0xFF2E7D32)),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Lead: ${draft.leadTime.isNotEmpty ? draft.leadTime : '5 - 7 days'}',
                                      style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Color(0xFF221C19)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14.0),

                    // Distribution Channels Activated Card
                    const DistributionChannelsCard(),

                    const SizedBox(height: 14.0),

                    // Product Description Box
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF2EC),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(color: const Color(0xFFECDACF)),
                      ),
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              draft.description.isNotEmpty
                                  ? draft.description
                                  : 'Handcrafted from 100% natural treated Assam bamboo with traditional lattice weave, double rim reinforcement, and food-safe finish. Ideal for dining storage, eco-friendly gift hampers, and artisanal home decor.',
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Color(0xFF4A372D),
                                height: 1.4,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF3DCCE),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.mic, size: 16, color: Color(0xFF9C3C18)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12.0),

                    // WhatsApp Preview Note
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF2EC),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: const Color(0xFFECDACF)),
                      ),
                      child: const Text(
                        'Preview: "Namaste! View my new verified craft catalog on HunarSangam..."',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Color(0xFF6B584E),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16.0),

                    // Submit & publish product button
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
                        onPressed: onSubmitPublish,
                        child: const Text(
                          'Submit & publish product',
                          style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w800),
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
