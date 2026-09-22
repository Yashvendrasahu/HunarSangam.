// lib/add_product/screens/bulk_capacity_screen.dart

import 'package:flutter/material.dart';
import '../models/product_draft.dart';
import '../widgets/voice_waveform.dart';
import '../widgets/artisan_bottom_navigation.dart';

/// Screen 8: Matches 'p8-voice based piese in day asking.png' 100%
/// Bulk Record - Production capacity asking screen:
/// - AppBar: Back arrow, "Bulk Record", "Product: Assam Cane Basket", "文A English ▾" pill
/// - Product overview card: Photo with "GI CRAFT" badge, "Woven Bamboo Basket", "Assam Golden Cane • Hand-plaited",
///   "🏷 ₹280/pc", "📦 Min: 20 pcs", "🔊 Artisan audio note included (0:24)", "Ready for Bulk Quotations"
/// - Main Question Card: "🪄 How many pieces you made in 1 day ( 8 hours work )" with underline
/// - Try saying section:
///   - 🎙️ Say: "10 pieces 1 day " ↗
///   - 🎙️ Say: "10–20 pieces in 1 day " ↗
/// - Concentric Live Voice Studio Canvas with "🔴 🔴 Recording Live (0:12)", glowing rings, mic, and waveform
/// - Real-time Transcription: "“I made 15 pieces in day 1 work house of 8 house”"
/// - "✓ Save and Submit Product" primary CTA
/// - 5-tab Artisan Bottom Navigation with Products active
class BulkCapacityScreen extends StatefulWidget {
  final ProductDraft draft;
  final Function(int capacityPcs) onSaveCapacity;
  final VoidCallback onBack;
  final Function(int)? onNavigateTab;

  const BulkCapacityScreen({
    super.key,
    required this.draft,
    required this.onSaveCapacity,
    required this.onBack,
    this.onNavigateTab,
  });

  @override
  State<BulkCapacityScreen> createState() => _BulkCapacityScreenState();
}

