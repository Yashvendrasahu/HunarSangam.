// lib/screens/order_details_screen.dart
// Production-grade Flutter screen matching 'o2- order updation page.png'
// Order Details & Production Progress Updation Hub for Artisans

import 'package:flutter/material.dart';
import '../services/hardware_service.dart';
import '../widgets/artisan_bottom_nav_bar.dart';

/// Production-ready Flutter screen matching 'o2- order updation page.png'
/// Order #HS1048 - Handmade Bamboo Baskets
class OrderDetailsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final Function(int)? onNavigateTab;
  final VoidCallback? onFindArtisan;
  final String orderId;
  final String buyerName;
  final int totalQuantity;
  final int initialCompleted;
  final VoidCallback? onChatWithBuyer;

  const OrderDetailsScreen({
    super.key,
    this.onBack,
    this.onNavigateTab,
    this.onFindArtisan,
    this.onChatWithBuyer,
    this.orderId = 'HS1048',
    this.buyerName = "Priya's Home Décor",
    this.totalQuantity = 50,
    this.initialCompleted = 30,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late int _completedPieces;
  bool _isPlayingAudio = false;
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _completedPieces = widget.initialCompleted;
  }

  void _incrementCount() {
    if (_completedPieces < widget.totalQuantity) {
      setState(() {
        _completedPieces++;
      });
    }
  }

  void _decrementCount() {
    if (_completedPieces > 0) {
      setState(() {
        _completedPieces--;
      });
    }
  }

  void _toggleAudioGuide() {
    setState(() {
      _isPlayingAudio = !_isPlayingAudio;
    });

    if (_isPlayingAudio) {
      final text = _selectedLanguage == 'Hindi'
          ? 'नमस्ते कारीगर साथी। यह ऑर्डर नंबर ${widget.orderId} है। कुल मात्रा ${widget.totalQuantity} पीस है। कृपया दैनिक उत्पादन अपडेट करें।'
          : 'Welcome artisan. This is order number ${widget.orderId} for ${widget.buyerName}. Total quantity is ${widget.totalQuantity} pieces. Please update your production progress on time.';

      HardwareService().speakText(
        text,
        language: _selectedLanguage,
        onDone: () {
          if (mounted) setState(() => _isPlayingAudio = false);
        },
      );
    } else {
      HardwareService().stopAudio();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isPlayingAudio
              ? '🔊 Playing voice guide in $_selectedLanguage...'
              : 'Audio guide paused.',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFF8C3A16),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _saveProgress() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '✅ Progress saved: $_completedPieces/${widget.totalQuantity} units completed (${((_completedPieces / widget.totalQuantity) * 100).round()}%)! Buyer & Escrow notified.',
        ),
        backgroundColor: const Color(0xFF2E7D32),
        behavior: SnackBarBehavior.floating,
      ),
    );
    if (widget.onBack != null) {
      widget.onBack!();
    }
  }

  void _showClusterArtisansModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFDFB),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFEADFD6),
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Cluster Artisans',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1F1612),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(ctx),
                  icon: const Icon(Icons.close, color: Color(0xFF7A685F)),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Text(
              'Share remaining ${widget.totalQuantity - _completedPieces} pieces with verified cluster weavers:',
              style: const TextStyle(
                fontSize: 13.0,
                color: Color(0xFF6D4C41),
              ),
            ),
            const SizedBox(height: 16.0),
            _buildArtisanTile(
              name: 'Suresh Das',
              craft: 'Assam Cane & Bamboo Weaver',
              capacity: '20 pcs capacity available',
              onInvite: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invited Suresh Das to split 15 pieces!'),
                    backgroundColor: Color(0xFF8C3A16),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            const SizedBox(height: 10.0),
            _buildArtisanTile(
              name: 'Bina Devi',
              craft: 'Master Basket Artisan',
              capacity: '15 pcs capacity available',
              onInvite: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invited Bina Devi to split 10 pieces!'),
                    backgroundColor: Color(0xFF8C3A16),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildArtisanTile({
    required String name,
    required String craft,
    required String capacity,
    required VoidCallback onInvite,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF8),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: const Color(0xFFF3EAE3),
            child: Text(
              name.substring(0, 1),
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Color(0xFF8C3A16),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1F1612),
                  ),
                ),
                Text(
                  capacity,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF2E7D32),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onInvite,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8C3A16),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text(
              'Invite',
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            _buildTopAppBar(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Audio Guide Available Card
                    _buildAudioGuideBanner(),
                    const SizedBox(height: 14.0),

                    // Main Order Card (#HS1048)
                    _buildMainOrderCard(),
                    const SizedBox(height: 16.0),

                    // Order Requirements Section
                    _buildOrderRequirements(),
                    const SizedBox(height: 16.0),

                    // Production Progress Section
                    _buildProductionProgressSection(),
                    const SizedBox(height: 16.0),

                    // Need help completing this order? Card
                    _buildCollaborationCard(),
                    const SizedBox(height: 80.0), // Padding for sticky bottom CTA
                  ],
                ),
              ),
            ),

            // Sticky Bottom Action & Navigation Bar
            _buildStickyBottomBar(),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 74.0),
        child: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('🎙️ Voice Assistant: Say "Add 5 finished baskets" or "Report delay"'),
                backgroundColor: Color(0xFF8C3A16),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          backgroundColor: const Color(0xFF8C3A16),
          foregroundColor: Colors.white,
          elevation: 4.0,
          shape: const CircleBorder(),
          child: const Icon(Icons.mic, size: 26.0),
        ),
      ),
    );
  }

  // 1. Top App Bar
  Widget _buildTopAppBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFEADFD6), width: 1.0)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: widget.onBack,
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFEADFD6)),
                color: Colors.white,
              ),
              child: const Icon(Icons.chevron_left, color: Color(0xFF1F1612), size: 24.0),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Order Details',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1F1612),
                  ),
                ),
                Row(
                  children: const [
                    Text(
                      '• ',
                      style: TextStyle(
                        color: Color(0xFF8C3A16),
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Artisan View',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF8C3A16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Chat with Buyer Button
          if (widget.onChatWithBuyer != null) ...[
            InkWell(
              onTap: widget.onChatWithBuyer,
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: const Color(0xFFFBECE2),
                  border: Border.all(color: const Color(0xFFF0D5C3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.chat_bubble_outline_rounded, color: Color(0xFF8C3A16), size: 16.0),
                    SizedBox(width: 4.0),
                    Text(
                      'Chat',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF8C3A16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8.0),
          ],
          // Notification Bell
          Container(
            width: 38.0,
            height: 38.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFEADFD6)),
              color: Colors.white,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.notifications_none, color: Color(0xFF1F1612), size: 20.0),
                Positioned(
                  top: 9.0,
                  right: 9.0,
                  child: Container(
                    width: 6.0,
                    height: 6.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC53030),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8.0),
          // Language Dropdown
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: const Color(0xFFD7CCC8)),
              color: Colors.white,
            ),
            child: Row(
              children: const [
                Text(
                  'English',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F1612),
                  ),
                ),
                SizedBox(width: 4.0),
                Text(
                  '|',
                  style: TextStyle(color: Color(0xFF8D6E63), fontSize: 12.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 2. Audio Guide Available Banner
  Widget _buildAudioGuideBanner() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5EE),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0xFFF3DFD5)),
      ),
      child: Row(
        children: [
          Container(
            width: 44.0,
            height: 44.0,
            decoration: const BoxDecoration(
              color: Color(0xFF8C3A16),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.volume_up, color: Colors.white, size: 22.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'AUDIO GUIDE AVAILABLE',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                    color: Color(0xFF8C3A16),
                  ),
                ),
                SizedBox(height: 2.0),
                Text.rich(
                  TextSpan(
                    text: 'Tap to listen to this order in ',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF2D2421),
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text: 'Hindi',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1F1612),
                        ),
                      ),
                      TextSpan(text: ' / '),
                      TextSpan(
                        text: 'Assamese',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1F1612),
                        ),
                      ),
                      TextSpan(text: ' / '),
                      TextSpan(
                        text: 'Gujarati',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1F1612),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: _toggleAudioGuide,
            icon: Icon(
              _isPlayingAudio ? Icons.pause_circle_outline : Icons.play_circle_outline,
              color: const Color(0xFF8C3A16),
              size: 30.0,
            ),
          ),
        ],
      ),
    );
  }

  // 3. Main Order Card (#HS1048)
  Widget _buildMainOrderCard() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Order #${widget.orderId}',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1F1612),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: const Color(0xFFC8E6C9)),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.check_circle, size: 12.0, color: Color(0xFF2E7D32)),
                        SizedBox(width: 4.0),
                        Text(
                          'B2B Confirmed',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Text(
                'B2B Bulk',
                style: TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8D6E63),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // Bamboo Image Banner
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Stack(
              children: [
                Container(
                  height: 170.0,
                  width: double.infinity,
                  color: const Color(0xFFE8DDD5),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1590402494682-cd3fb53b1f70?w=800&auto=format&fit=crop&q=80',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFD7CCC8),
                      child: const Center(
                        child: Icon(Icons.shopping_basket, size: 48.0, color: Color(0xFF8C3A16)),
                      ),
                    ),
                  ),
                ),
                // GI Tag Cluster Top-Right Badge
                Positioned(
                  top: 10.0,
                  right: 10.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 4.0,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.eco, size: 12.0, color: Color(0xFF2E7D32)),
                        SizedBox(width: 4.0),
                        Text(
                          'GI Tag Cluster',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // 100% Eco Bamboo Bottom-Left Badge
                Positioned(
                  bottom: 10.0,
                  left: 10.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.65),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.all_inbox, size: 12.0, color: Colors.white),
                        SizedBox(width: 4.0),
                        Text(
                          '100% Eco Bamboo',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),

          // Titles
          const Text(
            'Handmade Bamboo Baskets',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1F1612),
              letterSpacing: -0.2,
            ),
          ),
          const SizedBox(height: 2.0),
          const Text(
            'Round open storage utility crafts with reinforced rims',
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF6D4C41),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14.0),

          // 2x2 Details Grid
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: widget.onChatWithBuyer,
                  borderRadius: BorderRadius.circular(14.0),
                  child: _buildDetailTile(
                    icon: Icons.storefront,
                    label: 'BUYER (TAP TO CHAT)',
                    title: widget.buyerName,
                    subtitleWidget: Row(
                      children: const [
                        Icon(Icons.chat_bubble_outline, size: 11.0, color: Color(0xFF8C3A16)),
                        SizedBox(width: 3.0),
                        Text(
                          'Chat with Buyer →',
                          style: TextStyle(
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8C3A16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: _buildDetailTile(
                  icon: Icons.widgets_outlined,
                  label: 'QUANTITY',
                  title: '${widget.totalQuantity} pieces',
                  subtitle: 'Batch size confirmed',
                  subtitleColor: const Color(0xFF8D6E63),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: _buildDetailTile(
                  icon: Icons.calendar_today_outlined,
                  label: 'DELIVERY DEADLINE',
                  title: 'September 30',
                  subtitle: '14 days remaining',
                  subtitleColor: const Color(0xFFC53030),
                  isSubtitleBold: true,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: _buildDetailTile(
                  icon: Icons.verified_user_outlined,
                  label: 'ESCROW SECURED',
                  title: '₹19,000',
                  titleColor: const Color(0xFF8C3A16),
                  subtitle: '100% Locked in Escrow',
                  subtitleColor: const Color(0xFF2E7D32),
                  isSubtitleBold: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailTile({
    required IconData icon,
    required String label,
    required String title,
    Color? titleColor,
    String? subtitle,
    Widget? subtitleWidget,
    Color? subtitleColor,
    bool isSubtitleBold = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF8),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFF0E4DA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 12.0, color: const Color(0xFF8D6E63)),
              const SizedBox(width: 4.0),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.5,
                  color: Color(0xFF8D6E63),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w900,
              color: titleColor ?? const Color(0xFF1F1612),
            ),
          ),
          const SizedBox(height: 3.0),
          if (subtitleWidget != null) subtitleWidget,
          if (subtitle != null)
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 9.5,
                fontWeight: isSubtitleBold ? FontWeight.bold : FontWeight.normal,
                color: subtitleColor ?? const Color(0xFF6D4C41),
              ),
            ),
        ],
      ),
    );
  }

  // 4. Order Requirements
  Widget _buildOrderRequirements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Row(
              children: [
                Icon(Icons.tune, size: 16.0, color: Color(0xFF8C3A16)),
                SizedBox(width: 6.0),
                Text(
                  'Order Requirements',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1F1612),
                  ),
                ),
              ],
            ),
            Text(
              'Standard Spec',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF8D6E63),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: _buildSpecCard(
                icon: Icons.spa_outlined,
                label: 'MATERIAL',
                value: 'Natural Bamboo',
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: _buildSpecCard(
                icon: Icons.palette_outlined,
                label: 'COLOR',
                value: 'Natural Finish',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: _buildSpecCard(
                icon: Icons.grid_view,
                label: 'QUANTITY',
                value: '50 pieces',
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: _buildSpecCard(
                icon: Icons.inventory_2_outlined,
                label: 'PACKAGING',
                value: 'Standard Eco-',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        // Full width Dispatch Handover card
        Container(
          padding: const EdgeInsets.all(10.0),
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
                  color: const Color(0xFFFAF5F0),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                child: const Icon(Icons.local_shipping_outlined, size: 16.0, color: Color(0xFF8C3A16)),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'DISPATCH HANDOVER',
                      style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                        color: Color(0xFF8D6E63),
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      'September 30 (Doorstep pickup by Delhivery B2B)',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1F1612),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.info_outline, size: 16.0, color: Color(0xFF8D6E63)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpecCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(10.0),
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
              color: const Color(0xFFFAF5F0),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: const Color(0xFFEADFD6)),
            ),
            child: Icon(icon, size: 16.0, color: const Color(0xFF8C3A16)),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 8.5,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.4,
                    color: Color(0xFF8D6E63),
                  ),
                ),
                const SizedBox(height: 1.0),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1F1612),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 5. Production Progress Section
  Widget _buildProductionProgressSection() {
    final percent = ((_completedPieces / widget.totalQuantity) * 100).round();
    final remaining = widget.totalQuantity - _completedPieces;

    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF8),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: const Color(0xFFF0E4DA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.build_outlined, size: 16.0, color: Color(0xFF8C3A16)),
                  SizedBox(width: 6.0),
                  Text(
                    'Production Progress',
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1F1612),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFF8C3A16),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  '$percent% Complete',
                  style: const TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // Big Counter Display
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$_completedPieces',
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1F1612),
                    ),
                  ),
                  Text(
                    ' / ${widget.totalQuantity} completed',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6D4C41),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('⏳ ', style: TextStyle(fontSize: 12.0)),
                  Text(
                    '$remaining pieces left to craft',
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF8C3A16),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: LinearProgressIndicator(
              value: _completedPieces / widget.totalQuantity,
              minHeight: 10.0,
              backgroundColor: const Color(0xFFEADFD6),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8C3A16)),
            ),
          ),
          const SizedBox(height: 14.0),

          // Quick Count Update Sub-card
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: const Color(0xFFEADFD6)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Quick Count Update',
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1F1612),
                      ),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      'Tap +/- to adjust pieces finished today',
                      style: TextStyle(
                        fontSize: 10.5,
                        color: Color(0xFF8D6E63),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: _decrementCount,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        width: 36.0,
                        height: 36.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFAF5F0),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: const Color(0xFFE0D7D2)),
                        ),
                        child: const Icon(Icons.remove, size: 18.0, color: Color(0xFF1F1612)),
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(minWidth: 32.0),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Text(
                        '$_completedPieces',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1F1612),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: _incrementCount,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        width: 36.0,
                        height: 36.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF8C3A16),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Icon(Icons.add, size: 18.0, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),

          // Real Camera Proof Capture Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: const Color(0xFFEADFD6)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF5EE),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Icon(Icons.camera_alt, color: Color(0xFF8C3A16), size: 20.0),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Upload Production Proof',
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF1F1612)),
                      ),
                      Text(
                        'Take real camera photo of finished pieces for buyer escrow release',
                        style: TextStyle(fontSize: 10.5, color: Color(0xFF7A6A60)),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Open Camera',
                  icon: const Icon(Icons.photo_camera, color: Color(0xFF8C3A16)),
                  onPressed: () async {
                    final photo = await HardwareService().captureImageFromCamera();
                    if (photo != null && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('📸 Photo captured: ${photo.name}! Proof uploaded to Buyer Escrow.'),
                          backgroundColor: const Color(0xFF2E7D32),
                        ),
                      );
                    }
                  },
                ),
                IconButton(
                  tooltip: 'Choose from Gallery',
                  icon: const Icon(Icons.photo_library, color: Color(0xFF7A6A60)),
                  onPressed: () async {
                    final img = await HardwareService().pickImageFromGallery();
                    if (img != null && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('🖼️ Image selected: ${img.name}! Attached to milestone.'),
                          backgroundColor: const Color(0xFF2E7D32),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 6. Collaboration Card
  Widget _buildCollaborationCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5EE),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: const Color(0xFFF3DFD5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: const Color(0xFF8C3A16),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Icon(Icons.people_alt, color: Colors.white, size: 20.0),
              ),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Need help completing this order?',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1F1612),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Your usual capacity is lower than this order quantity. You can team up with another artisan in your cluster to share workload and profit.',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF5D4037),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14.0),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _showClusterArtisansModal,
                  icon: const Icon(Icons.person_add_alt, size: 16.0),
                  label: const Text(
                    'Find an Artisan',
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8C3A16),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('👍 Continuing alone. Capacity locked for Ramu Kumar.'),
                        backgroundColor: Color(0xFF6D4C41),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2D2421),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFD7CCC8)),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Continue Alone',
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 7. Sticky Bottom Action & Navigation Bar
  Widget _buildStickyBottomBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEADFD6), width: 1.0)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10.0,
            offset: Offset(0, -3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Action CTAs: Chat with Buyer & Update Progress
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 48.0,
                  child: OutlinedButton.icon(
                    onPressed: widget.onChatWithBuyer,
                    icon: const Icon(Icons.chat_bubble_outline, size: 18.0),
                    label: const Text(
                      'Chat with Buyer',
                      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF8C3A16),
                      side: const BorderSide(color: Color(0xFF8C3A16), width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 48.0,
                  child: ElevatedButton.icon(
                    onPressed: _saveProgress,
                    icon: const Icon(Icons.check_circle_outline, size: 18.0),
                    label: const Text(
                      'Update Progress',
                      style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w800),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8C3A16),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),

          // 5-Tab Navigation Bar
          ArtisanBottomNavBar(
            currentIndex: 2,
            onTap: (idx) {
              if (widget.onNavigateTab != null) {
                widget.onNavigateTab!(idx);
              }
            },
          ),
        ],
      ),
    );
  }
}
