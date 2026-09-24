// lib/screens/buyer_home_screen.dart

import 'package:flutter/material.dart';
import '../models/buyer_onboarding_model.dart';
import '../widgets/buyer_bottom_nav_bar.dart';
import '../widgets/api_config_dialog.dart';
import '../widgets/brand_logo_card.dart';
import '../utils/craft_assets.dart';
import '../services/supabase_config.dart';

/// Screen: Bulk Buyer Home Dashboard
/// Fully interactive: all icons, chips, buttons, cards and badges are clickable.
class BuyerHomeScreen extends StatefulWidget {
  final BuyerOnboardingModel? model;
  final BuyerOnboardingModel? buyerModel;
  final VoidCallback? onLogout;
  final VoidCallback onOpenSearch;
  final VoidCallback onOpenDiscover;
  final VoidCallback onPostRequirement;
  final VoidCallback? onOpenFeatured;
  final VoidCallback? onOpenPopular;
  final Function(String query)? onSearchByQuery;
  final Function(int)? onTabChange;

  const BuyerHomeScreen({
    super.key,
    this.model,
    this.buyerModel,
    this.onLogout,
    required this.onOpenSearch,
    required this.onOpenDiscover,
    required this.onPostRequirement,
    this.onOpenFeatured,
    this.onOpenPopular,
    this.onSearchByQuery,
    this.onTabChange,
  });

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFDFBF9);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);

  String _selectedCategory = 'All';
  String _selectedLanguage = 'English';
  final Set<String> _bookmarkedItems = {};

  final List<Map<String, dynamic>> _mockNotifications = [
    {
      'title': 'New Artisan Quotation Received',
      'body': 'Ramu Prajapati (Khurja Cluster) responded to your 500 Bamboo Baskets requirement.',
      'time': '10 mins ago',
      'isUnread': true,
      'icon': Icons.request_quote_rounded,
      'color': Color(0xFF2E7D32),
    },
    {
      'title': 'Escrow Milestone Released',
      'body': 'Advance payment for Order #HS-8821 has been safely locked in Escrow.',
      'time': '2 hours ago',
      'isUnread': true,
      'icon': Icons.lock_outline_rounded,
      'color': Color(0xFF9C3C18),
    },
    {
      'title': 'New GI Craft Cluster Added',
      'body': 'Explore 45 verified brass artisans from Bastar Metal Craft cluster.',
      'time': '1 day ago',
      'isUnread': false,
      'icon': Icons.verified_rounded,
      'color': Color(0xFF1976D2),
    },
  ];

  void _showNotificationSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF2EC),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: const Icon(Icons.notifications_active_rounded, color: _primaryRust, size: 20),
                            ),
                            const SizedBox(width: 10.0),
                            const Text(
                              'Notifications (सूचनाएं)',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w800,
                                color: _textDark,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            setSheetState(() {
                              for (var n in _mockNotifications) {
                                n['isUnread'] = false;
                              }
                            });
                            setState(() {});
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('All notifications marked as read')),
                            );
                          },
                          child: const Text('Mark all read', style: TextStyle(color: _primaryRust, fontSize: 12.0)),
                        ),
                      ],
                    ),
                    const Divider(height: 20.0),
                    Flexible(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: _mockNotifications.length,
                        separatorBuilder: (_, __) => const Divider(height: 12.0),
                        itemBuilder: (context, i) {
                          final item = _mockNotifications[i];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: (item['color'] as Color).withOpacity(0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 20),
                            ),
                            title: Text(
                              item['title'] as String,
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: item['isUnread'] == true ? FontWeight.w800 : FontWeight.w600,
                                color: _textDark,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 2.0),
                                Text(
                                  item['body'] as String,
                                  style: const TextStyle(fontSize: 12.0, color: _textMuted),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  item['time'] as String,
                                  style: const TextStyle(fontSize: 10.5, color: Color(0xFF9E8E85)),
                                ),
                              ],
                            ),
                            trailing: item['isUnread'] == true
                                ? Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: _primaryRust,
                                      shape: BoxShape.circle,
                                    ),
                                  )
                                : null,
                            onTap: () {
                              Navigator.pop(ctx);
                              widget.onTabChange?.call(2);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showLanguageSelector() {
    final languages = [
      'English',
      'हिंदी (Hindi)',
      'ગુજરાતી (Gujarati)',
      'বাংলা (Bengali)',
      'मराठी (Marathi)',
      'தமிழ் (Tamil)',
      'తెలుగు (Telugu)',
      'ಕನ್ನಡ (Kannada)',
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Language / भाषा चुनें',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800, color: _textDark),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: _textMuted),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: languages.length,
                    itemBuilder: (context, i) {
                      final lang = languages[i];
                      final isSelected = lang.startsWith(_selectedLanguage);
                      return ListTile(
                        title: Text(
                          lang,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                            color: isSelected ? _primaryRust : _textDark,
                          ),
                        ),
                        trailing: isSelected ? const Icon(Icons.check_circle_rounded, color: _primaryRust) : null,
                        onTap: () {
                          setState(() {
                            _selectedLanguage = lang.split(' ').first;
                          });
                          Navigator.pop(ctx);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Language switched to $lang'),
                              backgroundColor: _primaryRust,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showProfileMenuSheet(String buyerName, String businessName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
                      ),
                    ),
                    const SizedBox(width: 14.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            buyerName,
                            style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800, color: _textDark),
                          ),
                          Text(
                            businessName,
                            style: const TextStyle(fontSize: 13.0, color: _primaryRust, fontWeight: FontWeight.w700),
                          ),
                          const Text(
                            'Verified Bulk Enterprise Account',
                            style: TextStyle(fontSize: 11.0, color: _textMuted),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 28.0),
                ListTile(
                  leading: const Icon(Icons.person_outline, color: _primaryRust),
                  title: const Text('View Full Buyer Profile', style: TextStyle(fontWeight: FontWeight.w700)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(ctx);
                    widget.onTabChange?.call(4);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.assignment_outlined, color: _primaryRust),
                  title: const Text('My Purchase Orders & Escrows', style: TextStyle(fontWeight: FontWeight.w700)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(ctx);
                    widget.onTabChange?.call(1);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.tune_rounded, color: _primaryRust),
                  title: const Text('Cloud & AI API Config', style: TextStyle(fontWeight: FontWeight.w700)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(ctx);
                    ApiConfigDialog.show(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.support_agent_rounded, color: Color(0xFF2E7D32)),
                  title: const Text('HunarSangam Trade Support', style: TextStyle(fontWeight: FontWeight.w700)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Connecting to 24x7 Artisan Trade Concierge...')),
                    );
                  },
                ),
                const Divider(height: 20.0),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Sign Out / लॉग आउट', style: TextStyle(fontWeight: FontWeight.w700, color: Colors.red)),
                  onTap: () {
                    Navigator.pop(ctx);
                    widget.onLogout?.call();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showProductDetailModal(
    BuildContext context, {
    required String title,
    required String craftTag,
    required String moqText,
    required String priceText,
    required String artisan,
    required String location,
    required String image,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          expand: false,
          builder: (_, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      image,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF2EC),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          craftTag,
                          style: const TextStyle(color: _primaryRust, fontWeight: FontWeight.w800, fontSize: 12.0),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          moqText,
                          style: const TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.w700, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w900, color: _textDark),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    priceText,
                    style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900, color: _primaryRust),
                  ),
                  const SizedBox(height: 14.0),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF5F0),
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: const Color(0xFFEADFD6)),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(CraftAssets.artisanRamuKumar),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                artisan,
                                style: const TextStyle(fontWeight: FontWeight.w800, color: _textDark, fontSize: 14.0),
                              ),
                              Text(
                                '📍 $location • Master Certified Artisan',
                                style: const TextStyle(color: _textMuted, fontSize: 11.5),
                              ),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                            widget.onTabChange?.call(3); // Chat
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: _primaryRust),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          ),
                          child: const Text('Chat', style: TextStyle(color: _primaryRust, fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Product Specifications',
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w800, color: _textDark),
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    '• Hand-crafted using 100% natural, eco-friendly GI cluster raw materials.\n'
                    '• Quality inspected with lab certification & export-grade packaging.\n'
                    '• Customizable laser branding, dimensions & custom color glazes for bulk orders.\n'
                    '• Secure Escrow milestone payments (Advance, Production, Quality Pass, Dispatch).',
                    style: TextStyle(fontSize: 12.5, color: _textMuted, height: 1.5),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Sample request initiated for $title. Artisan will dispatch within 48h.'),
                                backgroundColor: const Color(0xFF2E7D32),
                              ),
                            );
                          },
                          icon: const Icon(Icons.science_outlined, color: _primaryRust),
                          label: const Text('Request Sample', style: TextStyle(color: _primaryRust, fontWeight: FontWeight.w800)),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            side: const BorderSide(color: _primaryRust),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(ctx);
                            widget.onPostRequirement();
                          },
                          icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
                          label: const Text('Place RFQ', style: TextStyle(fontWeight: FontWeight.w800)),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            backgroundColor: _primaryRust,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showArtisanProfileModal(
    BuildContext context, {
    required String name,
    required String craft,
    required String location,
    required String rating,
    required String capacity,
    required String avatar,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          maxChildSize: 0.95,
          minChildSize: 0.5,
          expand: false,
          builder: (_, controller) {
            return SingleChildScrollView(
              controller: controller,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 34,
                        backgroundImage: NetworkImage(avatar),
                      ),
                      const SizedBox(width: 14.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900, color: _textDark),
                                ),
                                const SizedBox(width: 4.0),
                                const Icon(Icons.verified, color: Color(0xFF2E7D32), size: 18.0),
                              ],
                            ),
                            Text(
                              craft,
                              style: const TextStyle(fontSize: 13.5, color: _primaryRust, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              '📍 $location • Rating: ★ $rating',
                              style: const TextStyle(fontSize: 12.0, color: _textMuted),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18.0),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDF7F3),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: const Color(0xFFEADFD6)),
                          ),
                          child: Column(
                            children: [
                              const Text('Monthly Capacity', style: TextStyle(fontSize: 11.0, color: _textMuted)),
                              const SizedBox(height: 4.0),
                              Text(capacity, style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800, color: _textDark)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F8F0),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: const Color(0xFFCCE6CC)),
                          ),
                          child: const Column(
                            children: [
                              Text('Reliability Score', style: TextStyle(fontSize: 11.0, color: _textMuted)),
                              SizedBox(height: 4.0),
                              Text('98.4% (Tier-1)', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800, color: Color(0xFF2E7D32))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Text('About the Master Artisan', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w800, color: _textDark)),
                  const SizedBox(height: 6.0),
                  Text(
                    '$name is a celebrated 3rd-generation handicraft artisan leading a cooperative cluster in $location. '
                    'Specializing in bulk institutional supply, export compliant standards, and authentic handmade craftsmanship.',
                    style: const TextStyle(fontSize: 12.5, color: _textMuted, height: 1.45),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(ctx);
                            widget.onTabChange?.call(3); // Chat tab
                          },
                          icon: const Icon(Icons.chat_outlined, color: _primaryRust),
                          label: const Text('Message Artisan', style: TextStyle(color: _primaryRust, fontWeight: FontWeight.w800)),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            side: const BorderSide(color: _primaryRust),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(ctx);
                            widget.onPostRequirement();
                          },
                          icon: const Icon(Icons.send_rounded, color: Colors.white),
                          label: const Text('Send RFQ Direct', style: TextStyle(fontWeight: FontWeight.w800)),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14.0),
                            backgroundColor: _primaryRust,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showClusterInfoModal(String clusterName, String state, String specialty) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Row(
          children: [
            const Icon(Icons.location_on, color: _primaryRust),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                '$clusterName GI Cluster',
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800, color: _textDark),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('📍 State/Region: $state', style: const TextStyle(fontWeight: FontWeight.w700, color: _textDark)),
            const SizedBox(height: 6.0),
            Text('🏺 Signature Specialty: $specialty', style: const TextStyle(fontWeight: FontWeight.w600, color: _primaryRust)),
            const SizedBox(height: 12.0),
            const Text(
              'All artisans from this cluster are physically verified by HunarSangam ground field officers with GI geo-tagging.',
              style: TextStyle(fontSize: 12.0, color: _textMuted),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close', style: TextStyle(color: _textMuted)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              widget.onSearchByQuery?.call(clusterName);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryRust,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            child: Text('Search $clusterName Artisans'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activeModel = widget.model ?? widget.buyerModel ?? const BuyerOnboardingModel();
    final buyerName = activeModel.yourName.isNotEmpty ? activeModel.yourName.split(' ').first : 'Vikram';
    final businessName = activeModel.businessName.isNotEmpty ? activeModel.businessName : 'FabCraft Living';

    return Scaffold(
      backgroundColor: _bgCanvas,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar with Brand, Bulk Buyer tag, Language, Notification, Avatar
              _buildTopBar(context, buyerName, businessName),
              const SizedBox(height: 18.0),

              // Greeting & Business account badge
              Text(
                'Good morning, $buyerName 👋',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: _textDark,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 3.0),
              const Text(
                'Find the right handmade products for your business.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: _textMuted,
                ),
              ),
              const SizedBox(height: 12.0),

              // Account badge (clickable)
              InkWell(
                onTap: () => _showProfileMenuSheet(buyerName, businessName),
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3ECE6),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: const Color(0xFFE5D7CE)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.storefront_outlined, size: 16, color: Color(0xFF2E7D32)),
                      const SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            businessName,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: _textDark,
                            ),
                          ),
                          const Text(
                            'Bulk Buyer Account (Tap to manage)',
                            style: TextStyle(
                              fontSize: 10,
                              color: _textMuted,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 6.0),
                      const Icon(Icons.keyboard_arrow_down, size: 16, color: _textMuted),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),

              // Search Bar with Mic button (Both clickable)
              InkWell(
                onTap: widget.onOpenSearch,
                borderRadius: BorderRadius.circular(14.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(color: const Color(0xFFE8DDD5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Color(0xFF8D6E63), size: 20),
                      const SizedBox(width: 10.0),
                      const Expanded(
                        child: Text(
                          'What are you looking for?',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF8D6E63),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: widget.onPostRequirement,
                        borderRadius: BorderRadius.circular(10.0),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3ECE6),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Icon(Icons.mic, color: Color(0xFF8D6E63), size: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14.0),

              // Category horizontal filter chips (All clickable)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryFilterChip('All', Icons.apps_rounded),
                    _buildCategoryFilterChip('Bamboo & Cane', Icons.eco_outlined),
                    _buildCategoryFilterChip('Blue Pottery', Icons.palette_outlined),
                    _buildCategoryFilterChip('Terracotta Clay', Icons.cookie_outlined),
                    _buildCategoryFilterChip('Handloom Textiles', Icons.style_outlined),
                    _buildCategoryFilterChip('Brass & Metal', Icons.diamond_outlined),
                    _buildCategoryFilterChip('Wooden Crafts', Icons.forest_outlined),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Need products in bulk Banner (Post a requirement)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB04A23), Color(0xFF8D3412)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8D3412).withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: const Text(
                        'BULK BUYER CONCIERGE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    const Text(
                      'Need products in bulk?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'Tell us what you need and connect with suitable artisans directly.',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 14.0),
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: widget.onPostRequirement,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: _primaryRust,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.add_circle_outline, size: 16, color: _primaryRust),
                            SizedBox(width: 6.0),
                            Text(
                              'Post a Requirement',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w800,
                                color: _primaryRust,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Dual Quick Action Cards: Discover & Requirements
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: widget.onOpenDiscover,
                      borderRadius: BorderRadius.circular(14.0),
                      child: Container(
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(color: const Color(0xFFEFE8E2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 34,
                                  height: 34,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFBF0EA),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.explore_outlined, color: _primaryRust, size: 18),
                                ),
                                const Icon(Icons.arrow_forward, size: 16, color: Color(0xFFB0A298)),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            const Text(
                              'Discover',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: _textDark,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            const Text(
                              'Find handmade products',
                              style: TextStyle(
                                fontSize: 11,
                                color: _textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  Expanded(
                    child: InkWell(
                      onTap: () => widget.onTabChange?.call(2),
                      borderRadius: BorderRadius.circular(14.0),
                      child: Container(
                        padding: const EdgeInsets.all(14.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.0),
                          border: Border.all(color: const Color(0xFFEFE8E2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 34,
                                  height: 34,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFBF0EA),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.assignment_outlined, color: _primaryRust, size: 18),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8F5E9),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: const Text(
                                    '1 Active',
                                    style: TextStyle(
                                      color: Color(0xFF2E7D32),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12.0),
                            const Text(
                              'Requirements',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: _textDark,
                              ),
                            ),
                            const SizedBox(height: 2.0),
                            const Text(
                              'Manage bulk requirements',
                              style: TextStyle(
                                fontSize: 11,
                                color: _textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22.0),

              // Your Active Requirements section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Your Active Requirements',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: _textDark,
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2E7D32),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => widget.onTabChange?.call(2),
                    child: const Text(
                      'View All ›',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _primaryRust,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),

              // Active requirement card
              InkWell(
                onTap: () => widget.onTabChange?.call(2),
                borderRadius: BorderRadius.circular(14.0),
                child: Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDF7F3),
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(color: const Color(0xFFEFE8E2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAF0E9),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Icon(Icons.inventory_2_outlined, color: Color(0xFF8D6E63), size: 18),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '500 Bamboo Baskets',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: _textDark,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 5,
                                  height: 5,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF2E7D32),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                const Text(
                                  'Finding Artisans',
                                  style: TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF2E7D32),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        'Target delivery: 45 days • Corporate packaging needed',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: _textMuted,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        children: const [
                          Icon(Icons.people_outline, size: 14, color: _primaryRust),
                          SizedBox(width: 4.0),
                          Text(
                            '4 Artisans responded',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: _primaryRust,
                            ),
                          ),
                          Text(
                            '  •  Last activity 20 mins ago',
                            style: TextStyle(
                              fontSize: 11,
                              color: _textMuted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () => widget.onTabChange?.call(2),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryRust,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'View Requirement Details',
                                style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
                              ),
                              SizedBox(width: 6.0),
                              Icon(Icons.arrow_forward, size: 14),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22.0),

              // Explore Handmade Products horizontal section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Explore Handmade Products',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: _textDark,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        'Verified craft lines curated for retail and commercial buyers',
                        style: TextStyle(
                          fontSize: 11,
                          color: _textMuted,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: widget.onOpenPopular ?? widget.onOpenDiscover,
                    child: const Text(
                      'Browse Catalog ›',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: _primaryRust,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),

              // Product Cards Carousel (All clickable with dialogs & quotes)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildProductCard(
                      image: CraftAssets.bambooBasket,
                      craftTag: 'BAMBOO & CANE',
                      moqText: 'MOQ: 50 pcs',
                      title: 'Hand-woven Bamboo Fruit Basket',
                      artisan: 'Ramu Kumar',
                      location: 'Assam Cluster',
                      priceText: '₹220 / pc',
                      onTap: () => _showProductDetailModal(
                        context,
                        title: 'Hand-woven Bamboo Fruit Basket',
                        craftTag: 'BAMBOO & CANE',
                        moqText: 'MOQ: 50 pcs',
                        priceText: '₹220 / pc',
                        artisan: 'Ramu Kumar',
                        location: 'Assam Cluster',
                        image: CraftAssets.bambooBasket,
                      ),
                    ),
                    const SizedBox(width: 14.0),
                    _buildProductCard(
                      image: CraftAssets.bluePotteryVase,
                      craftTag: 'BLUE POTTERY',
                      moqText: 'MOQ: 25 pcs',
                      title: 'Hand-painted Ceramic Glaze Vase',
                      artisan: 'Sunita Devi',
                      location: 'Jaipur Cluster',
                      priceText: '₹450 / pc',
                      onTap: () => _showProductDetailModal(
                        context,
                        title: 'Hand-painted Ceramic Glaze Vase',
                        craftTag: 'BLUE POTTERY',
                        moqText: 'MOQ: 25 pcs',
                        priceText: '₹450 / pc',
                        artisan: 'Sunita Devi',
                        location: 'Jaipur Cluster',
                        image: CraftAssets.bluePotteryVase,
                      ),
                    ),
                    const SizedBox(width: 14.0),
                    _buildProductCard(
                      image: CraftAssets.terracottaPot,
                      craftTag: 'TERRACOTTA',
                      moqText: 'MOQ: 100 pcs',
                      title: 'Natural Clay Table Planter',
                      artisan: 'Rajesh Prajapati',
                      location: 'Gorakhpur GI Cluster',
                      priceText: '₹140 / pc',
                      onTap: () => _showProductDetailModal(
                        context,
                        title: 'Natural Clay Table Planter',
                        craftTag: 'TERRACOTTA',
                        moqText: 'MOQ: 100 pcs',
                        priceText: '₹140 / pc',
                        artisan: 'Rajesh Prajapati',
                        location: 'Gorakhpur GI Cluster',
                        image: CraftAssets.terracottaPot,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),

              // Popular GI Craft Clusters
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular GI Craft Clusters',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: _textDark,
                    ),
                  ),
                  InkWell(
                    onTap: widget.onOpenDiscover,
                    child: const Text(
                      'View Map ›',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _primaryRust,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),

              // Clusters Grid (All Clickable)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildClusterCard('Khurja Pottery', 'Uttar Pradesh', 'Ceramics & Dinnerware', Icons.coffee_outlined),
                    const SizedBox(width: 12.0),
                    _buildClusterCard('Varanasi Handloom', 'Uttar Pradesh', 'Zari Silk & Brocade', Icons.style_outlined),
                    const SizedBox(width: 12.0),
                    _buildClusterCard('Bastar Metalcraft', 'Chhattisgarh', 'Bell Metal & Dhokra', Icons.diamond_outlined),
                    const SizedBox(width: 12.0),
                    _buildClusterCard('Channapatna Toys', 'Karnataka', 'Natural Lacquered Wood', Icons.toys_outlined),
                    const SizedBox(width: 12.0),
                    _buildClusterCard('Madhubani Art', 'Bihar', 'Folk Painting Scrolls', Icons.brush_outlined),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),

              // Featured Verified Artisans
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Featured Verified Artisans',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: _textDark,
                    ),
                  ),
                  InkWell(
                    onTap: widget.onOpenFeatured ?? widget.onOpenDiscover,
                    child: const Text(
                      'See All (140+) ›',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: _primaryRust,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),

              // Artisan Cards List (All Clickable)
              _buildArtisanCard(
                name: 'Ramu Kumar Prajapati',
                craft: 'Master Blue Pottery Maker',
                rating: '4.9',
                location: 'Khurja Cluster',
                capacity: '2,000 pcs / mo',
                badgeText: 'GI Tag Verified',
                avatar: CraftAssets.artisanRamuKumar,
                onTap: () => _showArtisanProfileModal(
                  context,
                  name: 'Ramu Kumar Prajapati',
                  craft: 'Master Blue Pottery Maker',
                  rating: '4.9',
                  location: 'Khurja Cluster',
                  capacity: '2,000 pcs / mo',
                  avatar: CraftAssets.artisanRamuKumar,
                ),
              ),
              const SizedBox(height: 12.0),

              _buildArtisanCard(
                name: 'Sunita Devi',
                craft: 'Madhubani & Sikki Grass Artisan',
                rating: '4.8',
                location: 'Madhubani, Bihar',
                capacity: '500 sets / mo',
                badgeText: 'National Awardee',
                avatar: CraftAssets.artisanSunitaDevi,
                onTap: () => _showArtisanProfileModal(
                  context,
                  name: 'Sunita Devi',
                  craft: 'Madhubani & Sikki Grass Artisan',
                  rating: '4.8',
                  location: 'Madhubani, Bihar',
                  capacity: '500 sets / mo',
                  avatar: CraftAssets.artisanSunitaDevi,
                ),
              ),
              const SizedBox(height: 12.0),

              _buildArtisanCard(
                name: 'Rajesh Prajapati',
                craft: 'Terracotta & Earthen Crafts',
                rating: '4.9',
                location: 'Gorakhpur, UP',
                capacity: '5,000 pcs / mo',
                badgeText: 'Export Ready',
                avatar: CraftAssets.artisanRajeshPrajapati,
                onTap: () => _showArtisanProfileModal(
                  context,
                  name: 'Rajesh Prajapati',
                  craft: 'Terracotta & Earthen Crafts',
                  rating: '4.9',
                  location: 'Gorakhpur, UP',
                  capacity: '5,000 pcs / mo',
                  avatar: CraftAssets.artisanRajeshPrajapati,
                ),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BuyerBottomNavBar(
        currentIndex: 0,
        onTap: (idx) => widget.onTabChange?.call(idx),
      ),
    );
  }

  Widget _buildCategoryFilterChip(String label, IconData icon) {
    final isSelected = _selectedCategory == label;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        avatar: Icon(
          icon,
          size: 16.0,
          color: isSelected ? Colors.white : _primaryRust,
        ),
        label: Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : _textDark,
          ),
        ),
        selected: isSelected,
        onSelected: (val) {
          setState(() {
            _selectedCategory = label;
          });
          if (label != 'All') {
            widget.onSearchByQuery?.call(label);
          }
        },
        backgroundColor: Colors.white,
        selectedColor: _primaryRust,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(
            color: isSelected ? _primaryRust : const Color(0xFFE5D5CB),
            width: 1.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      ),
    );
  }

  Widget _buildClusterCard(String title, String state, String specialty, IconData icon) {
    return InkWell(
      onTap: () => _showClusterInfoModal(title, state, specialty),
      borderRadius: BorderRadius.circular(14.0),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: const Color(0xFFEFE8E2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF2EC),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(icon, color: _primaryRust, size: 20),
            ),
            const SizedBox(height: 10.0),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.0, color: _textDark),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2.0),
            Text(
              state,
              style: const TextStyle(fontSize: 11.0, color: _textMuted),
            ),
            const SizedBox(height: 6.0),
            Text(
              specialty,
              style: const TextStyle(fontSize: 10.0, color: _primaryRust, fontWeight: FontWeight.w700),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, String buyerName, String businessName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                title: Row(
                  children: const [
                    HunarSangamLogoBadge(size: 32.0, showText: false),
                    SizedBox(width: 10.0),
                    Text('HunarSangam', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF8D3412))),
                  ],
                ),
                content: const Text(
                  'HunarSangam connects verified Indian GI handicraft artisans with bulk enterprise buyers for ethical, transparent escrow commerce.',
                  style: TextStyle(fontSize: 13.0, color: _textMuted, height: 1.4),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Got it', style: TextStyle(color: _primaryRust, fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
            );
          },
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: Row(
              children: [
                const HunarSangamLogoBadge(size: 34, showText: false),
                const SizedBox(width: 8.0),
                const Text(
                  'HunarSangam',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF8D3412),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(width: 6.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3ECE6),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Bulk Buyer',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8D3412),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.tune_rounded, size: 20, color: Color(0xFF5D4037)),
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: (SupabaseConfig.isSupabaseConfigured() && SupabaseConfig.isGeminiConfigured())
                            ? const Color(0xFF2E7D32)
                            : const Color(0xFFE65100),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () => ApiConfigDialog.show(context),
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(6.0),
              tooltip: 'Cloud & AI Setup',
            ),
            IconButton(
              icon: const Icon(Icons.translate, size: 20, color: Color(0xFF5D4037)),
              onPressed: _showLanguageSelector,
              constraints: const BoxConstraints(),
              padding: const EdgeInsets.all(6.0),
              tooltip: 'Switch Language',
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_none, size: 22, color: Color(0xFF5D4037)),
                  onPressed: _showNotificationSheet,
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(6.0),
                  tooltip: 'Notifications',
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: const BoxDecoration(
                      color: _primaryRust,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 6.0),
            InkWell(
              onTap: () => _showProfileMenuSheet(buyerName, businessName),
              borderRadius: BorderRadius.circular(16.0),
              child: const CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProductCard({
    required String image,
    required String craftTag,
    required String moqText,
    required String title,
    required String artisan,
    required String location,
    required String priceText,
    required VoidCallback onTap,
  }) {
    final isBookmarked = _bookmarkedItems.contains(title);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: const Color(0xFFEFE8E2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(14.0)),
                  child: Image.network(
                    image,
                    height: 120,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      craftTag,
                      style: const TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (isBookmarked) {
                          _bookmarkedItems.remove(title);
                        } else {
                          _bookmarkedItems.add(title);
                        }
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isBookmarked ? 'Removed from saved' : 'Added $title to saved items'),
                          duration: const Duration(milliseconds: 900),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        size: 14,
                        color: isBookmarked ? _primaryRust : const Color(0xFF5D4037),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: _textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    '👤 Artisan: $artisan',
                    style: const TextStyle(fontSize: 10.5, color: _textMuted),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '📍 $location',
                    style: const TextStyle(fontSize: 10.5, color: _textMuted),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        priceText,
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w700,
                          color: _primaryRust,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFEADFD6)),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: const Text(
                          'View Product',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _textDark),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArtisanCard({
    required String name,
    required String craft,
    required String rating,
    required String location,
    required String capacity,
    required String badgeText,
    required String avatar,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: const Color(0xFFEFE8E2)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(avatar),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E7D32),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: _textDark,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFDECE5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              badgeText,
                              style: const TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w700,
                                color: _primaryRust,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        craft,
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: _primaryRust,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 12, color: Color(0xFFF57C00)),
                          const SizedBox(width: 2.0),
                          Text(
                            '$rating • ',
                            style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: _textDark),
                          ),
                          Text(
                            '$location • ',
                            style: const TextStyle(fontSize: 10.5, color: _textMuted),
                          ),
                          Text(
                            'Capacity: $capacity',
                            style: const TextStyle(fontSize: 10.5, color: Color(0xFF2E7D32), fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: double.infinity,
              height: 36,
              child: ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF0E5DC),
                  foregroundColor: _textDark,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('View Artisan Profile & Portfolio', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                    SizedBox(width: 4.0),
                    Icon(Icons.arrow_forward, size: 13),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
