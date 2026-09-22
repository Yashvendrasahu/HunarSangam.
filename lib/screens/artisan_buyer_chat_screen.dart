// lib/screens/artisan_buyer_chat_screen.dart

import 'package:flutter/material.dart';
import '../models/chat_models.dart';
import '../services/chat_service.dart';
import '../services/hardware_service.dart';

class ArtisanBuyerChatScreen extends StatefulWidget {
  final String conversationId;
  final String buyerName;
  final String orderId;
  final String orderTitle;
  final String escrowAmount;
  final String deliveryDate;
  final VoidCallback onBack;
  final VoidCallback? onEscrowTap;

  const ArtisanBuyerChatScreen({
    super.key,
    required this.conversationId,
    this.buyerName = 'FabIndia Retail Ltd.',
    this.orderId = 'PO-2026-8891',
    this.orderTitle = 'Handcrafted Bamboo Fruit Baskets (50 pcs)',
    this.escrowAmount = '₹5,600',
    this.deliveryDate = '28 Mar 2026',
    required this.onBack,
    this.onEscrowTap,
  });

  @override
  State<ArtisanBuyerChatScreen> createState() => _ArtisanBuyerChatScreenState();
}

class _ArtisanBuyerChatScreenState extends State<ArtisanBuyerChatScreen> {
  final TextEditingController _msgController = TextEditingController();
  final ChatService _chatService = ChatService();
  List<ChatMessage> _messages = [];
  bool _isListening = false;
  String? _currentlySpeakingMsgId;

  @override
  void initState() {
    super.initState();
    _loadMessages();

    _chatService.getMessagesStream(widget.conversationId).listen((list) {
      if (mounted) {
        setState(() {
          _messages = list;
        });
      }
    });
  }

  void _loadMessages() async {
    final msgs = await _chatService.fetchMessages(widget.conversationId, userRole: 'artisan');
    if (mounted) {
      setState(() {
        _messages = msgs;
      });
    }
  }

  void _sendTextMessage() async {
    final text = _msgController.text.trim();
    if (text.isEmpty) return;
    _msgController.clear();

    await _chatService.sendMessage(
      conversationId: widget.conversationId,
      senderType: 'artisan',
      senderName: 'Artisan Ramu',
      senderId: 'artisan_1',
      content: text,
      orderId: widget.orderId,
    );
    _loadMessages();
  }

  Future<void> _handleCameraCapture() async {
    final photo = await HardwareService().captureImageFromCamera();
    if (photo != null) {
      await _chatService.sendMessage(
        conversationId: widget.conversationId,
        senderType: 'artisan',
        senderName: 'Artisan Ramu',
        senderId: 'artisan_1',
        content: '📷 [Craft Proof Photo: ${photo.name}] Batch progress updated.',
        orderId: widget.orderId,
      );
      _loadMessages();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('📸 Craft photo sent to buyer!'),
            backgroundColor: Color(0xFF2E7D32),
          ),
        );
      }
    }
  }

  Future<void> _handleMicVoiceInput() async {
    if (_isListening) {
      await HardwareService().stopListening();
      if (mounted) setState(() => _isListening = false);
      return;
    }

    setState(() => _isListening = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🎙️ Boliyee... Recording in Hindi / Regional language'),
        backgroundColor: Color(0xFFA84318),
        duration: Duration(seconds: 2),
      ),
    );

    await HardwareService().startListening(
      language: 'hi_IN',
      onResult: (text, isFinal) {
        if (text.isNotEmpty) {
          _msgController.text = text;
          if (isFinal) {
            if (mounted) setState(() => _isListening = false);
            _sendTextMessage();
          }
        }
      },
      onStopped: () {
        if (mounted) setState(() => _isListening = false);
      },
      onError: (err) {
        if (mounted) setState(() => _isListening = false);
      },
    );
  }

  void _speakMessage(ChatMessage msg) {
    if (_currentlySpeakingMsgId == msg.id) {
      HardwareService().stopAudio();
      setState(() => _currentlySpeakingMsgId = null);
      return;
    }

    setState(() => _currentlySpeakingMsgId = msg.id);
    HardwareService().speakText(
      msg.translatedContent ?? msg.content,
      language: 'Hindi',
      onDone: () {
        if (mounted) setState(() => _currentlySpeakingMsgId = null);
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.buyerName,
              style: const TextStyle(color: Color(0xFF2D2421), fontSize: 15, fontWeight: FontWeight.w800),
            ),
            Text(
              '${widget.orderId} • Live Auto-Translate Active',
              style: const TextStyle(color: Color(0xFF2E7D32), fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Escrow status bar
          InkWell(
            onTap: widget.onEscrowTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: const Color(0xFFFDECE8),
              child: Row(
                children: [
                  const Icon(Icons.lock_clock_outlined, color: Color(0xFFA84318), size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Escrow Advance Locked: ${widget.escrowAmount} • Dispatch by ${widget.deliveryDate}',
                      style: const TextStyle(color: Color(0xFFA84318), fontSize: 11.5, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Chat Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (ctx, idx) {
                final msg = _messages[idx];
                final isMe = msg.isMe;

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
                    decoration: BoxDecoration(
                      color: isMe ? const Color(0xFFA84318) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: isMe ? null : Border.all(color: const Color(0xFFEADFD6)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Text(
                                msg.content,
                                style: TextStyle(
                                  color: isMe ? Colors.white : const Color(0xFF2D2421),
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                _currentlySpeakingMsgId == msg.id ? Icons.stop_circle : Icons.volume_up_outlined,
                                size: 16,
                                color: isMe ? Colors.white70 : const Color(0xFFA84318),
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              tooltip: 'Listen aloud',
                              onPressed: () => _speakMessage(msg),
                            ),
                          ],
                        ),
                        if (msg.translatedContent != null && msg.translatedContent!.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            '🌐 ${msg.translatedContent}',
                            style: TextStyle(
                              color: isMe ? const Color(0xFFFFD4C2) : const Color(0xFFA84318),
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: _isListening ? Colors.red : const Color(0xFFA84318),
                    ),
                    tooltip: 'Speak in voice',
                    onPressed: _handleMicVoiceInput,
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined, color: Color(0xFF7A6A60)),
                    tooltip: 'Take Photo of Craft',
                    onPressed: _handleCameraCapture,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _msgController,
                      decoration: InputDecoration(
                        hintText: 'Type reply (auto-translated)...',
                        hintStyle: const TextStyle(fontSize: 13, color: Color(0xFF8D6E63)),
                        filled: true,
                        fillColor: const Color(0xFFFAF6F2),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      ),
                      onSubmitted: (_) => _sendTextMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Color(0xFFA84318)),
                    onPressed: _sendTextMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
