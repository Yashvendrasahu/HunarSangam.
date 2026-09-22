// lib/screens/buyer_home_screen.dart

import 'package:flutter/material.dart';
import '../models/buyer_onboarding_model.dart';
import '../widgets/buyer_bottom_nav_bar.dart';

/// Screen: Bulk Buyer Home Dashboard
/// Exactly reproduces 'home - bulk buyer.png'
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

  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFDFBF9);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);

  @override
  Widget build(BuildContext context) {
    final activeModel = model ?? buyerModel ?? const BuyerOnboardingModel();
    final buyerName = activeModel.yourName.isNotEmpty ? activeModel.yourName.split(' ').first : 'Vikram';
    final businessName = activeModel.businessName.isNotEmpty ? activeModel.businessName : 'FabCraft Living';

    return Scaffold(
      backgroundColor: _bgCanvas,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar with Brand, Bulk Buyer tag, Language, Notification, Avatar
              _buildTopBar(context),
              const SizedBox(height: 18.0),

              // Greeting & Business account badge
              Text(
                'Good morning, $buyerName 👋',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: _textDark,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 3.0),
              const Text(
                'Find the right handmade products for your business.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: _textMuted,
                ),
              ),
              const SizedBox(height: 12.0),

              // Account badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3ECE6),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.storefront_outlined, size: 16, color: Color(0xFF2E7D32)),
                    const SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          businessName,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: _textDark,
                          ),
                        ),
                        const Text(
                          'Bulk Buyer Account',
                          style: TextStyle(
                            fontSize: 10,
                            color: _textMuted,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Search Bar with Mic button
              InkWell(
                onTap: onOpenSearch,
                borderRadius: BorderRadius.circular(14.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(color: const Color(0xFFE8DDD5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Color(0xFF8D6E63), size: 20),
                      const SizedBox(width: 10.0),
                      const Expanded(
                        child: Text(
                          'What are you looking for?',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF8D6E63),
                          ),
                        ),
                      ),
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: _primaryRust,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Icon(Icons.mic, color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Hero Card: Need products in bulk?
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8D3412), Color(0xFFA64016)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.local_offer_outlined, color: Colors.white, size: 12),
                          SizedBox(width: 5.0),
                          Text(
                            'Direct Artisan Sourcing',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                      'Need products in bulk?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'Tell us what you need and connect with suitable artisans directly.',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: onPostRequirement,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: _primaryRust,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add_circle_outline, size: 16, color: _primaryRust),
                            SizedBox(width: 6.0),
                            Text(
                              'Post a Requirement',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w800,
                                color: _primaryRust,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Dual Quick Action Cards: Discover & Requirements
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onOpenDiscover,
                      borderRadius: BorderRadius.circular(14.0),
                      child: Container(
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(color: const Color(0xFFEFE8E2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 34,
                                  height: 34,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFBF0EA),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.explore_outlined, color: _primaryRust, size: 18),
                                ),
                                const Icon(Icons.arrow_forward, size: 16, color: Color(0xFFB0A298)),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            const Text(
                              'Discover',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: _textDark,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            const Text(
                              'Find handmade products',
                              style: TextStyle(
                                fontSize: 11,
                                color: _textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: InkWell(
                      onTap: () => onTabChange?.call(2),
                      borderRadius: BorderRadius.circular(14.0),
                      child: Container(
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(color: const Color(0xFFEFE8E2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 34,
                                  height: 34,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFBF0EA),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.assignment_outlined, color: _primaryRust, size: 18),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8F5E9),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: const Text(
                                    '1 Active',
                                    style: TextStyle(
                                      color: Color(0xFF2E7D32),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            const Text(
                              'Requirements',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: _textDark,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            const Text(
                              'Manage bulk requirements',
                              style: TextStyle(
                                fontSize: 11,
                                color: _textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22.0),

              // Your Active Requirements section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Your Active Requirements',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: _textDark,
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2E7D32),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => onTabChange?.call(2),
                    child: const Text(
                      'View All ›',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _primaryRust,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),

              // Active requirement card
              Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF7F3),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFEFE8E2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF0E9),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF8D6E63), size: 18),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '500 Bamboo Baskets',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: _textDark,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2E7D32),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              const Text(
                                'Finding Artisans',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF2E7D32),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'Target delivery: 45 days • Corporate packaging needed',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: _textMuted,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: const [
                        Icon(Icons.people_outline, size: 14, color: _primaryRust),
                        SizedBox(width: 4.0),
                        Text(
                          '4 Artisans responded',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _primaryRust,
                          ),
                        ),
                        Text(
                          '  •  Last activity 20 mins ago',
                          style: TextStyle(
                            fontSize: 11,
                            color: _textMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () => onTabChange?.call(2),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryRust,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'View Requirement',
                              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(width: 6.0),
                            Icon(Icons.arrow_forward, size: 14),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22.0),

              // Explore Handmade Products horizontal section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Explore Handmade Products',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: _textDark,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        'Verified craft lines curated for retail and commercial buyers',
                        style: TextStyle(
                          fontSize: 11,
                          color: _textMuted,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: onOpenPopular ?? onOpenDiscover,
                    child: const Text(
                      'Browse Catalog ›',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: _primaryRust,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),

              SizedBox(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildProductCard(
                      image: 'https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=600&q=80',
                      craftTag: 'Bamboo Craft',
                      moqText: 'Min Bulk: 50 pcs',
                      title: 'Handwoven Bamboo Fruit Basket',
                      artisan: 'Ramesh Kumar',
                      location: 'Barpeta, Assam',
                      priceText: 'Tiered from ₹320/pc',
                      onTap: onOpenSearch,
                    ),
                    const SizedBox(width: 12.0),
                    _buildProductCard(
                      image: 'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=600&q=80',
                      craftTag: 'Ceramic & Pottery',
                      moqText: 'Min Bulk: 30 pcs',
                      title: 'Blue Pottery Hand-painted Vase',
                      artisan: 'Mohan Lal',
                      location: 'Jaipur, Rajasthan',
                      priceText: 'Tiered from ₹480/pc',
                      onTap: onOpenSearch,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22.0),

              // Artisans for You section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Artisans for You',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: _textDark,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        'Direct partnerships with high-capacity grassroots clusters',
                        style: TextStyle(
                          fontSize: 11,
                          color: _textMuted,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: onOpenFeatured ?? onOpenDiscover,
                    child: const Text(
                      'All Artisans ›',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: _primaryRust,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),

              _buildArtisanFeedCard(
                image: 'https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=600&q=80',
                name: 'Ramesh Kumar',
                badgeText: 'Master Craftsman',
                craft: 'Bamboo & Cane',
                rating: '4.9',
                location: 'Barpeta, Assam',
                capacity: '300 pcs/mo',
                onTap: onOpenFeatured ?? onOpenDiscover,
              ),
              const SizedBox(height: 12.0),

              _buildArtisanFeedCard(
                image: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=600&q=80',
                name: 'Mohan Lal',
                badgeText: 'GI Verified',
                craft: 'Ceramic & Pottery',
                rating: '4.8',
                location: 'Jaipur, Rajasthan',
                capacity: '250 pcs/mo',
                onTap: onOpenFeatured ?? onOpenDiscover,
              ),
              const SizedBox(height: 16.0),
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

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFE65100), Color(0xFF9C3C18)],
                ),
              ),
              child: const Center(
                child: Icon(Icons.hub, color: Colors.white, size: 18),
              ),
            ),
            const SizedBox(width: 8.0),
            const Text(
              'HunarSangam',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xFF8D3412),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(width: 6.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: const Color(0xFFF3ECE6),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'Bulk Buyer',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF8D3412),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.translate, size: 20, color: Color(0xFF5D4037)),
              onPressed: () {},
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(6.0),
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none, size: 22, color: Color(0xFF5D4037)),
                  onPressed: () {},
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(6.0),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: _primaryRust,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 6.0),
            const CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductCard({
    required String image,
    required String craftTag,
    required String moqText,
    required String title,
    required String artisan,
    required String location,
    required String priceText,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFEFE8E2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(13.0)),
                child: SizedBox(
                  width: double.infinity,
                  height: 120,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFFFAF0E9),
                      child: const Icon(Icons.inventory_2_outlined, color: _primaryRust),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    craftTag,
                    style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: _textDark),
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B5E20),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    moqText,
                    style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: _textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2.0),
                Text(
                  '👤 Artisan: $artisan',
                  style: const TextStyle(fontSize: 10.5, color: _textMuted),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '📍 $location',
                  style: const TextStyle(fontSize: 10.5, color: _textMuted),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      priceText,
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: _primaryRust,
                      ),
                    ),
                    InkWell(
                      onTap: onTap,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFEADFD6)),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: const Text(
                          'View Product',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _textDark),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtisanFeedCard({
    required String image,
    required String name,
    required String badgeText,
    required String craft,
    required String rating,
    required String location,
    required String capacity,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF7F3),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFEFE8E2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: SizedBox(
                      width: 54,
                      height: 54,
                      child: Image.network(
                        image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFFFAF0E9),
                          child: const Icon(Icons.person, color: _primaryRust),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E7D32),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: _textDark,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDECE5),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            badgeText,
                            style: const TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              color: _primaryRust,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      craft,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: _primaryRust,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 12, color: Color(0xFFF57C00)),
                        const SizedBox(width: 2.0),
                        Text(
                          '$rating • ',
                          style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: _textDark),
                        ),
                        Text(
                          '$location • ',
                          style: const TextStyle(fontSize: 10.5, color: _textMuted),
                        ),
                        Text(
                          'Capacity: $capacity',
                          style: const TextStyle(fontSize: 10.5, color: Color(0xFF2E7D32), fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF0E5DC),
                foregroundColor: _textDark,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('View Artisan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                  SizedBox(width: 4.0),
                  Icon(Icons.arrow_forward, size: 13),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
