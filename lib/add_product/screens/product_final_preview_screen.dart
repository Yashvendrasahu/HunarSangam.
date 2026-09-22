// lib/add_product/screens/product_final_preview_screen.dart

import 'package:flutter/material.dart';
import '../models/product_draft.dart';
import '../widgets/add_product_app_bar.dart';
import '../widgets/distribution_channels_card.dart';
import '../widgets/artisan_bottom_navigation.dart';

/// Screen 9: Matches 'p9-final preview ar.png'
/// Preview Product - Active Listing
/// - Verified Dimensions & ₹10 coin photo badges
/// - Product summary: Price (₹280/pc), Specs (12.4" W × 6.2" H, 420g), Capacity (15 pcs/day), Lead (5-7 days)
/// - Distribution Channels Activated (3 Active)
/// - Product description with voice icon
/// - WhatsApp share preview
/// - "Submit & publish product" CTA button
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
      appBar: AddProductAppBar(
        title: 'Preview Product',
        badgeText: 'Active Listing',
        badgeColor: const Color(0xFFE8F5E9),
        badgeTextColor: const Color(0xFF2E7D32),
        onBack: onBack,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Catalog Card
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDFB),
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Photo with Verified Badges
                    Stack(
                      children: [
                        Image.network(
                          draft.photoUrl,
                          height: 170.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, stack) => Container(
                            height: 170.0,
                            color: const Color(0xFFF3E7DF),
                            child: const Center(
                              child: Icon(Icons.shopping_basket_outlined, size: 48.0, color: Color(0xFF8C3A16)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10.0,
                          left: 10.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.verified, color: Color(0xFF69F0AE), size: 12.0),
                                SizedBox(width: 4.0),
                                Text(
                                  'Verified Dimensions',
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
                        Positioned(
                          bottom: 10.0,
                          right: 10.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.monetization_on, color: Color(0xFFFFD54F), size: 12.0),
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
                              color: Color(0xFF7A685F),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            draft.title,
                            style: const TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF221C19),
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 10.0),

                          // Specs Grid
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFBF4EE),
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: const Color(0xFFEADFD6)),
                            ),
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Wholesale Unit Price',
                                      style: TextStyle(fontSize: 11.5, color: Color(0xFF7A685F)),
                                    ),
                                    Text(
                                      '₹${draft.basePrice} / pc',
                                      style: const TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF8C3A16),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Specifications',
                                      style: TextStyle(fontSize: 11.5, color: Color(0xFF7A685F)),
                                    ),
                                    Text(
                                      '${draft.diameterIn}" W × ${draft.heightIn}" H, Wt: ${draft.estWeightGrams}g',
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF221C19),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '📈 Capacity: ${draft.dailyCapacityPcs} pcs / day',
                                      style: const TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF2E7D32),
                                      ),
                                    ),
                                    Text(
                                      '⏱️ Lead: ${draft.leadTime}',
                                      style: const TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF7A685F),
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
                  color: const Color(0xFFFFFDFB),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Product Description',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF221C19),
                          ),
                        ),
                        Icon(Icons.mic_none_rounded, size: 16.0, color: Color(0xFF8C3A16)),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      draft.description,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF4A372D),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12.0),

              // WhatsApp Share Preview Note
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: const Color(0xFFDCFCE7)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFF16A34A), size: 16.0),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        'Preview: "Namaste! View my new verified craft catalog on HunarSangam..."',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Color(0xFF15803D),
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18.0),

              // Submit & Publish Button
              SizedBox(
                width: double.infinity,
                height: 52.0,
                child: ElevatedButton(
                  onPressed: onSubmitPublish,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8C3A16),
                    foregroundColor: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.publish_rounded, size: 18.0),
                      SizedBox(width: 8.0),
                      Text(
                        'Submit & publish product',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ArtisanBottomNavigation(
        currentIndex: 1,
        onTap: onNavigateTab,
      ),
    );
  }
}
