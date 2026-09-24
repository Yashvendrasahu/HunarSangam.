// lib/add_product/widgets/artisan_bottom_navigation.dart

import 'package:flutter/material.dart';
import '../../widgets/artisan_bottom_nav_bar.dart';

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
    return ArtisanBottomNavBar(
      currentIndex: currentIndex,
      onTap: (index) {
        onTabSelected?.call(index);
        onTap?.call(index);
      },
    );
  }
}