class _BulkCapacityScreenState extends State<BulkCapacityScreen> {
  bool _isRecording = true;
  String _transcription = '“I made 15 pieces in day 1 work house of 8 house”';
  int _parsedCapacity = 15;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFDFB),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF221C19), size: 22.0),
          onPressed: widget.onBack,
        ),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Bulk Record',
              style: TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.w800,
                color: Color(0xFF221C19),
              ),
            ),
            SizedBox(height: 1.0),
            Text(
              'Product: Assam Cane Basket',
              style: TextStyle(
                fontSize: 11.0,
                color: Color(0xFF7A685F),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBF2EB),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.translate_rounded, size: 13.0, color: Color(0xFF8C3A16)),
                    SizedBox(width: 4.0),
                    Text(
                      'English ▾',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF8C3A16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1.0, color: Color(0xFFEADFD6)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Overview Card matching p8
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDFB),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFE5D5CB), width: 1.5),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Stack(
                            children: [
                              Image.network(
                                'https://images.unsplash.com/photo-1590402494682-cd3fb53b1f70?w=600&auto=format&fit=crop&q=80',
                                width: 64.0,
                                height: 64.0,
                                fit: BoxFit.cover,
                                errorBuilder: (ctx, err, stack) => Container(
                                  width: 64.0,
                                  height: 64.0,
                                  color: const Color(0xFFEADFD6),
                                  child: const Icon(Icons.shopping_basket_outlined, color: Color(0xFF8C3A16)),
                                ),
                              ),
                              Positioned(
                                bottom: 3.0,
                                left: 3.0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.5),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E824C),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: const Text(
                                    'GI CRAFT',
                                    style: TextStyle(
                                      fontSize: 7.5,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Woven Bamboo Basket',
                                style: TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF221C19),
                                ),
                              ),
                              const SizedBox(height: 2.0),
                              const Text(
                                'Assam Golden Cane • Hand-plaited',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: Color(0xFF7A685F),
                                ),
                              ),
                              const SizedBox(height: 6.0),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFAF1EA),
                                      borderRadius: BorderRadius.circular(6.0),
                                      border: Border.all(color: const Color(0xFFE5D5CB)),
                                    ),
                                    child: const Text(
                                      '🏷️ ₹280/pc',
                                      style: TextStyle(
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF8C3A16),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 6.0),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFAF1EA),
                                      borderRadius: BorderRadius.circular(6.0),
                                      border: Border.all(color: const Color(0xFFE5D5CB)),
                                    ),
                                    child: const Text(
                                      '📦 Min: 20 pcs',
                                      style: TextStyle(
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF4A372D),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const Divider(height: 1.0, color: Color(0xFFEADFD6)),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Row(
                          children: [
                            Icon(Icons.volume_up_rounded, size: 14.0, color: Color(0xFF8C3A16)),
                            SizedBox(width: 4.0),
                            Text(
                              'Artisan audio note included (0:24)',
                              style: TextStyle(
                                fontSize: 10.5,
                                color: Color(0xFF7A685F),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Ready for Bulk Quotations',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E824C),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14.0),

              // Main Question Card matching p8
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDFB),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.auto_fix_high_rounded, color: Color(0xFF8C3A16), size: 18.0),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'How many pieces you made in 1 day ( 8 hours work )',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF221C19),
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Container(
                            height: 1.5,
                            color: const Color(0xFFEADFD6),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14.0),

              // Try Saying Suggestions matching p8
              Row(
                children: const [
                  Icon(Icons.lightbulb_outline, size: 14.0, color: Color(0xFF7A685F)),
                  SizedBox(width: 4.0),
                  Text(
                    'Try saying :',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF7A685F),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),

              // Suggestion 1
              _buildSuggestionTile(
                text: 'Say: "10 pieces 1 day "',
                onTap: () {
                  setState(() {
                    _transcription = '“I made 10 pieces in 1 day”';
                    _parsedCapacity = 10;
                  });
                },
              ),
              const SizedBox(height: 8.0),

              // Suggestion 2
              _buildSuggestionTile(
                text: 'Say: "10–20 pieces in 1 day "',
                onTap: () {
                  setState(() {
                    _transcription = '“I made 15 pieces in 1 day average”';
                    _parsedCapacity = 15;
                  });
                },
              ),

              const SizedBox(height: 14.0),

              // Big Voice Recording Studio Card matching p8
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDFB),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Recording Live Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE8DC),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.circle, color: Color(0xFF8C3A16), size: 7.0),
                          SizedBox(width: 4.0),
                          Icon(Icons.circle, color: Color(0xFF8C3A16), size: 7.0),
                          SizedBox(width: 5.0),
                          Text(
                            'Recording Live (0:12)',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF8C3A16),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20.0),

                    // Glowing Concentric Circles Mic
                    GestureDetector(
                      onTap: () {
                        setState(() => _isRecording = !_isRecording);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 140.0,
                            height: 140.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFFAF1EA).withValues(alpha: 0.8),
                            ),
                          ),
                          Container(
                            width: 110.0,
                            height: 110.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFF3E3D6).withValues(alpha: 0.9),
                            ),
                          ),
                          Container(
                            width: 76.0,
                            height: 76.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF8C3A16),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x338C3A16),
                                  blurRadius: 12.0,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.mic_rounded,
                              color: Colors.white,
                              size: 34.0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20.0),

                    // Equalizer bars
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        _EqualizerBar(height: 14.0),
                        _EqualizerBar(height: 22.0),
                        _EqualizerBar(height: 10.0),
                        _EqualizerBar(height: 26.0),
                        _EqualizerBar(height: 18.0),
                        _EqualizerBar(height: 20.0),
                        _EqualizerBar(height: 12.0),
                        _EqualizerBar(height: 8.0),
                      ],
                    ),

                    const SizedBox(height: 16.0),

                    // Real-time Transcription Box
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBF4EE),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(color: const Color(0xFFEADFD6)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.graphic_eq_rounded, size: 14.0, color: Color(0xFF1E824C)),
                              SizedBox(width: 5.0),
                              Text(
                                'Real-time Transcription',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF221C19),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            _transcription,
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF221C19),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16.0),

                    // Save and Submit Product Button
                    SizedBox(
                      width: double.infinity,
                      height: 48.0,
                      child: ElevatedButton(
                        onPressed: () => widget.onSaveCapacity(_parsedCapacity),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8C3A16),
                          foregroundColor: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_outline_rounded, size: 18.0),
                            SizedBox(width: 6.0),
                            Text(
                              'Save and Submit Product',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ArtisanBottomNavigation(
        currentIndex: 1,
        onTap: widget.onNavigateTab,
      ),
    );
  }

  Widget _buildSuggestionTile({
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFDFB),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: const Color(0xFFEADFD6)),
        ),
        child: Row(
          children: [
            const Icon(Icons.mic_none_rounded, size: 15.0, color: Color(0xFF8C3A16)),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF221C19),
                ),
              ),
            ),
            const Icon(Icons.north_east_rounded, size: 14.0, color: Color(0xFF7A685F)),
          ],
        ),
      ),
    );
  }
}

class _EqualizerBar extends StatelessWidget {
  final double height;
  const _EqualizerBar({required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 3.5,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      decoration: BoxDecoration(
        color: const Color(0xFF8C3A16),
        borderRadius: BorderRadius.circular(2.0),
      ),
    );
  }
}

