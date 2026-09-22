// lib/add_product/screens/dimension_review_screen.dart

import 'package:flutter/material.dart';
import '../models/product_draft.dart';
import '../widgets/artisan_bottom_navigation.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D2421)),
          onPressed: onBack,
        ),
        title: const Text(
          'Review Dimensions (Step 3 of 8)',
          style: TextStyle(color: Color(0xFF2D2421), fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(draft.photoUrl),
                  fit: BoxFit.cover,
                ),
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
                children: [
                  _buildDimRow('Diameter / Width', '${draft.diameterIn}" (30.5 cm)'),
                  const Divider(height: 18, color: Color(0xFFEADBCE)),
                  _buildDimRow('Height', '${draft.heightIn}" (21.6 cm)'),
                  const Divider(height: 18, color: Color(0xFFEADBCE)),
                  _buildDimRow('Estimated Weight', '${draft.estWeightGrams} grams'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFA84318),
                      side: const BorderSide(color: Color(0xFFA84318)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: onRetake,
                    child: const Text('Retake Photo', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA84318),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: onAccept,
                    child: const Text('Looks Great', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: onNavigateTab != null
          ? ArtisanBottomNavigation(
              currentIndex: 1,
              onTabSelected: onNavigateTab,
            )
          : null,
    );
  }

  Widget _buildDimRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 13.5, color: Color(0xFF7A685F), fontWeight: FontWeight.w500)),
        Text(value, style: const TextStyle(fontSize: 14.5, color: Color(0xFF2D2421), fontWeight: FontWeight.w800)),
      ],
    );
  }
}
