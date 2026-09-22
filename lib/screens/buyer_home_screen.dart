// lib/screens/buyer_home_screen.dart

import 'package:flutter/material.dart';
import '../models/buyer_onboarding_model.dart';
import '../widgets/buyer_bottom_nav_bar.dart';
import '../widgets/brand_logo_card.dart';

class BuyerHomeScreen extends StatelessWidget {
  final BuyerOnboardingModel? model;
  final BuyerOnboardingModel? buyerModel;
  final VoidCallback? onLogout;
  final VoidCallback onOpenSearch;
  final VoidCallback onOpenDiscover;
  final VoidCallback onPostRequirement;
  final VoidCallback? onOpenFeatured;
  final VoidCallback? onOpenPopular;
  final Function(String query)? onSearchByQuery;
  final Function(int)? onTabChange;

  const BuyerHomeScreen({
    super.key,
    this.model,
    this.buyerModel,
    this.onLogout,
    required this.onOpenSearch,
    required this.onOpenDiscover,
    required this.onPostRequirement,
    this.onOpenFeatured,
    this.onOpenPopular,
    this.onSearchByQuery,
    this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    final activeModel = model ?? buyerModel ?? const BuyerOnboardingModel();

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const HunarSangamLogoBadge(size: 40.0),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, ${activeModel.businessName.isNotEmpty ? activeModel.businessName : "FabIndia"}',
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Color(0xFF2D2421)),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Direct-from-Cluster Sourcing Network',
                            style: TextStyle(fontSize: 11.5, color: Color(0xFF7A685F)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: onOpenSearch,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFEADFD6)),
                      ),
                      child: const Icon(Icons.search, color: Color(0xFFA84318)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Search Bar Prompt
              InkWell(
                onTap: onOpenSearch,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFEADFD6)),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.search, color: Color(0xFF8D6E63), size: 20),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Search GI crafts, clusters, or artisans...',
                          style: TextStyle(color: Color(0xFF8D6E63), fontSize: 13),
                        ),
                      ),
                      Icon(Icons.mic_none, color: Color(0xFFA84318), size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Post Bulk Requirement Banner
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8D3412), Color(0xFFA84318)],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Have a custom B2B requirement?',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Record voice requirements or upload reference photos to get matched with certified clusters in 2 hours.',
                      style: TextStyle(color: Color(0xFFFFD4C2), fontSize: 12, height: 1.4),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFFA84318),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      onPressed: onPostRequirement,
                      child: const Text('Post Bulk Requirement', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12.5)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Featured Artisans Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Featured Master Artisans', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF2D2421))),
                  TextButton(
                    onPressed: onOpenFeatured ?? onOpenDiscover,
                    child: const Text('See all', style: TextStyle(color: Color(0xFFA84318), fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _buildArtisanCard('Ramu Kumar', 'Master Bamboo & Cane Weaver', 'Barabanki, UP • 450 pcs/mo capacity', '4.9 ★ (120+ reviews)', onOpenDiscover),
              const SizedBox(height: 12),
              _buildArtisanCard('Devika Rani', 'Blue Pottery & Terracotta Master', 'Jaipur, Rajasthan • 300 pcs/mo', '4.8 ★ (85 reviews)', onOpenPopular ?? onOpenDiscover),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BuyerBottomNavBar(
        currentIndex: 0,
        onTap: (idx) => onTabChange?.call(idx),
      ),
    );
  }

  Widget _buildArtisanCard(String name, String craft, String cluster, String rating, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFEADFD6)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: const Color(0xFFFAF6F2),
              child: Text(name.substring(0, 1), style: const TextStyle(color: Color(0xFFA84318), fontWeight: FontWeight.w800, fontSize: 18)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5, color: Color(0xFF2D2421))),
                  const SizedBox(height: 2),
                  Text(craft, style: const TextStyle(fontSize: 12, color: Color(0xFFA84318), fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text(cluster, style: const TextStyle(fontSize: 11, color: Color(0xFF7A685F))),
                ],
              ),
            ),
            Text(rating, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF2E7D32))),
          ],
        ),
      ),
    );
  }
}
