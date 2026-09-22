// lib/screens/buyer_artisan_profile_screen.dart

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';

class BuyerArtisanProfileScreen extends StatelessWidget {
  final VoidCallback onBack;
  final Function(int)? onTabChange;

  const BuyerArtisanProfileScreen({
    super.key,
    required this.onBack,
    this.onTabChange,
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
        title: const Text('Artisan Profile & Verification', style: TextStyle(color: Color(0xFF2D2421), fontSize: 16, fontWeight: FontWeight.w800)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 36,
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Ramu Kumar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF2D2421))),
                      SizedBox(height: 2),
                      Text('Master Cane & Bamboo Artisan', style: TextStyle(fontSize: 13, color: Color(0xFFA84318), fontWeight: FontWeight.w700)),
                      SizedBox(height: 4),
                      Text('Barabanki Cluster, Uttar Pradesh', style: TextStyle(fontSize: 12, color: Color(0xFF7A685F))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: const [
                  Icon(Icons.verified, color: Color(0xFF2E7D32), size: 20),
                  SizedBox(width: 8),
                  Text('GI Tag Registered • ONDC Certified Maker', style: TextStyle(fontSize: 12, color: Color(0xFF2E7D32), fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Product Portfolio (ONDC Ready)', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF2D2421))),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEADFD6)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=400&q=80'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Handcrafted Woven Fruit Basket', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800)),
                        SizedBox(height: 2),
                        Text('₹280 / piece • MOQ: 20 pcs', style: TextStyle(fontSize: 12, color: Color(0xFFA84318), fontWeight: FontWeight.w700)),
                        SizedBox(height: 2),
                        Text('Lead time: 14 days for 100 pcs', style: TextStyle(fontSize: 11, color: Color(0xFF7A685F))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BuyerBottomNavBar(
        currentIndex: 1,
        onTap: (idx) => onTabChange?.call(idx),
      ),
    );
  }
}
