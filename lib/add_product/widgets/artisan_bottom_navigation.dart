// lib/add_product/widgets/artisan_bottom_navigation.dart

import 'package:flutter/material.dart';

class ArtisanBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTabSelected;
  final ValueChanged<int>? onTap;
  final VoidCallback? onBack;

  const ArtisanBottomNavigation({
    super.key,
    this.currentIndex = 0,
    this.onTabSelected,
    this.onTap,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFEADFD6), width: 1.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home'),
            _buildNavItem(1, Icons.inventory_2_outlined, Icons.inventory_2, 'Products'),
            _buildNavItem(2, Icons.receipt_long_outlined, Icons.receipt_long, 'Orders'),
            _buildNavItem(3, Icons.groups_outlined, Icons.groups, 'Guild'),
            _buildNavItem(4, Icons.chat_bubble_outline, Icons.chat_bubble, 'Messages'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = currentIndex == index;
    const activeColor = Color(0xFFA84318);
    const inactiveColor = Color(0xFF8D6E63);

    return InkWell(
      onTap: () {
        onTabSelected?.call(index);
        onTap?.call(index);
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? activeColor : inactiveColor,
              size: 22,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
