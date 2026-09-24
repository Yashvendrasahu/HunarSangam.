// lib/screens/buyer_search_screen.dart

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';
import '../services/hardware_service.dart';
import '../utils/craft_assets.dart';
import '../widgets/craft_image.dart';

/// Screen d2: Bulk Buyer Search Screen
/// Matches 'd2 - bulk— Search.png'
class BuyerSearchScreen extends StatefulWidget {
  final VoidCallback onBack;
  final Function(String query)? onSearch;
  final Function(String query)? onSelectQuery;
  final VoidCallback onVoiceSearch;
  final Function(int)? onTabChange;

  const BuyerSearchScreen({
    super.key,
    required this.onBack,
    this.onSearch,
    this.onSelectQuery,
    required this.onVoiceSearch,
    this.onTabChange,
  });

  @override
  State<BuyerSearchScreen> createState() => _BuyerSearchScreenState();
}

class _BuyerSearchScreenState extends State<BuyerSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isListening = false;

  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFDFBF9);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);

  final List<String> _recentSearches = [
    'Bamboo fruit baskets bulk',
    'Blue pottery dinner sets 100 pcs',
    'Varanasi handloom silk stoles',
  ];

  final List<String> _trending = [
    'Khurja Ceramic Planters',
    'Chanderi Silk Sarees',
    'Blue Pottery Tiles',
    'Dhokra Brass Statues',
    'Wooden Spice Boxes',
    'Barabanki Cane Baskets',
  ];

  final List<Map<String, String>> _categories = [
    {
      'title': 'Pottery & Ceramics',
      'image': CraftAssets.bluePotteryVase,
    },
    {
      'title': 'Handloom & Textiles',
      'image': CraftAssets.banarasiSaree,
    },
    {
      'title': 'Cane & Bamboo',
      'image': CraftAssets.bambooBasket,
    },
    {
      'title': 'Metal & Brass',
      'image': CraftAssets.brassVase,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _triggerSearch(String query) {
    if (widget.onSelectQuery != null) {
      widget.onSelectQuery!(query);
    } else if (widget.onSearch != null) {
      widget.onSearch!(query);
    }
  }

  Future<void> _handleVoiceSearch() async {
    if (_isListening) {
      await HardwareService().stopListening();
      if (mounted) setState(() => _isListening = false);
      return;
    }

    setState(() => _isListening = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🎙️ Listening... Speak your craft search query now'),
        duration: Duration(seconds: 2),
        backgroundColor: _primaryRust,
      ),
    );

    await HardwareService().startListening(
      onResult: (text, isFinal) {
        if (text.isNotEmpty) {
          _searchController.text = text;
          if (isFinal) {
            if (mounted) setState(() => _isListening = false);
            _triggerSearch(text);
          }
        }
      },
      onStopped: () {
        if (mounted) setState(() => _isListening = false);
      },
      onError: (err) {
        if (mounted) {
          setState(() => _isListening = false);
          widget.onVoiceSearch();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgCanvas,
      appBar: _buildTopBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search input bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFE5D5CB)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Color(0xFF8D6E63), size: 20),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700, color: _textDark),
                        decoration: const InputDecoration(
                          hintText: 'Search products, artisans, crafts...',
                          hintStyle: TextStyle(fontSize: 13, color: Color(0xFF8D6E63)),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                        ),
                        onSubmitted: (val) {
                          if (val.trim().isNotEmpty) _triggerSearch(val.trim());
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt_outlined, color: Color(0xFF8D6E63), size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () async {
                        final img = await HardwareService().captureImageFromCamera();
                        if (img != null) {
                          _triggerSearch('Handmade Bamboo Craft');
                        }
                      },
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: _isListening ? Colors.red : _primaryRust,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: IconButton(
                        icon: Icon(_isListening ? Icons.mic : Icons.mic_none, color: Colors.white, size: 18),
                        padding: EdgeInsets.zero,
                        onPressed: _handleVoiceSearch,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14.0),

              // Quick filter pills
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildPill(icon: Icons.tune, label: 'All Filters'),
                    const SizedBox(width: 8.0),
                    _buildPill(icon: Icons.verified, label: 'Verified Artisans', green: true),
                    const SizedBox(width: 8.0),
                    _buildPill(label: 'GI Certified'),
                    const SizedBox(width: 8.0),
                    _buildPill(label: 'Direct from Artisans'),
                    const SizedBox(width: 8.0),
                    _buildPill(label: 'MOQ < 50 pcs'),
                  ],
                ),
              ),
              const SizedBox(height: 22.0),

              // Recent Searches
              if (_recentSearches.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'RECENT SEARCHES',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF5D4037),
                        letterSpacing: 0.5,
                      ),
                    ),
                    InkWell(
                      onTap: () => setState(() => _recentSearches.clear()),
                      child: const Text(
                        'Clear All',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: _primaryRust,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                ..._recentSearches.map((item) {
                  return InkWell(
                    onTap: () => _triggerSearch(item),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          const Icon(Icons.history, size: 18, color: Color(0xFF8D6E63)),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 13, color: _textDark, fontWeight: FontWeight.w600),
                            ),
                          ),
                          InkWell(
                            onTap: () => setState(() => _recentSearches.remove(item)),
                            child: const Icon(Icons.close, size: 16, color: Color(0xFFB0A298)),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20.0),
              ],

              // Trending Searches
              const Text(
                'TRENDING SEARCHES',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF5D4037),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 10.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _trending.map((trend) {
                  return InkWell(
                    onTap: () => _triggerSearch(trend),
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: const Color(0xFFEADFD6)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.trending_up, size: 14, color: _primaryRust),
                          const SizedBox(width: 6.0),
                          Text(
                            trend,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24.0),

              // Popular Categories
              const Text(
                'POPULAR CATEGORIES',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF5D4037),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 12.0),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.6,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  return InkWell(
                    onTap: () => _triggerSearch(cat['title']!),
                    borderRadius: BorderRadius.circular(12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          CraftImage(
                            imageSource: cat['image']!,
                            craftCategoryOrTitle: cat['title']!,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.38),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                cat['title']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BuyerBottomNavBar(
        currentIndex: 1,
        onTap: (idx) => widget.onTabChange?.call(idx),
      ),
    );
  }

  PreferredSizeWidget _buildTopBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: _textDark, size: 22),
        onPressed: widget.onBack,
      ),
      title: Row(
        children: [
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
      actions: [
        IconButton(
          icon: const Icon(Icons.translate, size: 20, color: Color(0xFF5D4037)),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('🌐 Language: English & Hindi voice search active'),
                duration: Duration(seconds: 1),
              ),
            );
          },
          tooltip: 'Switch Language',
        ),
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_none, size: 22, color: Color(0xFF5D4037)),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('🔔 You have 3 active cluster updates & quotes.'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
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
        const SizedBox(width: 8.0),
      ],
    );
  }

  Widget _buildPill({IconData? icon, required String label, bool green = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: green ? const Color(0xFFE8F5E9) : Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: green ? const Color(0xFFC8E6C9) : const Color(0xFFE5D5CB)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13, color: green ? const Color(0xFF2E7D32) : const Color(0xFF5D4037)),
            const SizedBox(width: 4.0),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: green ? const Color(0xFF2E7D32) : _textDark,
            ),
          ),
        ],
      ),
    );
  }
}
