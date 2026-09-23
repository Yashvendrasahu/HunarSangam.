// lib/add_product/screens/ai_draft_preview_screen.dart

import 'package:flutter/material.dart';
import '../models/product_draft.dart';
import '../widgets/artisan_bottom_navigation.dart';
import '../../widgets/craft_image.dart';

/// Screen 6: Matches 'p6-decsiption review.png' 100%
/// Product Preview - Step 2 of 2 • Review & Confirm
/// - App Bar: Back arrow, "Product Preview", "✨ AI Generated • Verified" green badge, "English ▾" dropdown
/// - Step indicator line: "Step 2 of 2 • Review & Confirm" + 2 progress indicator dashes (Green + Brown)
/// - "AI Craft Draft Ready" card with rust avatar icon
/// - "Input Voice Clip" player bar with "Re-record ⟳"
/// - Product card with photo, badges ("✨ AI Cataloged", "✔ 🛡️ GI Cluster Verified", "📷 Change Photo"),
///   Title & Description with voice edit mic buttons
/// - Extracted Specifications grid (4 tiles: Category, Material, Dimensions, Finish & Color) with "🎙️ Tap to edit"
/// - "Looks Good — Continue →" & "🎙️ Edit Whole Card With Voice" CTAs
/// - Footer: "Zero typing required • Instant B2B cataloging"
/// - 5-tab Artisan Bottom Navigation with Products active
class AiDraftPreviewScreen extends StatelessWidget {
  final ProductDraft draft;
  final VoidCallback onContinue;
  final VoidCallback onVoiceEdit;
  final VoidCallback onBack;
  final Function(int)? onNavigateTab;

