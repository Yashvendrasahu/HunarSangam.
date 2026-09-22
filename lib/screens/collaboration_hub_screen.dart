// lib/screens/collaboration_hub_screen.dart

import 'package:flutter/material.dart';
import '../models/onboarding_state.dart';
import '../add_product/widgets/artisan_bottom_navigation.dart';

class CollaborationHubScreen extends StatelessWidget {
  final OnboardingState? state;
  final VoidCallback onBack;
  final ValueChanged<int>? onNavigateTab;
  final VoidCallback? onOpenFormCollective;
  final VoidCallback? onOpenSuggestedArtisans;
  final Function(String buyerName, String title)? onChatWithBuyer;

  const CollaborationHubScreen({
    super.key,
    this.state,
    required this.onBack,
    this.onNavigateTab,
    this.onOpenFormCollective,
    this.onOpenSuggestedArtisans,
    this.onChatWithBuyer,
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
          'Artisan Guild & Collaboration Hub',
          style: TextStyle(color: Color(0xFF2D2421), fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  Row(
                    children: const [
                      Icon(Icons.groups, color: Colors.white, size: 28),
                      SizedBox(width: 10),
                      Text(
                        'Cluster Splitting & Scaling',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Form artisan collectives, share large 500+ unit bulk orders, and pool materials with nearby cluster weavers.',
                    style: TextStyle(color: Color(0xFFFFD4C2), fontSize: 12.5, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA84318),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.group_add, size: 18),
                    label: const Text('Form Collective', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                    onPressed: onOpenFormCollective,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFA84318),
                      side: const BorderSide(color: Color(0xFFA84318)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.person_search, size: 18),
                    label: const Text('Find Artisans', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                    onPressed: onOpenSuggestedArtisans,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Active Cluster Opportunities',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF2D2421)),
            ),
            const SizedBox(height: 12),
            _buildGuildOpportunityCard(
              title: 'Handcrafted Terracotta Planters',
              buyer: 'The Bombay Store (Mumbai)',
              quantityNeeded: '200 pcs (Pool of 4 Artisans)',
              payout: '₹320 / unit • ₹64,000 total',
              deadline: '10 Days Left',
            ),
            const SizedBox(height: 12),
            _buildGuildOpportunityCard(
              title: 'Golden Bamboo Serving Trays',
              buyer: 'FabIndia Retail Network',
              quantityNeeded: '150 pcs (Pool of 3 Artisans)',
              payout: '₹410 / unit • ₹61,500 total',
              deadline: '14 Days Left',
            ),
          ],
        ),
      ),
      bottomNavigationBar: onNavigateTab != null
          ? ArtisanBottomNavigation(
              currentIndex: 3,
              onTabSelected: onNavigateTab,
            )
          : null,
    );
  }

  Widget _buildGuildOpportunityCard({
    required String title,
    required String buyer,
    required String quantityNeeded,
    required String payout,
    required String deadline,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(buyer, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFA84318))),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(deadline, style: const TextStyle(fontSize: 10, color: Color(0xFFE65100), fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: Color(0xFF2D2421))),
          const SizedBox(height: 4),
          Text(quantityNeeded, style: const TextStyle(fontSize: 12, color: Color(0xFF7A685F))),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(payout, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF2E7D32))),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA84318),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                icon: const Icon(Icons.chat_bubble_outline, size: 14),
                label: const Text('Chat with Buyer', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700)),
                onPressed: () => onChatWithBuyer?.call(buyer, title),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
