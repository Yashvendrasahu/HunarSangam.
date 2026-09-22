// lib/screens/buyer_artisan_chat_screen.dart
// Production-grade Flutter screen matching 'bulk side - chat bulk buyer vs artisan.png'
// Real-time Bilingual Chat between Bulk Buyer & Master Artisan with Live Voice Translation, Trust Escrow, and Photo Proofs

import 'package:flutter/material.dart';
import '../models/chat_models.dart';
import '../services/chat_service.dart';
import '../services/hardware_service.dart';

class BuyerArtisanChatScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onViewSpecs;
  final VoidCallback? onViewOrder;
  final VoidCallback? onProductionUpdate;
  final VoidCallback? onSendPhoto;
  final VoidCallback? onViewReceipt;
  final VoidCallback? onDownloadReceipt;
  final VoidCallback? onOpenConversations;
  final String conversationId;
  final String artisanName;

  const BuyerArtisanChatScreen({
    super.key,
    this.onBack,
    this.onViewSpecs,
    this.onViewOrder,
    this.onProductionUpdate,
    this.onSendPhoto,
    this.onViewReceipt,
    this.onDownloadReceipt,
    this.onOpenConversations,
    this.conversationId = 'conv-heritage-ramu-1048',
    this.artisanName = 'Ramesh Kumar',
  });

  @override
  State<BuyerArtisanChatScreen> createState() => _BuyerArtisanChatScreenState();
}

