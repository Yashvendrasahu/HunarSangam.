// lib/screens/buyer_profile_screen.dart
// 100% UI Match for 'bulk - profile section.png'

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';

class BuyerProfileScreen extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onLogOut;
  final Function(int)? onNavTap;
  final VoidCallback? onEditProfile;

  const BuyerProfileScreen({
    super.key,
    required this.onBack,
    required this.onLogOut,
    this.onNavTap,
    this.onEditProfile,
  });

  @override
  Widget build(BuildContext context) {
    const bgWarm = Color(0xFFFCF8F5);
    const textDark = Color(0xFF1E1714);
    const terracotta = Color(0xFF9E401A);
    const borderBeige = Color(0xFFEDE4DC);

    return Scaffold(
      backgroundColor: bgWarm,
      appBar: AppBar(
        backgroundColor: bgWarm,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textDark, size: 22),
          onPressed: onBack,
        ),
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: textDark,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          children: [
            // 1. Business Profile Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderBeige, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top terracotta accent header bar
                  Container(
                    height: 4,
                    decoration: const BoxDecoration(
                      color: terracotta,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF3E7DC),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(color: const Color(0xFFDFD1C4)),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'CC',
                                    style: TextStyle(
                                      color: terracotta,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: -4,
                                  right: -4,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF2E7D32),
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'CraftHouse Collective',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: textDark,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    'Rahul Sharma',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF70645E),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: const [
                                      Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF8D8078)),
                                      SizedBox(width: 4),
                                      Text(
                                        'Indore, Madhya Pradesh',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF70645E),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        // Badges Row
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            _buildPill(
                              label: 'Bulk Buyer',
                              bg: terracotta,
                              textColor: Colors.white,
                            ),
                            _buildPill(
                              icon: Icons.check_circle,
                              label: 'Verified Enterprise',
                              bg: const Color(0xFFE8F5E9),
                              textColor: const Color(0xFF2E7D32),
                              iconColor: const Color(0xFF2E7D32),
                            ),
                            _buildPill(
                              icon: Icons.storefront_outlined,
                              label: 'Retail Chain',
                              bg: const Color(0xFFF9F3EE),
                              textColor: const Color(0xFF6E5F58),
                              borderColor: const Color(0xFFDFD1C4),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(height: 1, color: Color(0xFFF0E7DF)),
                        const SizedBox(height: 14),
                        // Profile Status bar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Profile Status',
                              style: TextStyle(fontSize: 13, color: Color(0xFF70645E), fontWeight: FontWeight.w500),
                            ),
                            Text(
                              '80% Complete',
                              style: TextStyle(fontSize: 13, color: terracotta, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: 0.8,
                            minHeight: 6,
                            backgroundColor: const Color(0xFFEDE4DC),
                            valueColor: const AlwaysStoppedAnimation<Color>(terracotta),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Icon(Icons.info_outline, size: 14, color: Color(0xFF9E401A)),
                            SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'Add warehouse shipping pincodes to reach 100%',
                                style: TextStyle(fontSize: 12, color: Color(0xFF8D8078)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Edit Profile Button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: onEditProfile ?? () {},
                            icon: const Icon(Icons.edit_outlined, size: 16, color: textDark),
                            label: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: textDark,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFD4C5B9)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 2. Your Details Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Your Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: textDark,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Information from your business registration',
                      style: TextStyle(fontSize: 13, color: Color(0xFF8D8078)),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: onEditProfile ?? () {},
                  icon: const Icon(Icons.edit, size: 14, color: terracotta),
                  label: const Text(
                    'Edit',
                    style: TextStyle(color: terracotta, fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderBeige),
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    label: 'Full Name',
                    value: 'Rahul Sharma',
                    icon: Icons.person_outline,
                  ),
                  const Divider(height: 1, color: Color(0xFFF3ECE5), indent: 16, endIndent: 16),
                  _buildDetailRow(
                    label: 'Mobile Number',
                    value: '+91 98260 41230',
                    isVerified: true,
                    icon: Icons.phone_outlined,
                  ),
                  const Divider(height: 1, color: Color(0xFFF3ECE5), indent: 16, endIndent: 16),
                  _buildDetailRow(
                    label: 'Work Email',
                    value: 'rahul.sharma@crafthouse.in',
                    icon: Icons.email_outlined,
                  ),
                  const Divider(height: 1, color: Color(0xFFF3ECE5), indent: 16, endIndent: 16),
                  _buildDetailRow(
                    label: 'Business / Organization',
                    value: 'CraftHouse Collective',
                    icon: Icons.domain_outlined,
                  ),
                  const Divider(height: 1, color: Color(0xFFF3ECE5), indent: 16, endIndent: 16),
                  _buildDetailRow(
                    label: 'Business Type',
                    value: 'Home Décor & Lifestyle Retailer',
                    icon: Icons.category_outlined,
                  ),
                  const Divider(height: 1, color: Color(0xFFF3ECE5), indent: 16, endIndent: 16),
                  _buildDetailRow(
                    label: 'GSTIN',
                    value: '23AAACH7409R1ZV',
                    isVerified: true,
                    icon: Icons.badge_outlined,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 3. Sourcing Preferences Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Sourcing Preferences',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: textDark,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Your default wholesale criteria',
                      style: TextStyle(fontSize: 13, color: Color(0xFF8D8078)),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                      builder: (ctx) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Default Wholesale Criteria', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: textDark)),
                            const SizedBox(height: 12),
                            const Text('Select your preferred craft sectors for automatic RFQ matching:'),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 8,
                              children: const [
                                Chip(label: Text('Pottery & Ceramics'), backgroundColor: Color(0xFFFFF2EC)),
                                Chip(label: Text('Handloom & Silk'), backgroundColor: Color(0xFFFFF2EC)),
                                Chip(label: Text('Terracotta'), backgroundColor: Color(0xFFFFF2EC)),
                                Chip(label: Text('Bamboo & Cane'), backgroundColor: Color(0xFFFFF2EC)),
                                Chip(label: Text('Brass & Dhokra'), backgroundColor: Color(0xFFFFF2EC)),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Sourcing preferences updated successfully!')),
                                  );
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: terracotta, foregroundColor: Colors.white),
                                child: const Text('Save Preferences'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit, size: 14, color: terracotta),
                  label: const Text(
                    'Edit',
                    style: TextStyle(color: terracotta, fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderBeige),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Preferred Crafts',
                    style: TextStyle(fontSize: 13, color: Color(0xFF70645E), fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildCraftChip(Icons.eco_outlined, 'Bamboo Craft'),
                      _buildCraftChip(Icons.construction_outlined, 'Pottery'),
                      _buildCraftChip(Icons.texture_outlined, 'Handloom'),
                      _buildCraftChip(Icons.brush_outlined, 'Woodcraft'),
                      _buildCraftChip(Icons.chair_outlined, 'Home Décor'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Typical Order Size
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF6F1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFEADFD6)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Typical Order Size',
                          style: TextStyle(fontSize: 12, color: Color(0xFF8D8078)),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: terracotta,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            '250–500 pieces',
                            style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Per SKU bulk dispatch',
                          style: TextStyle(fontSize: 12, color: Color(0xFF8D8078)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Sourcing Preference
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFBF6F1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFEADFD6)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Sourcing Preference',
                          style: TextStyle(fontSize: 12, color: Color(0xFF8D8078)),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Bulk / Large Quantity',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: textDark),
                        ),
                        Text(
                          'OEM & Direct Cluster',
                          style: TextStyle(fontSize: 12, color: Color(0xFF8D8078)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Priority Artisan Clusters',
                    style: TextStyle(fontSize: 13, color: Color(0xFF70645E), fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildClusterChip('↗ Assam & North East'),
                      _buildClusterChip('☼ Kutch & Gujarat'),
                      _buildClusterChip('🏛 Rajasthan'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: Color(0xFFF0E7DF)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Customization & White-label',
                              style: TextStyle(fontSize: 12, color: Color(0xFF8D8078)),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Custom designs & Private label',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: textDark),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5EBE1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.auto_fix_high, size: 18, color: terracotta),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 4. Quick Settings & Support
            const Text(
              'Quick Settings & Support',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: textDark,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderBeige),
              ),
              child: Column(
                children: [
                  _buildSettingTile(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    subtitle: 'Order, requirement and message updates',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Push notifications & SMS alerts are enabled for your account.')),
                      );
                    },
                  ),
                  const Divider(height: 1, color: Color(0xFFF3ECE5), indent: 16, endIndent: 16),
                  _buildSettingTile(
                    icon: Icons.translate,
                    title: 'Language',
                    subtitle: 'English • Hindi voice translation enabled',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('App Language: English (Default). Auto voice translation active.')),
                      );
                    },
                  ),
                  const Divider(height: 1, color: Color(0xFFF3ECE5), indent: 16, endIndent: 16),
                  _buildSettingTile(
                    icon: Icons.help_outline,
                    title: 'Help & Support',
                    subtitle: 'Direct cluster liaison desk & FAQ',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          title: const Text('HunarSangam Trade Desk', style: TextStyle(fontWeight: FontWeight.w800)),
                          content: const Text('24x7 Escrow & Dispute Resolution Support:\nEmail: trade@hunarsangam.gov.in\nHelpline: 1800-HUNAR-CARE'),
                          actions: [
                            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 5. Log Out Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onLogOut,
                icon: const Icon(Icons.logout, size: 18, color: Color(0xFFD32F2F)),
                label: const Text(
                  'Log Out',
                  style: TextStyle(
                    color: Color(0xFFD32F2F),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFFFCDD2)),
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),

            const SizedBox(height: 16),

            const Center(
              child: Text(
                'HunarSangam Bulk Buyer App • v2.4.1 (Enterprise)',
                style: TextStyle(fontSize: 12, color: Color(0xFFA89E97)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BuyerBottomNavBar(
        currentIndex: 4,
        onTap: (index) {
          if (onNavTap != null) {
            onNavTap!(index);
          }
        },
      ),
    );
  }

  static Widget _buildPill({
    IconData? icon,
    required String label,
    required Color bg,
    required Color textColor,
    Color? borderColor,
    Color? iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: borderColor != null ? Border.all(color: borderColor) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: iconColor ?? textColor),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildDetailRow({
    required String label,
    required String value,
    required IconData icon,
    bool isVerified = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF8D8078)),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        value,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E1714),
                        ),
                      ),
                    ),
                    if (isVerified) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.check_circle, size: 11, color: Color(0xFF2E7D32)),
                            SizedBox(width: 3),
                            Text(
                              'Verified',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Icon(icon, size: 20, color: const Color(0xFF8D8078)),
        ],
      ),
    );
  }

  static Widget _buildCraftChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF2EB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5D5C6)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF9E401A)),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF9E401A),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildClusterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F4EE),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE4D7CC)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF635650),
        ),
      ),
    );
  }

  static Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFFF5EBE1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, size: 20, color: const Color(0xFF9E401A)),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Color(0xFF1E1714),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: Color(0xFF8D8078)),
      ),
      trailing: const Icon(Icons.chevron_right, color: Color(0xFFA89E97), size: 20),
    );
  }
}
