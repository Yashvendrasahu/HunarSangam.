// lib/widgets/brand_logo_card.dart

import 'package:flutter/material.dart';

class BrandLogoCard extends StatelessWidget {
  final double size;
  const BrandLogoCard({super.key, this.size = 120.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFFA84318),
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA84318).withOpacity(0.28),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        'assets/images/logo.png',
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Center(
          child: Icon(
            Icons.handyman_rounded,
            size: size * 0.52,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class HunarSangamLogoBadge extends StatelessWidget {
  final double size;
  final bool showText;

  const HunarSangamLogoBadge({
    super.key,
    this.size = 36.0,
    this.showText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: const Color(0xFFA84318),
            borderRadius: BorderRadius.circular(size * 0.28),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            'assets/images/logo.png',
            width: size,
            height: size,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Center(
              child: Icon(
                Icons.handyman_rounded,
                size: size * 0.55,
                color: Colors.white,
              ),
            ),
          ),
        ),
        if (showText) ...[
          const SizedBox(width: 8),
          const Text(
            'HunarSangam',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1F1612),
              letterSpacing: -0.2,
            ),
          ),
        ],
      ],
    );
  }
}
