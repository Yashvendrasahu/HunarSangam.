// lib/screens/artisan_chat_screen.dart
// Production-grade Flutter screen matching 'artisan vs artisan chat.png'
// Artisan-to-Artisan Collaboration Chat with Audio Messages, Live Vernacular Translation, and Production Update Logs

import 'package:flutter/material.dart';
import '../models/onboarding_state.dart';

/// Screen 28: Artisan-to-Artisan Collaboration Chat
/// 100% matching the UI design in 'artisan vs artisan chat.png'
class ArtisanChatScreen extends StatefulWidget {
  final OnboardingState? state;
  final VoidCallback? onBack;
  final VoidCallback? onOpenWorkspace;
  final VoidCallback? onCallArtisan;

  const ArtisanChatScreen({
    super.key,
    this.state,
    this.onBack,
    this.onOpenWorkspace,
    this.onCallArtisan,
  });

  @override
  State<ArtisanChatScreen> createState() => _ArtisanChatScreenState();
}

class _ArtisanChatScreenState extends State<ArtisanChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String _currentLanguageMode = 'हिंदी / En';
  bool _isPlayingAudioMessage = false;
  bool _isPlayingTranslationAudio = false;
  bool _isRecordingVoice = false;
  bool _isProductionVerified = false;

  // Design Tokens
  static const Color _terracotta = Color(0xFF8C3A16);
  static const Color _terracottaDark = Color(0xFF702E11);
  static const Color _terracottaLight = Color(0xFFFAF0E8);
  static const Color _bgScreen = Color(0xFFFDFBF9);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6D4C41);
  static const Color _textSubtle = Color(0xFF8D6E63);
  static const Color _borderSubtle = Color(0xFFEADFD6);
  static const Color _greenPrimary = Color(0xFF1B7339);
  static const Color _greenBg = Color(0xFFDFF4E5);
  static const Color _greenBorder = Color(0xFFBEE5CB);

  final List<Map<String, dynamic>> _messages = [
    {
      'type': 'incoming_audio',
      'sender': 'Ramesh Kumar',
      'time': '09:42 AM',
      'text': 'Main 20 pieces ka kaam kal se start kar raha hoon.',
      'audioDuration': '0:18',
    },
    {
      'type': 'outgoing_text',
      'time': '09:45 AM',
      'text': 'Okay. Deadline 28 September hai.',
      'isRead': true,
    },
    {
      'type': 'incoming_translation',
      'sender': 'Ramesh Kumar',
      'time': '10:15 AM',
      'originalHindi': 'Kal 10 pieces ready ho jayenge.',
      'translatedEnglish': '10 pieces will be ready tomorrow.',
    },
    {
      'type': 'incoming_text',
      'sender': 'Ramesh Kumar',
      'time': '10:18 AM',
      'text': 'Thik hai, time par complete kar dunga.',
    },
    {
      'type': 'production_update',
      'title': 'Production Update',
      'progress': '12 / 20 pieces',
      'photoUrl': 'https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=800&q=80',
      'locationTag': '11:20 AM Workshop Floor',
      'description': '12 tokiyan ka base ban gaya hai, weaving complete ho chuki hai.',
      'verified': false,
    }
  ];

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2E2420),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _sendMessage([String? presetText]) {
    final text = presetText ?? _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'type': 'outgoing_text',
        'time': 'Just now',
        'text': text,
        'isRead': true,
      });
      _messageController.clear();
    });

    _showSnack('Sent: "$text"');

    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgScreen,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top App Bar with Artisan Avatar, Language, Call & 3-Dots
            _buildTopAppBar(),

            // 2. Shared Order Workspace Header Banner
            _buildSharedOrderBanner(),

            // 3. Main Chat Timeline Scroll Area
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  children: [
                    // Date Divider
                    _buildDateDivider('Today, 24 September'),

                    const SizedBox(height: 14.0),

                    // Message 1: Incoming with Voice Player
                    _buildIncomingVoiceMessage(
                      sender: 'Ramesh Kumar',
                      time: '09:42 AM',
                      text: 'Main 20 pieces ka kaam kal se start kar raha hoon.',
                      duration: '0:18',
                    ),

                    const SizedBox(height: 14.0),

                    // Message 2: Outgoing text message
                    _buildOutgoingMessage(
                      text: 'Okay. Deadline 28 September hai.',
                      time: '09:45 AM',
                    ),

                    const SizedBox(height: 14.0),

                    // Message 3: Incoming message with Vernacular Translation Box
                    _buildVernacularTranslationMessage(
                      sender: 'Ramesh Kumar',
                      time: '10:15 AM',
                      originalHindi: 'Kal 10 pieces ready ho jayenge.',
                      translatedEnglish: '10 pieces will be ready tomorrow.',
                    ),

                    const SizedBox(height: 14.0),

                    // Message 4: Incoming simple text message
                    _buildIncomingSimpleText(
                      text: 'Thik hai, time par complete kar dunga.',
                      time: '10:18 AM',
                    ),

                    const SizedBox(height: 14.0),

                    // Message 5: Production Update Card with image and verification CTA
                    _buildProductionUpdateCard(
                      progress: '12 / 20 pieces',
                      locationTime: '11:20 AM Workshop Floor',
                      description: '12 tokiyan ka base ban gaya hai, weaving complete ho chuki hai.',
                    ),

                    // Dynamic extra messages if any
                    ..._messages.skip(5).map((m) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: _buildOutgoingMessage(
                          text: m['text'] as String,
                          time: m['time'] as String,
                        ),
                      );
                    }),

                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            ),

            // 4. Quick Suggestion Pills Row
            _buildQuickRepliesRow(),

            // 5. Input Bar & Voice Mic
            _buildChatInputBar(),

            // 6. Voice instructions subtext
            _buildBottomVoiceSubtext(),
          ],
        ),
      ),
    );
  }

  // 1. TOP APP BAR
  Widget _buildTopAppBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF0E5DC), width: 1.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Back button + Avatar + Name
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: _textDark, size: 22),
                onPressed: widget.onBack ?? () => Navigator.maybePop(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),

              // Avatar with Online indicator
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=150&q=80',
                      width: 38,
                      height: 38,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 38,
                        height: 38,
                        color: _terracotta,
                        child: const Icon(Icons.person, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: _greenPrimary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),

              // Name and status
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Ramesh Kumar',
                    style: TextStyle(
                      color: _textDark,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 1),
                  Text(
                    '🟢 Collaboration...',
                    style: TextStyle(
                      color: _greenPrimary,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Right: Language Switcher, Phone, 3-dots
          Row(
            children: [
              // Language pill
              InkWell(
                onTap: () {
                  setState(() {
                    _currentLanguageMode = _currentLanguageMode == 'हिंदी / En' ? 'অসমীয়া / En' : 'हिंदी / En';
                  });
                  _showSnack('Translation mode set to $_currentLanguageMode');
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9EFE7),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFEADBCE)),
                  ),
                  child: Text(
                    _currentLanguageMode,
                    style: const TextStyle(
                      color: _textDark,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),

              // Call Button
              IconButton(
                icon: const Icon(Icons.phone_outlined, color: _terracotta, size: 20),
                onPressed: widget.onCallArtisan ??
                    () => _showSnack('📞 Dialing Ramesh Kumar (+91 98765 43210)...'),
                padding: const EdgeInsets.all(6),
                constraints: const BoxConstraints(),
              ),

              // 3-dots menu
              IconButton(
                icon: const Icon(Icons.more_vert, color: _textDark, size: 20),
                onPressed: () => _showSnack('Options: View profile, Clear chat, Escrow terms'),
                padding: const EdgeInsets.all(6),
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 2. SHARED ORDER BANNER
  Widget _buildSharedOrderBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 10, 12, 4),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9F4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0DDD0)),
        boxShadow: const [
          BoxShadow(color: Color(0x06000000), blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Image + Order info + Due date badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=200&q=80',
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'SHARED ORDER #BSK-408',
                      style: TextStyle(
                        color: _terracotta,
                        fontSize: 10.0,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 1),
                    Text(
                      'Bamboo Handwoven',
                      style: TextStyle(
                        color: _textDark,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _greenBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _greenBorder),
                ),
                child: const Text(
                  'Due 28 Sep',
                  style: TextStyle(
                    color: _greenPrimary,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Row 2: Progress Numbers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text.rich(
                TextSpan(
                  text: 'Overall Progress: ',
                  style: TextStyle(color: _textMuted, fontSize: 11.0, fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                      text: '30 / 50 pcs',
                      style: TextStyle(color: _textDark, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
              Text(
                'Your quota: 20 pcs',
                style: TextStyle(
                  color: _terracotta,
                  fontSize: 11.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Row 3: Segmented Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: SizedBox(
              height: 7,
              child: Row(
                children: [
                  Expanded(
                    flex: 20, // Ramesh 20 ready
                    child: Container(color: const Color(0xFF388E3C)),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    flex: 10, // You 10 ready
                    child: Container(color: const Color(0xFFD35400)),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    flex: 20, // 10 remaining
                    child: Container(color: const Color(0xFFE2D6CD)),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 6),

          // Row 4: Progress Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '🟢 Ramesh: 20 ready',
                style: TextStyle(color: _textMuted, fontSize: 10.0, fontWeight: FontWeight.w600),
              ),
              Text(
                '🟠 You: 10 ready',
                style: TextStyle(color: _textMuted, fontSize: 10.0, fontWeight: FontWeight.w600),
              ),
              Text(
                '10 Remaining',
                style: TextStyle(color: _textSubtle, fontSize: 10.0, fontWeight: FontWeight.w500),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Row 5: View Collaboration Workspace CTA
          InkWell(
            onTap: widget.onOpenWorkspace ??
                () => _showSnack('Opening Collaboration Workspace for #BSK-408...'),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFEADFD6)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.handshake_outlined, size: 16, color: _terracotta),
                  SizedBox(width: 6),
                  Text(
                    'View Collaboration Workspace',
                    style: TextStyle(
                      color: _terracotta,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 16, color: _terracotta),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 3. DATE DIVIDER
  Widget _buildDateDivider(String label) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFF5ECE4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Color(0xFF6B584E),
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  // 4A. INCOMING VOICE MESSAGE
  Widget _buildIncomingVoiceMessage({
    required String sender,
    required String time,
    required String text,
    required String duration,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
          child: Text(
            '$sender  $time',
            style: const TextStyle(color: _textSubtle, fontSize: 10.5, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 310),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8F3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFF3E3D7)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: _textDark,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),

              // Voice Player Bar with Waveforms
              InkWell(
                onTap: () {
                  setState(() => _isPlayingAudioMessage = !_isPlayingAudioMessage);
                  _showSnack(_isPlayingAudioMessage
                      ? '🔊 Playing voice message from Ramesh (0:18s)...'
                      : 'Voice paused');
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFEFE2D8)),
                  ),
                  child: Row(
                    children: [
                      // Play Button Circle
                      Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: _terracotta,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isPlayingAudioMessage ? Icons.pause : Icons.play_arrow,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 8),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.mic, size: 12, color: _terracotta),
                              const SizedBox(width: 3),
                              Text(
                                'Voice Message',
                                style: TextStyle(
                                  color: _terracotta,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                '  0:$duration',
                                style: const TextStyle(
                                  color: _textDark,
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          // Simulated Waveform Bars
                          Row(
                            children: List.generate(18, (index) {
                              final heights = [6, 12, 16, 10, 18, 14, 8, 15, 12, 6, 14, 18, 10, 6, 12, 8, 5, 10];
                              final isPlayed = _isPlayingAudioMessage && index < 8;
                              return Container(
                                width: 2.5,
                                height: heights[index % heights.length].toDouble(),
                                margin: const EdgeInsets.symmetric(horizontal: 1.2),
                                decoration: BoxDecoration(
                                  color: isPlayed ? _terracotta : const Color(0xFFC7B6AB),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 4B. OUTGOING TEXT MESSAGE (TERRACOTTA BUBBLE)
  Widget _buildOutgoingMessage({required String text, required String time}) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 290),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: _terracotta,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(4),
          ),
          boxShadow: const [
            BoxShadow(color: Color(0x12000000), blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    color: Color(0xFFEADFD6),
                    fontSize: 9.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.done_all, color: Color(0xFFB9F6CA), size: 13),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 4C. INCOMING MESSAGE WITH VERNACULAR LIVE TRANSLATION
  Widget _buildVernacularTranslationMessage({
    required String sender,
    required String time,
    required String originalHindi,
    required String translatedEnglish,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 4.0),
          child: Text(
            '$sender  $time',
            style: const TextStyle(color: _textSubtle, fontSize: 10.5, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          constraints: const BoxConstraints(maxWidth: 320),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8F3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFF3E3D7)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Original text header
              const Text(
                'Original (Hindi)',
                style: TextStyle(
                  color: _textSubtle,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '"$originalHindi"',
                style: const TextStyle(
                  color: _textDark,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 8),

              // AI Translation Box with Green Border Accent
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6EFEA),
                  borderRadius: BorderRadius.circular(12),
                  border: const Border(
                    left: BorderSide(color: _greenPrimary, width: 3.5),
                    top: BorderSide(color: Color(0xFFEADED6)),
                    right: BorderSide(color: Color(0xFFEADED6)),
                    bottom: BorderSide(color: Color(0xFFEADED6)),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.translate, size: 13, color: _greenPrimary),
                        const SizedBox(width: 4),
                        const Text(
                          'Vernacular Translation',
                          style: TextStyle(
                            color: _greenPrimary,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: _greenBg,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Instant',
                            style: TextStyle(
                              color: _greenPrimary,
                              fontSize: 9.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '"$translatedEnglish"',
                      style: const TextStyle(
                        color: _textDark,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Play Audio Translation Trigger
                    InkWell(
                      onTap: () {
                        setState(() => _isPlayingTranslationAudio = !_isPlayingTranslationAudio);
                        _showSnack(_isPlayingTranslationAudio
                            ? '🔊 Playing translated voice output in English...'
                            : 'Translation voice paused');
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFEADBCE)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.volume_up, size: 13, color: _terracotta),
                            SizedBox(width: 4),
                            Text(
                              'Play Translation (|||||)',
                              style: TextStyle(
                                color: _terracotta,
                                fontSize: 10.5,
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
            ],
          ),
        ),
      ],
    );
  }

  // 4D. INCOMING SIMPLE TEXT
  Widget _buildIncomingSimpleText({required String text, required String time}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 290),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF8F3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF3E3D7)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: _textDark,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                time,
                style: const TextStyle(color: _textSubtle, fontSize: 9.5, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 4E. PRODUCTION UPDATE CARD
  Widget _buildProductionUpdateCard({
    required String progress,
    required String locationTime,
    required String description,
  }) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 320),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8F3),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF3E3D7)),
        boxShadow: const [
          BoxShadow(color: Color(0x08000000), blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Production Update pill + Progress
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _greenBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: _greenBorder),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.camera_alt_outlined, size: 12, color: _greenPrimary),
                    SizedBox(width: 4),
                    Text(
                      'Production Update',
                      style: TextStyle(
                        color: _greenPrimary,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                progress,
                style: const TextStyle(
                  color: _textDark,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Workshop Floor Photo with timestamp pill overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=800&q=80',
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.schedule, size: 11, color: Colors.white),
                      const SizedBox(width: 4),
                      Text(
                        locationTime,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Description Text
          Text(
            description,
            style: const TextStyle(
              color: _textDark,
              fontSize: 12.0,
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),

          const SizedBox(height: 10),

          // Verify & Log Update Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                setState(() => _isProductionVerified = true);
                _showSnack('🎉 Update verified! 12/20 pieces logged to escrow ledger.');
              },
              icon: Icon(
                _isProductionVerified ? Icons.verified : Icons.verified_user_outlined,
                size: 15,
                color: Colors.white,
              ),
              label: Text(
                _isProductionVerified ? 'Verified & Logged ✓' : 'Verify & Log Update',
                style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w800),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isProductionVerified ? _greenPrimary : _terracotta,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 5. QUICK SUGGESTION CHIPS ROW
  Widget _buildQuickRepliesRow() {
    final suggestions = [
      {'icon': '✓', 'text': 'Okay'},
      {'icon': '🔨', 'text': 'Start the work'},
      {'icon': '📷', 'text': 'Send update'},
      {'icon': '🤝', 'text': 'Escrow milestone'},
    ];

    return Container(
      height: 36,
      margin: const EdgeInsets.only(bottom: 6.0),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        itemCount: suggestions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = suggestions[index];
          return InkWell(
            onTap: () => _sendMessage(item['text']),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF9EFE7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEADBCE)),
              ),
              child: Row(
                children: [
                  Text(item['icon']!, style: const TextStyle(fontSize: 11)),
                  const SizedBox(width: 4),
                  Text(
                    item['text']!,
                    style: const TextStyle(
                      color: _textDark,
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // 6. INPUT BAR & RECORDING MIC
  Widget _buildChatInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      color: _bgScreen,
      child: Row(
        children: [
          // Plus button
          InkWell(
            onTap: () => _showSnack('📎 Share spec PDF, audio sample, or milestone breakdown'),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF5ECE4),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFEADFD6)),
              ),
              child: const Icon(Icons.add, color: _textDark, size: 20),
            ),
          ),
          const SizedBox(width: 6),

          // Camera button
          InkWell(
            onTap: () => _showSnack('📷 Opening camera to capture craft production photo...'),
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFDFF4E5),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFBEE5CB)),
              ),
              child: const Icon(Icons.camera_alt_outlined, color: _greenPrimary, size: 18),
            ),
          ),
          const SizedBox(width: 8),

          // Text Field
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE0D2C7)),
              ),
              child: TextField(
                controller: _messageController,
                onSubmitted: (_) => _sendMessage(),
                style: const TextStyle(fontSize: 12.5, color: _textDark),
                decoration: const InputDecoration(
                  hintText: 'Type message or hold mic...',
                  hintStyle: TextStyle(color: Color(0xFF9E8B80), fontSize: 11.5),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Terracotta Voice Mic Button
          GestureDetector(
            onLongPressStart: (_) {
              setState(() => _isRecordingVoice = true);
              _showSnack('🎙️ Recording voice note in Hindi / Assamese... Release to send');
            },
            onLongPressEnd: (_) {
              setState(() => _isRecordingVoice = false);
              _sendMessage('🎤 [Audio message sent: 0:12s]');
            },
            onTap: () {
              if (_messageController.text.trim().isNotEmpty) {
                _sendMessage();
              } else {
                _showSnack('🎙️ Hold the mic button to record a voice note');
              }
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: _isRecordingVoice ? Colors.red : _terracotta,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(color: Color(0x228C3A16), blurRadius: 6, offset: Offset(0, 2)),
                ],
              ),
              child: Icon(
                _messageController.text.trim().isNotEmpty ? Icons.send : Icons.mic,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 7. BOTTOM VOICE SUBTEXT
  Widget _buildBottomVoiceSubtext() {
    return Container(
      color: _bgScreen,
      padding: const EdgeInsets.only(left: 14.0, right: 14.0, bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: _terracotta,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            'Hold Mic: ',
            style: TextStyle(color: _terracotta, fontSize: 10.0, fontWeight: FontWeight.w800),
          ),
          const Text(
            'Bol kar sandesh bhejein  ',
            style: TextStyle(color: _textDark, fontSize: 10.0, fontWeight: FontWeight.w600),
          ),
          const Expanded(
            child: Text(
              'Hindi, Assamese, Gujarati audio auto-translated',
              style: TextStyle(color: _textSubtle, fontSize: 9.5, overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}
