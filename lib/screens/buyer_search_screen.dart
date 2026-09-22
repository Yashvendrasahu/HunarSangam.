// lib/screens/buyer_search_screen.dart

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';
import '../services/hardware_service.dart';

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

  final List<String> _trending = [
    'Handmade Bamboo Baskets',
    'Blue Pottery Jaipur',
    'Terracotta Planters',
    'Khurja Ceramic Mugs',
    'Moradabad Brass Bowls',
    'Chanderi Silk Stoles',
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
        backgroundColor: Color(0xFFA84318),
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
          // Fallback to default search query
          widget.onVoiceSearch();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D2421)),
          onPressed: widget.onBack,
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search craft, region, or cluster...',
            hintStyle: TextStyle(fontSize: 14, color: Color(0xFF8D6E63)),
            border: InputBorder.none,
          ),
          onSubmitted: (val) {
            if (val.trim().isNotEmpty) _triggerSearch(val.trim());
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              color: _isListening ? Colors.red : const Color(0xFFA84318),
            ),
            tooltip: 'Voice Search',
            onPressed: _handleVoiceSearch,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Trending Searches in Craft Clusters',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF2D2421)),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _trending.map((t) {
                return ActionChip(
                  label: Text(t),
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFFEADFD6)),
                  labelStyle: const TextStyle(fontSize: 12.5, color: Color(0xFF2D2421), fontWeight: FontWeight.w600),
                  onPressed: () => _triggerSearch(t),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BuyerBottomNavBar(
        currentIndex: 0,
        onTap: (idx) => widget.onTabChange?.call(idx),
      ),
    );
  }
}