  const AiDraftPreviewScreen({
    super.key,
    required this.draft,
    required this.onContinue,
    required this.onVoiceEdit,
    required this.onBack,
    this.onNavigateTab,
  });

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
          onPressed: onBack,
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            const Text(
              'Product Preview',
              style: TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.w800,
                color: Color(0xFF221C19),
              ),
            ),
            const SizedBox(width: 6.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.5),
              decoration: BoxDecoration(
                color: const Color(0xFFD4EFDF),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.auto_awesome, color: Color(0xFF1E824C), size: 10.0),
                  SizedBox(width: 3.0),
                  Text(
                    'AI Generated • Verified',
                    style: TextStyle(
                      fontSize: 9.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E824C),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBF2EB),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'English',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF221C19),
                      ),
                    ),
                    SizedBox(width: 3.0),
                    Icon(Icons.arrow_drop_down_rounded, size: 18.0, color: Color(0xFF221C19)),
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
              // Step indicator row with Dual Progress Bars
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Step 2 of 2 • Review & Confirm',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF8C3A16),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 20.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E824C),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                      const SizedBox(width: 4.0),
                      Container(
                        width: 20.0,
                        height: 4.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF8C3A16),
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12.0),

              // Card 1: AI Craft Draft Ready Notice
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF6F0),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 34.0,
                      height: 34.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFE8DC),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.person_rounded, color: Color(0xFF8C3A16), size: 18.0),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'AI Craft Draft Ready',
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF221C19),
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            'Here is what AI created from your voice note. Tap any item to edit with voice.',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFF7A685F),
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12.0),

              // Card 2: Input Voice Clip Player
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF1EA),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.mic_rounded, size: 14.0, color: Color(0xFF8C3A16)),
                            SizedBox(width: 5.0),
                            Text(
                              'Input Voice Clip',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF221C19),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: onVoiceEdit,
                          child: Row(
                            children: const [
                              Icon(Icons.refresh_rounded, size: 13.0, color: Color(0xFF8C3A16)),
                              SizedBox(width: 3.0),
                              Text(
                                'Re-record',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF8C3A16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFDFB),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: const Color(0xFFEADFD6)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            decoration: const BoxDecoration(
                              color: Color(0xFF8C3A16),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 16.0),
                          ),
                          const SizedBox(width: 10.0),
                          // Multi-height waveform bars
                          Row(
                            children: [
                              _buildAudioBar(14.0),
                              _buildAudioBar(20.0),
                              _buildAudioBar(10.0),
                              _buildAudioBar(24.0),
                              _buildAudioBar(16.0),
                              _buildAudioBar(18.0),
                              _buildAudioBar(12.0),
                              _buildAudioBar(8.0),
                            ],
                          ),
                          const SizedBox(width: 10.0),
                          const Expanded(
                            child: Text(
                              '"Handmade bamboo basket..."',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10.5,
                                fontStyle: FontStyle.italic,
                                color: Color(0xFF4A372D),
                              ),
                            ),
                          ),
                          const Text(
                            '0:14',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF221C19),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12.0),

              // Card 3: Product Card (Photo + Badges + Title & Description)
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDFB),
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Photo + 3 Badges
                    Stack(
                      children: [
                        CraftImage(
                          imageSource: draft.photoUrl,
                          craftCategoryOrTitle: draft.category.isNotEmpty ? draft.category : draft.title,
                          height: 180.0,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 8.0,
                          left: 8.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.65),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.auto_awesome, color: Color(0xFFFFD54F), size: 10.0),
                                SizedBox(width: 3.0),
                                Text(
                                  'AI Cataloged',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8.0,
                          left: 110.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD4EFDF),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.verified_rounded, color: Color(0xFF1E824C), size: 10.0),
                                SizedBox(width: 3.0),
                                Text(
                                  'GI Cluster Verified',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1E824C),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8.0,
                          right: 8.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.5),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.65),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.camera_alt_outlined, size: 12.0, color: Colors.white),
                                SizedBox(width: 4.0),
                                Text(
                                  'Change Photo',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title + Edit Mic Button
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  draft.title,
                                  style: const TextStyle(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF221C19),
                                    letterSpacing: -0.3,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Container(
                                width: 32.0,
                                height: 32.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFE8DC),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: const Icon(Icons.mic_rounded, color: Color(0xFF8C3A16), size: 16.0),
                                  onPressed: onVoiceEdit,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8.0),

                          // Description Box + Edit Mic Button
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFBF4EE),
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: const Color(0xFFEADFD6)),
                            ),
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    draft.description,
                                    style: const TextStyle(
                                      fontSize: 11.5,
                                      color: Color(0xFF4A372D),
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6.0),
                                Container(
                                  width: 26.0,
                                  height: 26.0,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFE8DC),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.mic_rounded, color: Color(0xFF8C3A16), size: 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 14.0),

                          // Extracted Specifications Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Extracted Specifications',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF221C19),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(Icons.mic_rounded, size: 12.0, color: Color(0xFF8C3A16)),
                                  SizedBox(width: 3.0),
                                  Text(
                                    'Tap tile to speak',
                                    style: TextStyle(
                                      fontSize: 10.5,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF8C3A16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 10.0),

                          // 2x2 Specifications Grid
                          Row(
                            children: [
                              Expanded(
                                child: _buildSpecTile(
                                  label: 'Category',
                                  icon: Icons.category_outlined,
                                  value: draft.category,
                                  onTap: onVoiceEdit,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: _buildSpecTile(
                                  label: 'Material',
                                  icon: Icons.grain_rounded,
                                  value: draft.material,
                                  onTap: onVoiceEdit,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              Expanded(
                                child: _buildSpecTile(
                                  label: 'Dimensions',
                                  icon: Icons.straighten_rounded,
                                  value: '12" L × 12" W × 6" H',
                                  subLabel: '(Estimated via voice)',
                                  onTap: onVoiceEdit,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Expanded(
                                child: _buildSpecTile(
                                  label: 'Finish & Color',
                                  icon: Icons.palette_outlined,
                                  value: draft.finishAndColor,
                                  onTap: onVoiceEdit,
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

              const SizedBox(height: 16.0),

              // CTA 1: Looks Good — Continue →
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8C3A16),
                    foregroundColor: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Looks Good — Continue',
                        style: TextStyle(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 6.0),
                      Icon(Icons.arrow_forward_rounded, size: 18.0),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10.0),

              // CTA 2: Edit Whole Card With Voice
              SizedBox(
                width: double.infinity,
                height: 46.0,
                child: OutlinedButton.icon(
                  onPressed: onVoiceEdit,
                  icon: const Icon(Icons.mic_rounded, color: Color(0xFF8C3A16), size: 16.0),
                  label: const Text(
                    'Edit Whole Card With Voice',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8C3A16),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFFAF1EA),
                    side: const BorderSide(color: Color(0xFFEADFD6)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8.0),

              const Center(
                child: Text(
                  'Zero typing required • Instant B2B cataloging',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Color(0xFF7A685F),
                  ),
                ),
              ),

              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ArtisanBottomNavigation(
        currentIndex: 1,
        onTap: onNavigateTab,
      ),
    );
  }

  Widget _buildAudioBar(double height) {
    return Container(
      width: 2.5,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 1.5),
      decoration: BoxDecoration(
        color: const Color(0xFF8C3A16),
        borderRadius: BorderRadius.circular(1.0),
      ),
    );
  }

  Widget _buildSpecTile({
    required String label,
    required IconData icon,
    required String value,
    String? subLabel,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFDFB),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: const Color(0xFFEADFD6)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF7A685F),
                  ),
                ),
                Icon(icon, size: 13.0, color: const Color(0xFF7A685F)),
              ],
            ),
            const SizedBox(height: 4.0),
            Text(
              value,
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: Color(0xFF221C19),
              ),
            ),
            if (subLabel != null) ...[
              const SizedBox(height: 2.0),
              Text(
                subLabel,
                style: const TextStyle(
                  fontSize: 9.0,
                  color: Color(0xFF7A685F),
                ),
              ),
            ],
            const SizedBox(height: 6.0),
            Row(
              children: const [
                Icon(Icons.mic_rounded, size: 10.0, color: Color(0xFF8C3A16)),
                SizedBox(width: 3.0),
                Text(
                  'Tap to edit',
                  style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8C3A16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

