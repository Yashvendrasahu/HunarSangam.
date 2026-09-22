// lib/add_product/screens/catalog_published_screen.dart

import 'package:flutter/material.dart';
import '../models/product_draft.dart';
import '../widgets/distribution_channels_card.dart';
import '../widgets/artisan_bottom_navigation.dart';

/// Screen matching 'p10 — Product Finalized & ONDC Ready.png'
/// Catalog Published! • Active Listing
class CatalogPublishedScreen extends StatelessWidget {
  final ProductDraft draft;
  final VoidCallback onGoToDashboard;
  final VoidCallback onAddAnotherCraft;
  final Function(int)? onNavigateTab;

  const CatalogPublishedScreen({
    super.key,
    required this.draft,
    required this.onGoToDashboard,
    required this.onAddAnotherCraft,
    this.onNavigateTab,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar with Close icon, Title, Active Listing badge
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Color(0xFF1F1612)),
                    onPressed: onGoToDashboard,
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Catalog Published!',
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Live & Verified Banner
                    Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF0E9),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color(0xFFECDACF)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4EDDA),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: const Icon(Icons.verified, color: Color(0xFF2E7D32), size: 24),
                          ),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'B2B READY • ONDC SYNCED',
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1E6B24),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Your Craft is Live & Verified!',
                                  style: TextStyle(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF221C19),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${draft.title.isNotEmpty ? draft.title : 'Handmade Woven Bamboo Fruit Basket'} is now discoverable by verified B2B buyers across India.',
                                  style: const TextStyle(
                                    fontSize: 11.5,
                                    color: Color(0xFF6B584E),
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12.0),

                    // ONDC Network Ready Card
                    Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color(0xFFEADFD6)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top row: ONDC Network Ready
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: const [
                                  Icon(Icons.hub_outlined, color: Color(0xFF2E7D32), size: 18),
                                  SizedBox(width: 6),
                                  Text(
                                    'ONDC Network Ready',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF2E7D32),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFE8DC),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: const Text(
                                  'Pan-India Reach',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFBA4B20),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12.0),

                          // GI Tagged Authenticity
                          Row(
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFAF0E9),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.workspace_premium_outlined, color: Color(0xFF9C3C18), size: 16),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'GI Tagged Craft Authenticity',
                                      style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF221C19)),
                                    ),
                                    Text(
                                      'Assam Cane & Bamboo Crafts (GI Reg #431)',
                                      style: TextStyle(fontSize: 10.5, color: Color(0xFF6B584E)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12.0),

                          // Listing Digital ID with QR Code Button
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAF2EC),
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: const Color(0xFFECDACF)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'Listing Digital ID',
                                      style: TextStyle(fontSize: 10.5, color: Color(0xFF7A685F)),
                                    ),
                                    SizedBox(height: 1),
                                    Text(
                                      '#HS-BAM-8842',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF9C3C18),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: const Color(0xFFECDACF)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Icon(Icons.qr_code, size: 16, color: Color(0xFF221C19)),
                                      SizedBox(width: 4),
                                      Text(
                                        'QR Code',
                                        style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Color(0xFF221C19)),
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

                    const SizedBox(height: 12.0),

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
                          // Photo
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

                          // Summary details
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

                                // Two side-by-side white boxes
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

                                // Capacity & Lead Time
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

                    const SizedBox(height: 12.0),

                    // Distribution Channels Activated
                    const DistributionChannelsCard(),

                    const SizedBox(height: 14.0),

                    // Bright Green WhatsApp Button
                    SizedBox(
                      width: double.infinity,
                      height: 48.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF25D366),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('WhatsApp catalog card link copied to clipboard!'),
                              backgroundColor: Color(0xFF25D366),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.chat, color: Colors.white, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Share Catalog Card on WhatsApp',
                              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 8.0),

                    // Preview note
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

                    const SizedBox(height: 14.0),

                    // Go to Artisan Dashboard Button
                    SizedBox(
                      width: double.infinity,
                      height: 48.0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF9C3C18),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: onGoToDashboard,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Go to Artisan Dashboard',
                              style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, size: 18),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10.0),

                    // + Add Another Craft (Voice)
                    SizedBox(
                      width: double.infinity,
                      height: 46.0,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFFFAF0E9),
                          side: const BorderSide(color: Color(0xFFE5D5CB)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: onAddAnotherCraft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.mic_none, color: Color(0xFF9C3C18), size: 18),
                            SizedBox(width: 6),
                            Text(
                              '+ Add Another Craft (Voice)',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF221C19),
                              ),
                            ),
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
