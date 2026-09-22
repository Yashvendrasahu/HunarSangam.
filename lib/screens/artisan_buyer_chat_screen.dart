// lib/screens/artisan_buyer_chat_screen.dart

import 'package:flutter/material.dart';
import '../services/hardware_service.dart';

/// Screen matching 'artisan vs bulk buyer chat.png'
/// Artisan vs B2B Bulk Buyer Chat with real-time audio note, translation, and production update card
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
    this.buyerName = 'Heritage Handcrafts',
    this.orderId = '#HS1048',
    this.orderTitle = 'Bamboo Handwoven Basket',
    this.escrowAmount = '₹22,500',
    this.deliveryDate = '28 September 2026',
    required this.onBack,
    this.onEscrowTap,
  });

  @override
  State<ArtisanBuyerChatScreen> createState() => _ArtisanBuyerChatScreenState();
}

class _ArtisanBuyerChatScreenState extends State<ArtisanBuyerChatScreen> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isPlayingAudio = false;
  bool _isRecording = false;

  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFDFBF9);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgCanvas,
      appBar: _buildTopAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            // Order Sticky Header
            _buildOrderHeaderBanner(),

            // Chat Messages List
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                children: [
                  // Date separator
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0E5DC),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Text(
                        'Today, 24 September',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _textMuted),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14.0),

                  // Buyer Message 1
                  _buildBuyerMessage1(),
                  const SizedBox(height: 14.0),

                  // Artisan Voice Message 1
                  _buildArtisanVoiceMessage(),
                  const SizedBox(height: 14.0),

                  // Buyer Message 2
                  _buildBuyerMessage2(),
                  const SizedBox(height: 14.0),

                  // Artisan Production Update Card
                  _buildArtisanProductionUpdateMessage(),
                  const SizedBox(height: 14.0),
                ],
              ),
            ),

            // Quick Reply Chips
            _buildQuickReplyChips(),

            // Chat Input Row
            _buildInputRow(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildTopAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: _textDark),
        onPressed: widget.onBack,
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFF3EAE3),
                child: const Text(
                  'HH',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: _primaryRust),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF2E7D32),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Heritage Handcrafts',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: _textDark),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: const [
                    Text('B2B Buyer • New Delhi • ', style: TextStyle(fontSize: 10.5, color: _textMuted)),
                    Icon(Icons.circle, size: 5, color: Color(0xFF2E7D32)),
                    SizedBox(width: 2.0),
                    Text('Online', style: TextStyle(fontSize: 10.5, color: Color(0xFF2E7D32), fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 13.0),
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFDFBF9),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: const Color(0xFFE5D5CB)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('हिंदी / En', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: _textDark)),
              Icon(Icons.arrow_drop_down, size: 14, color: _textDark),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.phone_outlined, color: _textDark, size: 20),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Starting encrypted VoIP audio call with Buyer')),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert, color: _textDark, size: 20),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildOrderHeaderBanner() {
    return Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9F5),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFF5D6C6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=120&auto=format&fit=crop&q=80',
                  width: 46,
                  height: 46,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 46,
                    height: 46,
                    color: const Color(0xFFEFE8E2),
                    child: const Icon(Icons.inventory_2, color: _primaryRust),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'BULK PURCHASE ORDER',
                          style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: _primaryRust),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Text(
                            'In Production',
                            style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: Color(0xFF2E7D32)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2.0),
                    const Text(
                      'Bamboo Handwoven Basket',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: _textDark),
                    ),
                    const SizedBox(height: 2.0),
                    const Text(
                      '50 pieces bulk • ₹22,500 Total',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _textMuted),
                    ),
                    const SizedBox(height: 1.0),
                    const Text(
                      '📅 Delivery: 28 September 2026',
                      style: TextStyle(fontSize: 10.5, color: _textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Batch Completion', style: TextStyle(fontSize: 10.5, color: _textMuted)),
              Text('30 / 50 ready (60%)', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800, color: Color(0xFF2E7D32))),
            ],
          ),
          const SizedBox(height: 5.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.0),
            child: const LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Color(0xFFEFE8E2),
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
              minHeight: 5,
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 34,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.visibility_outlined, size: 14, color: _textDark),
                    label: const Text('View Order ↗', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: _textDark)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE5D5CB)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: SizedBox(
                  height: 34,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.camera_alt_outlined, size: 14),
                    label: const Text('Send Production Update', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w800)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryRust,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBuyerMessage1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Heritage Handcrafts  10:15 AM',
          style: TextStyle(fontSize: 10.5, color: _textMuted, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4.0),
        Container(
          constraints: const BoxConstraints(maxWidth: 300),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF5EEE8),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Can you share the latest production update? We need to schedule packaging logistics.',
                style: TextStyle(fontSize: 12.5, color: _textDark, height: 1.35),
              ),
              const SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.translate, size: 12, color: _primaryRust),
                        SizedBox(width: 4.0),
                        Text('हिंदी अनुवाद (Hindi)', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: _primaryRust)),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      '"क्या आप ताज़ा उत्पादन अपडेट साझा कर सकते हैं? हमें पैकेजिंग लॉजिस्टिक्स शेड्यूल करना है।"',
                      style: TextStyle(fontSize: 11.5, color: _textDark, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 6.0),
                    InkWell(
                      onTap: () {
                        HardwareService().speakText('क्या आप ताज़ा उत्पादन अपडेट साझा कर सकते हैं? हमें पैकेजिंग लॉजिस्टिक्स शेड्यूल करना है।');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDF4EE),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.volume_up, size: 13, color: _primaryRust),
                            SizedBox(width: 4.0),
                            Text('Play Translation 🔊', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _primaryRust)),
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

  Widget _buildArtisanVoiceMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'You (Artisan)  10:18 AM',
          style: TextStyle(fontSize: 10.5, color: _textMuted, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4.0),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 310),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFBA4B20),
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '30 pieces ready ho chuke hain, baaki pieces bhi 2 din mein complete ho jayenge.',
                  style: TextStyle(fontSize: 12.5, color: Colors.white, height: 1.35),
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 26,
                        height: 26,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.play_arrow, size: 16, color: Color(0xFFBA4B20)),
                      ),
                      const SizedBox(width: 8.0),
                      const Icon(Icons.mic, size: 13, color: Colors.white),
                      const SizedBox(width: 4.0),
                      const Text('Voice Note', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w700)),
                      const Spacer(),
                      const Text('0:14s', style: TextStyle(fontSize: 10.5, color: Colors.white)),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Translated for Buyer: "30 pieces are ready, and remaining pieces will be completed in 2 days."',
                    style: TextStyle(fontSize: 10.5, color: Colors.white, fontStyle: FontStyle.italic),
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Text('10:18 AM', style: TextStyle(fontSize: 9.5, color: Colors.white70)),
                    SizedBox(width: 4.0),
                    Icon(Icons.done_all, size: 13, color: Colors.white),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBuyerMessage2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Heritage Handcrafts  10:20 AM',
          style: TextStyle(fontSize: 10.5, color: _textMuted, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4.0),
        Container(
          constraints: const BoxConstraints(maxWidth: 300),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF5EEE8),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please send us a photo of the completed batch.',
                style: TextStyle(fontSize: 12.5, color: _textDark),
              ),
              const SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('"कृपया तैयार बैच की एक फोटो भेजें।"', style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF4EE),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.volume_up, size: 12, color: _primaryRust),
                          SizedBox(width: 2.0),
                          Text('Play', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: _primaryRust)),
                        ],
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

  Widget _buildArtisanProductionUpdateMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'You (Artisan)  10:26 AM',
          style: TextStyle(fontSize: 10.5, color: _textMuted, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4.0),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 310),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: const Color(0xFFF5D6C6)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.camera_alt, size: 12, color: Color(0xFF2E7D32)),
                          SizedBox(width: 4.0),
                          Text('Production Update • 30 / 50 Pieces', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: Color(0xFF2E7D32))),
                        ],
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.check_circle_outline, size: 12, color: Color(0xFF2E7D32)),
                        SizedBox(width: 2.0),
                        Text('Order Synced', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: Color(0xFF2E7D32))),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=350&auto=format&fit=crop&q=80',
                        height: 140,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          height: 140,
                          color: const Color(0xFFEFE8E2),
                          child: const Icon(Icons.image, size: 40, color: _primaryRust),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.65),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.check_circle, size: 11, color: Colors.white),
                            SizedBox(width: 4.0),
                            Text(
                              'Batch Quality Checked • 10:25 AM',
                              style: TextStyle(fontSize: 9.5, color: Colors.white, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                const Text(
                  '"30 basket ka weaving aur natural polish complete ho gaya hai."',
                  style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: _textDark),
                ),
                const SizedBox(height: 6.0),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDF4EE),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Translated for Buyer: "Weaving and natural polish of 30 baskets is complete."',
                    style: TextStyle(fontSize: 10.5, color: _primaryRust, fontStyle: FontStyle.italic),
                  ),
                ),
                const SizedBox(height: 6.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('✅ Synced to Buyer Order', style: TextStyle(fontSize: 9.5, color: Color(0xFF2E7D32), fontWeight: FontWeight.w600)),
                    Row(
                      children: [
                        Text('10:26 AM', style: TextStyle(fontSize: 9.5, color: _textMuted)),
                        SizedBox(width: 3.0),
                        Icon(Icons.done_all, size: 13, color: Color(0xFF2E7D32)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickReplyChips() {
    final chips = ['✓ Order is ready', '📷 Production update', "🔍 I'll check", '📦 Ready to ship'];
    return Container(
      height: 38,
      margin: const EdgeInsets.only(bottom: 6.0),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        itemCount: chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6.0),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              _msgController.text = chips[index];
            },
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: const Color(0xFFE5D5CB)),
              ),
              child: Text(
                chips[index],
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _textDark),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5EBE1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: _textDark, size: 20),
              ),
              const SizedBox(width: 8.0),
              Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.camera_alt_outlined, color: Color(0xFF2E7D32), size: 20),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDFBF9),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: const Color(0xFFE5D5CB)),
                  ),
                  child: TextField(
                    controller: _msgController,
                    decoration: const InputDecoration(
                      hintText: 'Type a message or hold mic...',
                      hintStyle: TextStyle(fontSize: 12, color: _textMuted),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              GestureDetector(
                onTap: () {
                  final text = _msgController.text.trim();
                  if (text.isNotEmpty) {
                    _msgController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Message sent & auto-translated for Buyer')),
                    );
                  }
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: _primaryRust,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.mic, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.mic, size: 10, color: _primaryRust),
              SizedBox(width: 2.0),
              Text(
                'Hold to Speak (बोलकर बोलें) • Auto-translates for Buyer',
                style: TextStyle(fontSize: 10, color: _textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
