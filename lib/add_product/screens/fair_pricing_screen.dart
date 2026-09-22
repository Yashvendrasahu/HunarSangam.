// lib/add_product/screens/fair_pricing_screen.dart

import 'package:flutter/material.dart';
import '../models/product_draft.dart';
import '../widgets/artisan_bottom_navigation.dart';

class FairPricingScreen extends StatefulWidget {
  final ProductDraft draft;
  final ValueChanged<double> onLockPrice;
  final VoidCallback onBack;
  final Function(int)? onNavigateTab;

  const FairPricingScreen({
    super.key,
    required this.draft,
    required this.onLockPrice,
    required this.onBack,
    this.onNavigateTab,
  });

  @override
  State<FairPricingScreen> createState() => _FairPricingScreenState();
}

class _FairPricingScreenState extends State<FairPricingScreen> {
  late double _selectedPrice;

  @override
  void initState() {
    super.initState();
    _selectedPrice = widget.draft.basePrice > 0 ? widget.draft.basePrice : 320.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D2421)),
          onPressed: widget.onBack,
        ),
        title: const Text(
          'Fair Wage & Pricing Intelligence (Step 5 of 8)',
          style: TextStyle(color: Color(0xFF2D2421), fontSize: 15, fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFC8E6C9)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.verified_outlined, color: Color(0xFF2E7D32), size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'AI Fair Price Recommendation: Ensures minimum ₹350/day dignified artisan living wage + material cost.',
                      style: TextStyle(color: Color(0xFF1B5E20), fontSize: 12.5, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEADFD6)),
              ),
              child: Column(
                children: [
                  const Text('Suggested Base Price per Unit (Wholesale)', style: TextStyle(color: Color(0xFF7A685F), fontSize: 13)),
                  const SizedBox(height: 8),
                  Text('₹${_selectedPrice.toInt()}', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFFA84318))),
                  Slider(
                    value: _selectedPrice,
                    min: 150.0,
                    max: 1200.0,
                    divisions: 105,
                    activeColor: const Color(0xFFA84318),
                    onChanged: (val) => setState(() => _selectedPrice = val),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Min: ₹150', style: TextStyle(fontSize: 11, color: Color(0xFF8D6E63))),
                      Text('Max: ₹1,200', style: TextStyle(fontSize: 11, color: Color(0xFF8D6E63))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA84318),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => widget.onLockPrice(_selectedPrice),
                child: const Text('Lock Fair Price & Continue', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.onNavigateTab != null
          ? ArtisanBottomNavigation(
              currentIndex: 1,
              onTabSelected: widget.onNavigateTab,
            )
          : null,
    );
  }
}
