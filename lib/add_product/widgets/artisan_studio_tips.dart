// lib/add_product/widgets/artisan_studio_tips.dart

import 'package:flutter/material.dart';

class ArtisanStudioTipsCard extends StatelessWidget {
  const ArtisanStudioTipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFBF4EE),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'lightbulb',
                style: TextStyle(
                  fontFamily: 'MaterialIcons',
                  fontSize: 16.0,
                  color: Color(0xFFB85324),
                ),
              ),
              SizedBox(width: 6.0),
              Text(
                'ARTISAN STUDIO TIPS',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF7C3F24),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Divider(height: 1.0, color: Color(0xFFEADFD6)),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: _buildTipItem(
                  icon: Icons.wb_sunny_outlined,
                  title: 'Soft Sun',
                  subtitle: 'No harsh flash\nglare',
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: _buildTipItem(
                  icon: Icons.image_outlined,
                  title: 'Clean Base',
                  subtitle: 'Bare wood or\ncloth',
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: _buildTipItem(
                  icon: Icons.monetization_on_outlined,
                  title: '₹10 Coin',
                  subtitle: 'Shows true\nheight',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF8C3A16), size: 20.0),
          const SizedBox(height: 6.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2D2421),
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 9.5,
              color: Color(0xFF7A685F),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
