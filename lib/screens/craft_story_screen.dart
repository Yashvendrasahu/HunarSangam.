// lib/screens/craft_story_screen.dart
// My Craft Story Screen (AI-Powered Voice-First Artisan Storytelling)
import 'package:flutter/material.dart';
import '../services/hardware_service.dart';

class CraftStoryScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onAudioGuideToggle;
  final VoidCallback? onRecordVoice;
  final VoidCallback? onSaveAndPublish;
  final VoidCallback? onReTellVoice;
  final VoidCallback? onPreviewBuyerView;

  const CraftStoryScreen({
    super.key,
    this.onBack,
    this.onAudioGuideToggle,
    this.onRecordVoice,
    this.onSaveAndPublish,
    this.onReTellVoice,
    this.onPreviewBuyerView,
  });

  @override
  State<CraftStoryScreen> createState() => _CraftStoryScreenState();
}

class _CraftStoryScreenState extends State<CraftStoryScreen> {
  bool _isPlayingVoiceNote = false;
  bool _isPlayingAudioGuide = false;
  bool _isRecording = false;
  String _recordedStory = '';

  @override
  void dispose() {
    HardwareService().stopAudio();
    HardwareService().stopListening();
    super.dispose();
  }

  void _toggleAudioGuide() {
    if (_isPlayingAudioGuide) {
      HardwareService().stopAudio();
      setState(() => _isPlayingAudioGuide = false);
    } else {
      setState(() => _isPlayingAudioGuide = true);
      HardwareService().speakText(
        'Welcome to My Craft Story. Speak naturally in your native voice about your craft heritage, weaving tradition, and master artisans. AI will structure this into a story for global buyers.',
        language: 'en-IN',
        onDone: () {
          if (mounted) setState(() => _isPlayingAudioGuide = false);
        },
      );
    }
  }

  void _playPrompt() {
    HardwareService().speakText(
      'I learned cane weaving from my father. Our bamboo is hand-harvested from mature riverbed groves and seasoned naturally.',
      language: 'en-IN',
    );
  }

