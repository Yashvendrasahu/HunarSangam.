// lib/widgets/artisan_bottom_nav_bar.dart

import 'package:flutter/material.dart';

class ArtisanBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const ArtisanBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFDFBF9),
        border: Border(
          top: BorderSide(color: Color(0xFFEADFD6), width: 1.0),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.storefront_outlined,
                activeIcon: Icons.storefront_rounded,
                label: 'Home',
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.palette_outlined,
                activeIcon: Icons.palette,
                label: 'Products',
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.receipt_long_outlined,
                activeIcon: Icons.receipt_long,
                label: 'Orders',
              ),
              _buildNavItem(
                index: 3,
                icon: Icons.groups_outlined,
                activeIcon: Icons.groups,
                label: 'Collaborate',
              ),
              _buildNavItem(
                index: 4,
                icon: Icons.person_outline_rounded,
                activeIcon: Icons.person,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final isSelected = currentIndex == index;
    const primaryTerracotta = Color(0xFF8C3A16);
    const unselectedColor = Color(0xFF7A685F);

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFF8E5D8) : Colors.transparent,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Icon(
              isSelected ? activeIcon : icon,
              size: 22,
              color: isSelected ? primaryTerracotta : unselectedColor,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
              color: isSelected ? primaryTerracotta : unselectedColor,
            ),
          ),
        ],
      ),
    );
  }
}
