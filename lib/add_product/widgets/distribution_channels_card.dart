// lib/add_product/widgets/distribution_channels_card.dart

import 'package:flutter/material.dart';

class DistributionChannelsCard extends StatelessWidget {
  final bool ondcEnabled;
  final bool exportEnabled;
  final bool bulkEnabled;
  final ValueChanged<bool>? onOndcChanged;
  final ValueChanged<bool>? onExportChanged;
  final ValueChanged<bool>? onBulkChanged;

  const DistributionChannelsCard({
    super.key,
    this.ondcEnabled = true,
    this.exportEnabled = true,
    this.bulkEnabled = true,
    this.onOndcChanged,
    this.onExportChanged,
    this.onBulkChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF6F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.hub_outlined, color: Color(0xFFA84318), size: 20),
              SizedBox(width: 8),
              Text(
                'Distribution & Discovery Channels',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF221C19),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildChannelTile(
            title: 'ONDC Network Sync',
            subtitle: 'Sync instantly to Government open e-commerce network',
            value: ondcEnabled,
            onChanged: onOndcChanged,
          ),
          const Divider(height: 16, color: Color(0xFFEADBCE)),
          _buildChannelTile(
            title: 'Export / Global Bulk Buyers',
            subtitle: 'Make visible to international institutional sourcing',
            value: exportEnabled,
            onChanged: onExportChanged,
          ),
          const Divider(height: 16, color: Color(0xFFEADBCE)),
          _buildChannelTile(
            title: 'Verified Domestic B2B Sourcing',
            subtitle: 'Direct matching with retail brands & gifting teams',
            value: bulkEnabled,
            onChanged: onBulkChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildChannelTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2E231D),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF7A685F),
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          activeColor: const Color(0xFFA84318),
          onChanged: onChanged ?? (_) {},
        ),
      ],
    );
  }
}
