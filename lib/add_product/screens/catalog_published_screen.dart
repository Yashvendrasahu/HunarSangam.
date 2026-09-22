// lib/add_product/screens/catalog_published_screen.dart

import 'package:flutter/material.dart';
import '../models/product_draft.dart';
import '../widgets/artisan_bottom_navigation.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle_rounded, color: Color(0xFF2E7D32), size: 48),
              ),
              const SizedBox(height: 20),
              const Text(
                'Product Published Successfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF2D2421),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${draft.title} is now active and synced with ONDC buyer networks for B2B discovery.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13, color: Color(0xFF7A685F), height: 1.4),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA84318),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: onGoToDashboard,
                  child: const Text('Go to Home Dashboard', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFA84318),
                    side: const BorderSide(color: Color(0xFFA84318), width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: onAddAnotherCraft,
                  child: const Text('Add Another Craft', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                ),
              ),
            ],
          ),
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
}