  void _toggleRecord() async {
    if (_isRecording) {
      await HardwareService().stopListening();
      setState(() => _isRecording = false);
    } else {
      setState(() => _isRecording = true);
      final started = await HardwareService().startListening(
        language: 'hi-IN',
        onResult: (text, isFinal) {
          if (mounted) {
            setState(() {
              _recordedStory = text;
            });
          }
        },
        onError: (err) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(err), backgroundColor: const Color(0xFF8C3A16)),
            );
          }
        },
        onStopped: () {
          if (mounted) setState(() => _isRecording = false);
        },
      );
      if (!started && mounted) {
        setState(() => _isRecording = false);
      }
    }
  }

  void _togglePlayVoiceNote() {
    if (_isPlayingVoiceNote) {
      HardwareService().stopAudio();
      setState(() => _isPlayingVoiceNote = false);
    } else {
      setState(() => _isPlayingVoiceNote = true);
      final storyText = _recordedStory.isNotEmpty
          ? _recordedStory
          : 'I learned cane weaving from my father. Passed down through three generations in Assam, every piece is handcrafted with organic bamboo and food-safe finish.';
      HardwareService().speakText(
        storyText,
        language: 'en-IN',
        onDone: () {
          if (mounted) setState(() => _isPlayingVoiceNote = false);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top App Bar
            _buildTopBar(),

            // 2. Scrollable Content Area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // A. Artisan Profile Header Card
                    _buildArtisanHeaderCard(),
                    const SizedBox(height: 14.0),

                    // B. Tell Your Story in Your Voice Card
                    _buildVoiceStoryCard(),
                    const SizedBox(height: 14.0),

                    // C. AI-Crafted Buyer Story Card
                    _buildAiCraftedBuyerStoryCard(),
                    const SizedBox(height: 14.0),

                    // D. Where Your Story Appears Card
                    _buildWhereStoryAppearsCard(),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),

            // 3. Bottom Sticky Action Footer
            _buildBottomActionFooter(),
          ],
        ),
      ),
    );
  }

  // 1. Top App Bar
  Widget _buildTopBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFDFB),
        border: Border(
          bottom: BorderSide(color: Color(0xFFEADFD6), width: 1.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF221C19), size: 22),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: widget.onBack ?? () => Navigator.of(context).maybePop(),
              ),
              const SizedBox(width: 12.0),
              const Text(
                'My Craft Story',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF221C19),
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          Row(
            children: [
              // Audio Guide Pill Button
              InkWell(
                onTap: () {
                  _toggleAudioGuide();
                  if (widget.onAudioGuideToggle != null) widget.onAudioGuideToggle!();
                },
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDF2EB),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: const Color(0xFFF3DFD5)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _isPlayingAudioGuide ? Icons.volume_up : Icons.volume_down,
                        color: const Color(0xFF8C3A16),
                        size: 14.0,
                      ),
                      const SizedBox(width: 4.0),
                      const Text(
                        'Audio\nGuide',
                        style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8C3A16),
                          height: 1.1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              // Language Dropdown
              const Row(
                children: [
                  Text(
                    'English',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A3228),
                    ),
                  ),
                  Icon(Icons.arrow_drop_down, color: Color(0xFF4A3228), size: 18.0),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // A. Artisan Header Card
  Widget _buildArtisanHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDFB),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar with Verified Badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1544816155-12df9643f363?w=300&auto=format&fit=crop&q=80',
                      width: 56.0,
                      height: 56.0,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 56.0,
                        height: 56.0,
                        color: const Color(0xFFF0DFD3),
                        child: const Icon(Icons.person, color: Color(0xFF8C3A16)),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFF8C3A16),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.verified, color: Colors.white, size: 12.0),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12.0),
              // Artisan Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ramu Kumar',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF221C19),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    const Text(
                      'National Merit Handicraft Awardee',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA84318),
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    const Row(
                      children: [
                        Icon(Icons.location_on, size: 12.0, color: Color(0xFF8C3A16)),
                        SizedBox(width: 3.0),
                        Expanded(
                          child: Text(
                            'Bamboo & Cane Plaiting • Assam & Barabanki',
                            style: TextStyle(
                              fontSize: 10.5,
                              color: Color(0xFF6B584E),
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          // Chips
          Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: [
              _buildChip(
                label: 'GI Registered #431',
                icon: Icons.check,
                bgColor: const Color(0xFFE8F5E9),
                textColor: const Color(0xFF2E7D32),
                borderColor: const Color(0xFFC8E6C9),
              ),
              _buildChip(
                label: 'Master Craftsman',
                icon: Icons.military_tech_outlined,
                bgColor: const Color(0xFFF7EFE9),
                textColor: const Color(0xFF4A3228),
                borderColor: const Color(0xFFE8DDD5),
              ),
              _buildChip(
                label: '3rd Gen Weaver',
                icon: Icons.eco_outlined,
                bgColor: const Color(0xFFFDF2EB),
                textColor: const Color(0xFF8C3A16),
                borderColor: const Color(0xFFF5D8CA),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required String label,
    required IconData icon,
    required Color bgColor,
    required Color textColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11.0, color: textColor),
          const SizedBox(width: 4.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  // B. Tell Your Story in Your Voice Card
  Widget _buildVoiceStoryCard() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F5),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: const Color(0xFFF6E1D7)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFCEFE8),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Icon(Icons.mic, color: Color(0xFF8C2E18), size: 18.0),
              ),
              const SizedBox(width: 10.0),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tell Your Story in Your Voice',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF221C19),
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      'Zero Typing Needed • Native Dialects Supported',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8C2E18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          const Text(
            'Speak naturally in Hindi, Assamese, or your mother tongue. Describe your family roots, cane seasoning secrets, and cluster weavers. AI translates and refines it for global B2B buyers.',
            style: TextStyle(
              fontSize: 11.0,
              color: Color(0xFF6B584E),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12.0),

          // Prompt Suggestion Box
          GestureDetector(
            onTap: _playPrompt,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0E7),
                borderRadius: BorderRadius.circular(14.0),
                border: Border.all(color: const Color(0xFFFCDCCE)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF8C2E18),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.play_arrow, color: Colors.white, size: 14.0),
                  ),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Text(
                      'Prompt: "I learned cane weaving from my father..."',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF6B584E),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14.0),

          // Big Central Mic Button
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _toggleRecord();
                    if (widget.onRecordVoice != null) widget.onRecordVoice!();
                  },
                  child: Container(
                    width: 68.0,
                    height: 68.0,
                    decoration: BoxDecoration(
                      color: _isRecording ? const Color(0xFFFFD5C0) : const Color(0xFFFCE2D5),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF8C2E18).withOpacity(0.15),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Container(
                        width: 52.0,
                        height: 52.0,
                        decoration: BoxDecoration(
                          color: _isRecording ? Colors.red : const Color(0xFF8C2E18),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isRecording ? Icons.stop : Icons.mic,
                          color: Colors.white,
                          size: 26.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  _isRecording ? '🔴 Listening... Tap to Finish' : 'Tap to Record New Note',
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF221C19),
                  ),
                ),
                const SizedBox(height: 1.0),
                const Text(
                  'Recommended: 1 to 2 minutes',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF7A685F),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14.0),

          // Active Voice Note Player Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: const Color(0xFFEBDCD2)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.circle, color: Color(0xFF2E7D32), size: 8.0),
                        const SizedBox(width: 6.0),
                        Text(
                          _recordedStory.isNotEmpty ? 'Craft Maker Voice Note (Recorded)' : 'Craft Maker Voice Note (0:48)',
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF221C19),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Recorded Today',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF7A685F),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _togglePlayVoiceNote,
                      child: Container(
                        width: 28.0,
                        height: 28.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFF8C2E18),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isPlayingVoiceNote ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 16.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    // Waveform Bars
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(20, (index) {
                          final heights = [
                            6.0, 12.0, 18.0, 14.0, 8.0, 20.0, 16.0, 10.0,
                            22.0, 18.0, 12.0, 16.0, 20.0, 8.0, 14.0, 18.0,
                            10.0, 14.0, 8.0, 4.0
                          ];
                          final isHigh = index % 3 == 0;
                          return Container(
                            width: 3.0,
                            height: heights[index % heights.length],
                            decoration: BoxDecoration(
                              color: isHigh ? const Color(0xFFA84318) : const Color(0xFFF5C7B2),
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    const Icon(Icons.refresh, color: Color(0xFF7A685F), size: 18.0),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // C. AI-Crafted Buyer Story Card
  Widget _buildAiCraftedBuyerStoryCard() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDFB),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'AI-Crafted Buyer Story',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF221C19),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF2EB),
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: const Color(0xFFF5D8CA)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_awesome, color: Color(0xFF8C3A16), size: 11.0),
                    SizedBox(width: 3.0),
                    Text(
                      'Voice-Preserved',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF8C3A16),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          const Text(
            'Summarized and structured automatically for international buyers, retail brands, and craft exhibitions.',
            style: TextStyle(
              fontSize: 11.0,
              color: Color(0xFF6B584E),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 12.0),

          // Sub-Story 1: 3 Generations of Sustainable Cane Weaving
          _buildStoryCardItem(
            icon: Icons.history_edu,
            title: '3 Generations of Sustainable Cane Weaving',
            body:
                'Rooted in the rich artisan traditions of Northeast India, our family has practiced sustainable bamboo plaiting for over 45 years. Passed down through three generations in Assam and Barabanki, every warp and weft honors timeless tribal interlocking practices.',
            accentColor: const Color(0xFF8C2E18),
            bgColor: const Color(0xFFFFF8F4),
            borderColor: const Color(0xFFF2DFD4),
          ),
          const SizedBox(height: 10.0),

          // Sub-Story 2: Zero-Chemical, Food-Safe Craft
          _buildStoryCardItem(
            icon: Icons.eco_outlined,
            title: 'Zero-Chemical, Food-Safe Craft',
            body:
                'Each piece is hand-harvested from mature riverbed bamboo, seasoned in natural pit smoke, and treated with an organic mustard-seed oil finish. Designed for conscious contemporary spaces—entirely biodegradable, food-safe, and chemical-free.',
            accentColor: const Color(0xFF2E7D32),
            bgColor: const Color(0xFFF8FAF7),
            borderColor: const Color(0xFFE0EBE1),
          ),
          const SizedBox(height: 10.0),

          // Sub-Story 3: Empowering 14 Cluster Weavers
          _buildStoryCardItem(
            icon: Icons.groups_outlined,
            title: 'Empowering 14 Cluster Weavers',
            body:
                'Today Ramu leads a decentralized guild of 14 rural artisans, including 9 women master weavers. This collective fulfills export-grade wholesale contracts while funding apprentice workshops for young village artisans.',
            accentColor: const Color(0xFF7A4A28),
            bgColor: const Color(0xFFFAF7F5),
            borderColor: const Color(0xFFEFE5DC),
          ),
          const SizedBox(height: 12.0),

          // Tap to Edit Button
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.mic, size: 14.0, color: Color(0xFF8C2E18)),
            label: const Text(
              'Tap to edit or add details with voice',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8C2E18),
              ),
            ),
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFFFFF8F5),
              side: const BorderSide(color: Color(0xFFE2D2C7)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryCardItem({
    required IconData icon,
    required String title,
    required String body,
    required Color accentColor,
    required Color bgColor,
    required Color borderColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16.0),
        border: Border(
          left: BorderSide(color: accentColor, width: 4.0),
          top: BorderSide(color: borderColor),
          right: BorderSide(color: borderColor),
          bottom: BorderSide(color: borderColor),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14.0, color: accentColor),
              const SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF221C19),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            body,
            style: const TextStyle(
              fontSize: 11.0,
              color: Color(0xFF523E34),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  // D. Where Your Story Appears Card
  Widget _buildWhereStoryAppearsCard() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDFB),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 4.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.storefront, size: 16.0, color: Color(0xFF8C2E18)),
              SizedBox(width: 8.0),
              Text(
                'Where Your Story Appears',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF221C19),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          _buildPlacementItem(
            icon: Icons.description_outlined,
            title: 'Attached to B2B Quotations',
            subtitle: 'Improves wholesale order acceptance by 68%',
            iconColor: const Color(0xFF8C2E18),
            iconBg: const Color(0xFFFDECE2),
          ),
          const SizedBox(height: 8.0),

          _buildPlacementItem(
            icon: Icons.local_offer_outlined,
            title: 'ONDC & Shilp Samagam Tags',
            subtitle: 'Printed on certified GI craft labels',
            iconColor: const Color(0xFF2E7D32),
            iconBg: const Color(0xFFE8F5E9),
          ),
          const SizedBox(height: 8.0),

          _buildPlacementItem(
            icon: Icons.qr_code_2,
            title: 'Digital Visiting Card (Screen 20)',
            subtitle: 'Instant QR code for buyer WhatsApp & trade fairs',
            iconColor: const Color(0xFFA84318),
            iconBg: const Color(0xFFFDF0E5),
          ),
        ],
      ),
    );
  }

  Widget _buildPlacementItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color iconBg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF8),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFF0E4DA)),
      ),
      child: Row(
        children: [
          Container(
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Icon(icon, color: iconColor, size: 16.0),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF221C19),
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Color(0xFF6B584E),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 3. Bottom Sticky Action Footer
  Widget _buildBottomActionFooter() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFDFB),
        border: Border(
          top: BorderSide(color: Color(0xFFEADFD6), width: 1.0),
        ),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Primary Button: Save & Publish Craft Story
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: widget.onSaveAndPublish ?? () {},
              icon: const SizedBox.shrink(),
              label: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Save & Publish Craft Story',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Icon(Icons.arrow_forward, size: 16.0, color: Colors.white),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8C2E18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                elevation: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 8.0),

          // Secondary Row
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: widget.onReTellVoice ?? () {},
                  icon: const Icon(Icons.mic, size: 14.0, color: Color(0xFF8C2E18)),
                  label: const Text(
                    'Re-Tell With Voice',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A3228),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFF5EE),
                    side: const BorderSide(color: Color(0xFFEADFD6)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: widget.onPreviewBuyerView ?? () {},
                  icon: const Icon(Icons.visibility_outlined, size: 14.0, color: Color(0xFF8C2E18)),
                  label: const Text(
                    'Preview Buyer View',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A3228),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFF5EE),
                    side: const BorderSide(color: Color(0xFFEADFD6)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