class _BuyerArtisanChatScreenState extends State<BuyerArtisanChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ChatService _chatService = ChatService();
  bool _isPlayingVoice = false;
  bool _isListeningMic = false;
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();

    _chatService.getMessagesStream(widget.conversationId).listen((list) {
      if (mounted) {
        setState(() {
          _messages = list;
        });
        _scrollToBottom();
      }
    });

    _textController.addListener(() {
      setState(() {});
    });
  }

  Future<void> _handleMicVoiceInput() async {
    if (_isListeningMic) {
      await HardwareService().stopListening();
      if (mounted) setState(() => _isListeningMic = false);
      return;
    }

    setState(() => _isListeningMic = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🎙️ Recording voice note... Speak your message'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF9C3C18),
      ),
    );

    await HardwareService().startListening(
      onResult: (text, isFinal) {
        if (text.isNotEmpty) {
          _textController.text = text;
          if (isFinal) {
            if (mounted) setState(() => _isListeningMic = false);
            _sendMessage(text);
          }
        }
      },
      onStopped: () {
        if (mounted) setState(() => _isListeningMic = false);
      },
      onError: (err) {
        if (mounted) setState(() => _isListeningMic = false);
      },
    );
  }

  Future<void> _handleCameraCapture() async {
    final photo = await HardwareService().captureImageFromCamera();
    if (photo != null) {
      await _chatService.sendMessage(
        conversationId: widget.conversationId,
        senderType: 'buyer',
        senderName: 'Heritage Handcrafts',
        senderId: '11111111-1111-1111-1111-111111111111',
        content: '📷 [Photo Attached: ${photo.name}] Reference sample image shared.',
        orderId: 'REQ-HH-1048',
      );
      _scrollToBottom();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('📸 Photo sent to artisan!'),
            backgroundColor: Color(0xFF2E7D32),
          ),
        );
      }
    }
  }

  Future<void> _handlePlayVoiceNote(String text) async {
    if (_isPlayingVoice) {
      await HardwareService().stopAudio();
      if (mounted) setState(() => _isPlayingVoice = false);
      return;
    }

    setState(() => _isPlayingVoice = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🔊 Playing audio speech...'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF9C3C18),
      ),
    );

    await HardwareService().speakText(text);
    if (mounted) {
      setState(() => _isPlayingVoice = false);
    }
  }

  Future<void> _loadMessages() async {
    final msgs = await _chatService.fetchMessages(widget.conversationId, userRole: 'buyer');
    if (mounted) {
      setState(() {
        _messages = msgs;
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    _textController.clear();
    await _chatService.sendMessage(
      conversationId: widget.conversationId,
      senderType: 'buyer',
      senderName: 'Heritage Handcrafts',
      senderId: '11111111-1111-1111-1111-111111111111',
      content: trimmed,
      orderId: 'REQ-HH-1048',
    );
    _scrollToBottom();
  }

  void _handlePaymentAction() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFBECE2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.shield_outlined, color: Color(0xFF9C3C18), size: 24),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HunarSangam Trust Escrow',
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: Color(0xFF1F1612)),
                    ),
                    Text(
                      'Milestone 1 • Order #HS1048',
                      style: TextStyle(fontSize: 12, color: Color(0xFF7A6A60)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFCF9F6),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFEADBCE)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Escrow Amount to Release:', style: TextStyle(fontSize: 13, color: Color(0xFF7A6A60))),
                  Text('₹22,500', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Color(0xFF065F46))),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9C3C18),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pop(ctx);
                  if (widget.onViewOrder != null) {
                    widget.onViewOrder!();
                  }
                },
                child: const Text('View Order & Release Milestone Funds', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryRust = Color(0xFF9C3C18);
    const Color textDark = Color(0xFF1F1612);
    const Color textMuted = Color(0xFF7A6A60);
    const Color bgCanvas = Color(0xFFFCF9F6);

    return Scaffold(
      backgroundColor: bgCanvas,
      appBar: AppBar(
        backgroundColor: bgCanvas,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryRust),
          onPressed: widget.onBack ?? () => Navigator.of(context).maybePop(),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=120&q=80',
                    width: 38,
                    height: 38,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1.5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.check_circle, size: 12, color: Color(0xFF065F46)),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Ramesh Kumar',
                    style: TextStyle(
                      color: textDark,
                      fontWeight: FontWeight.w900,
                      fontSize: 14.5,
                    ),
                  ),
                  Text(
                    'Master Craftsman • Barpeta, Assam',
                    style: TextStyle(
                      color: textMuted,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFFBECE2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF0D5C3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'অসমীয়া',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: primaryRust),
                ),
                SizedBox(width: 3),
                Icon(Icons.swap_horiz, size: 14, color: primaryRust),
                SizedBox(width: 3),
                Text(
                  'En',
                  style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w900, color: primaryRust),
                ),
              ],
            ),
          ),
          if (widget.onOpenConversations != null)
            IconButton(
              icon: const Icon(Icons.forum_outlined, color: textDark, size: 20),
              tooltip: 'All Discussions',
              onPressed: widget.onOpenConversations,
            ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: textDark),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat Stream Messages
          Expanded(
            child: ListView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              children: [
                // 1. Timestamp Pill
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3EAE2),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.history_toggle_off, size: 13, color: textMuted),
                        SizedBox(width: 5),
                        Text(
                          'Order request sent • 17 Sep, 10:45 AM',
                          style: TextStyle(color: textMuted, fontSize: 10.5, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // 2. Order Accepted Banner Card
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFEADBCE)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x06000000),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFFD1FAE5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check, size: 14, color: Color(0xFF065F46)),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Order Accepted by Ramesh Kumar',
                                  style: TextStyle(
                                    color: textDark,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '500 pieces @ ₹380/pc • Target: 28 Oct 2026',
                                  style: TextStyle(color: textMuted, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 1, color: Color(0xFFF3E7DC)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Brahmaputra Cane Reserved',
                            style: TextStyle(color: Color(0xFF065F46), fontSize: 11, fontWeight: FontWeight.w700),
                          ),
                          GestureDetector(
                            onTap: widget.onViewSpecs ?? () {},
                            child: const Text(
                              'View Specs',
                              style: TextStyle(color: primaryRust, fontSize: 11, fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 3. Message 1: Artisan Audio & Live Translation
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7F2),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      border: Border.all(color: const Color(0xFFF5DFC9)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Audio Player Row
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() => _isPlayingVoice = !_isPlayingVoice);
                                if (_isPlayingVoice) {
                                  HardwareService().speakText(
                                    'Namaste, I have started the bamboo processing. Could you confirm the double rim design?',
                                    language: 'English',
                                    onDone: () {
                                      if (mounted) setState(() => _isPlayingVoice = false);
                                    },
                                  );
                                } else {
                                  HardwareService().stopAudio();
                                }
                              },
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: const BoxDecoration(
                                  color: primaryRust,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _isPlayingVoice ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: List.generate(
                                  18,
                                  (index) => Container(
                                    width: 3,
                                    height: (index % 3 == 0) ? 22 : (index % 2 == 0 ? 14 : 8),
                                    decoration: BoxDecoration(
                                      color: index < 8 ? primaryRust : const Color(0xFFDFCCC0),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              '0:24',
                              style: TextStyle(color: textMuted, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Translation Box
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFEADBCE)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(Icons.translate, size: 13, color: primaryRust),
                                      SizedBox(width: 4),
                                      Text(
                                        'Live Translation (Assamese → English)',
                                        style: TextStyle(color: primaryRust, fontSize: 10.5, fontWeight: FontWeight.w800),
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () => _handlePlayVoiceNote(
                                      'Namaste, I have started the bamboo processing. Could you confirm the double rim design?',
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(_isPlayingVoice ? Icons.stop_circle_outlined : Icons.volume_up_outlined, size: 14, color: primaryRust),
                                        const SizedBox(width: 3),
                                        Text(
                                          _isPlayingVoice ? 'Stop' : 'Listen',
                                          style: const TextStyle(color: primaryRust, fontSize: 10.5, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                '"Namaste, I have started the bamboo processing. Could you confirm the double-rim design?"',
                                style: TextStyle(
                                  color: textDark,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  height: 1.35,
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Original: নমস্কাৰ, মই বাঁহৰ কাম আৰম্ভ কৰিছোঁ। আপুনি ডাবল-ৰিম ডিজাইনটো নিশ্চিত কৰিবনে?',
                                style: TextStyle(
                                  color: textMuted,
                                  fontSize: 10.5,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, top: 4),
                  child: const Text(
                    '11:28 AM • Translated',
                    style: TextStyle(color: textMuted, fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 14),

                // 4. Message 2: Buyer Reply (Rust Bubble)
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: primaryRust,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(4),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Yes Ramesh ji! Please use the double-rim weaving as in our reference sample. Looking forward to initial bamboo seasoning photos.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6, top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        '11:35 AM • ',
                        style: TextStyle(color: textMuted, fontSize: 10, fontWeight: FontWeight.w500),
                      ),
                      Icon(Icons.done_all, size: 12, color: Color(0xFF065F46)),
                      SizedBox(width: 2),
                      Text(
                        'Read',
                        style: TextStyle(color: Color(0xFF065F46), fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 5. Message 3: Artisan Photo Card
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.82,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFEADBCE)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Image.network(
                              'https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=600&q=80',
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.75),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.verified, size: 12, color: Colors.white),
                                    SizedBox(width: 4),
                                    Text(
                                      'GI Certified Cane',
                                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: const [
                              Icon(Icons.camera_alt_outlined, size: 14, color: primaryRust),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  'Seasoned Brahmaputra cane ready for weaving',
                                  style: TextStyle(
                                    color: textDark,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6, top: 4),
                  child: const Text(
                    '12:10 PM',
                    style: TextStyle(color: textMuted, fontSize: 10, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 14),

                // 6. Message 4: Payment Completed / Trust Escrow Card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6FBF8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFD1E7DD)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF065F46),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check, size: 13, color: Colors.white),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'PAYMENT COMPLETED',
                                    style: TextStyle(color: Color(0xFF065F46), fontSize: 9.5, fontWeight: FontWeight.w900, letterSpacing: 0.5),
                                  ),
                                  Text(
                                    '₹1,90,000 paid to Craft\nTrust Escrow',
                                    style: TextStyle(color: textDark, fontWeight: FontWeight.w900, fontSize: 13.5, height: 1.2),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD1FAE5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.shield_outlined, size: 12, color: Color(0xFF065F46)),
                                SizedBox(width: 3),
                                Text(
                                  'Escrow\nProtected',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Color(0xFF065F46), fontSize: 9.5, fontWeight: FontWeight.bold, height: 1.1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1, color: Color(0xFFDCEFE6)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Craft Order Breakdown', style: TextStyle(color: textMuted, fontSize: 10)),
                                SizedBox(height: 2),
                                Text('500 pcs', style: TextStyle(color: primaryRust, fontWeight: FontWeight.w900, fontSize: 13)),
                                Text('@ ₹380 / piece (#HS-BKT-892)', style: TextStyle(color: textMuted, fontSize: 9.5)),
                              ],
                            ),
                          ),
                          Container(width: 1, height: 35, color: const Color(0xFFDCEFE6)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Transaction Details', style: TextStyle(color: textMuted, fontSize: 10)),
                                SizedBox(height: 2),
                                Text('#TXN-HS-99214', style: TextStyle(color: textDark, fontWeight: FontWeight.w900, fontSize: 12)),
                                Text('17 Sep, 11:40 AM • UPI Verified', style: TextStyle(color: Color(0xFF065F46), fontSize: 9.5, fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: widget.onViewReceipt ?? () {},
                              icon: const Icon(Icons.receipt_outlined, size: 14),
                              label: const Text('View Receipt', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: textDark,
                                side: const BorderSide(color: Color(0xFFDCC8BB)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: widget.onDownloadReceipt ?? () {},
                              icon: const Icon(Icons.download_outlined, size: 14),
                              label: const Text('Download Receipt', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: primaryRust,
                                side: const BorderSide(color: Color(0xFFF0D5C3)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // Dynamic messages loaded from Supabase
                ..._messages.skip(2).map((msg) {
                  final isMe = msg.isBuyer;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                        decoration: BoxDecoration(
                          color: isMe ? primaryRust : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: isMe ? null : Border.all(color: const Color(0xFFEADBCE)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              msg.content,
                              style: TextStyle(
                                color: isMe ? Colors.white : textDark,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (msg.translatedContent != null && msg.translatedContent!.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '🌐 ${msg.translatedContent}',
                                      style: TextStyle(
                                        color: isMe ? const Color(0xFFFFD4C2) : primaryRust,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => _handlePlayVoiceNote(msg.translatedContent ?? msg.content),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 4),
                                      child: Icon(
                                        Icons.volume_up_outlined,
                                        size: 13,
                                        color: isMe ? Colors.white70 : primaryRust,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 2),
                            Text(
                              msg.time,
                              style: TextStyle(
                                color: isMe ? Colors.white70 : textMuted,
                                fontSize: 9,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Quick Action Chips Row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            color: bgCanvas,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildQuickActionChip(
                    icon: Icons.receipt_long_outlined,
                    label: 'View Order',
                    onTap: widget.onViewOrder ?? () {},
                  ),
                  const SizedBox(width: 8),
                  _buildQuickActionChip(
                    icon: Icons.assignment_turned_in_outlined,
                    label: 'Production Update',
                    onTap: widget.onProductionUpdate ?? () {},
                  ),
                  const SizedBox(width: 8),
                  _buildQuickActionChip(
                    icon: Icons.camera_alt_outlined,
                    label: 'Send Photo',
                    onTap: widget.onSendPhoto ?? () {},
                  ),
                ],
              ),
            ),
          ),

          // Bottom Chat Input Bar
          Container(
            padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFEFE5DC))),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF2EB),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.add, color: primaryRust, size: 20),
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F4F0),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: const Color(0xFFEADBCE)),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _textController,
                                decoration: const InputDecoration(
                                  hintText: 'Type or tap mic for bilingu...',
                                  hintStyle: TextStyle(color: textMuted, fontSize: 12),
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onSubmitted: (val) => _sendMessage(val),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.currency_rupee, size: 16, color: primaryRust),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              tooltip: 'Trust Escrow & Payment',
                              onPressed: _handlePaymentAction,
                            ),
                            const SizedBox(width: 6),
                            IconButton(
                              icon: const Icon(Icons.camera_alt_outlined, size: 17, color: textMuted),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              tooltip: 'Take Photo with Camera',
                              onPressed: _handleCameraCapture,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: _isListeningMic ? Colors.red : primaryRust,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          _textController.text.trim().isNotEmpty
                              ? Icons.send
                              : (_isListeningMic ? Icons.mic_off : Icons.mic),
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          if (_textController.text.trim().isNotEmpty) {
                            _sendMessage(_textController.text);
                          } else {
                            _handleMicVoiceInput();
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.graphic_eq, size: 12, color: Color(0xFF065F46)),
                    SizedBox(width: 4),
                    Text(
                      'Speaks Hindi, English, & Assamese with auto-transcription',
                      style: TextStyle(color: textMuted, fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEADBCE)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: const Color(0xFF9C3C18)),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(color: Color(0xFF1F1612), fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
