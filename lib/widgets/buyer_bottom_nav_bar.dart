// lib/widgets/buyer_bottom_nav_bar.dart

import 'package:flutter/material.dart';

class BuyerBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BuyerBottomNavBar({
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
          top: BorderSide(color: Color(0xFFEFE8E2), width: 1.0),
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
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.explore_outlined,
                activeIcon: Icons.explore,
                label: 'Discover',
              ),
              _buildNavItem(
                index: 2,
                icon: Icons.assignment_outlined,
                activeIcon: Icons.assignment,
                label: 'Requirement',
              ),
              _buildNavItem(
                index: 3,
                icon: Icons.local_shipping_outlined,
                activeIcon: Icons.local_shipping,
                label: 'Order',
              ),
              _buildNavItem(
                index: 4,
                icon: Icons.person_outline,
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
    const primaryTerracotta = Color(0xFF9C3C18);
    const unselectedColor = Color(0xFF5A4A42);

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFFDECE5) : Colors.transparent,
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
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
              color: isSelected ? primaryTerracotta : unselectedColor,
            ),
          ),
        ],
      ),
    );
  }
}

