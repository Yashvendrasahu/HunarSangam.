// lib/add_product/widgets/distribution_channels_card.dart

import 'package:flutter/material.dart';

/// Matches 'Distribution Channels Activated' in p9 & p10
class DistributionChannelsCard extends StatelessWidget {
  const DistributionChannelsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Distribution Channels Activated',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF221C19),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4EDDA),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Text(
                  '3 Active',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E6B24),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // Channel 1: HunarSangam Marketplace
          _buildChannelItem(
            icon: Icons.storefront_outlined,
            iconBg: const Color(0xFFFFE8DC),
            iconColor: const Color(0xFFBA4B20),
            title: 'HunarSangam Marketplace',
            subtitle: 'Live • Instant Quotations enabled',
          ),

          const SizedBox(height: 8.0),

          // Channel 2: ONDC Handicraft Registry
          _buildChannelItem(
            icon: Icons.hub_outlined,
            iconBg: const Color(0xFFD4EDDA),
            iconColor: const Color(0xFF1E6B24),
            title: 'ONDC Handicraft Registry',
            subtitle: 'Synced • Pan-India open network',
          ),

          const SizedBox(height: 8.0),

          // Channel 3: Direct WhatsApp Catalog
          _buildChannelItem(
            icon: Icons.share_outlined,
            iconBg: const Color(0xFFF6EAE2),
            iconColor: const Color(0xFF6B584E),
            title: 'Direct WhatsApp Catalog',
            subtitle: 'Link ready to share with buyers',
          ),
        ],
      ),
    );
  }

  Widget _buildChannelItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF2EC),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFECDACF)),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF221C19),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10.5,
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.check_circle,
            color: Color(0xFF2E7D32),
            size: 20,
          ),
        ],
      ),
    );
  }
}
