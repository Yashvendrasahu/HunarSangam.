// lib/screens/order_request_screen.dart
// Production-grade Flutter screen matching 'o3 - order requset - reject page.png'
// Incoming B2B Bulk Order Request Review & Acceptance Hub for Artisans

import 'package:flutter/material.dart';
import '../services/hardware_service.dart';
import '../widgets/artisan_bottom_nav_bar.dart';

/// Production-ready Flutter screen matching 'o3 - order requset - reject page.png'
/// Order Request from Heritage Handcrafts Pvt. Ltd. (50 × Bamboo Handwoven Basket)
class OrderRequestScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final VoidCallback? onFindArtisan;
  final VoidCallback? onOpenSpecs;
  final VoidCallback? onChatWithBuyer;
  final Function(int)? onNavigateTab;
  final String buyerName;
  final String productName;
  final int totalQuantity;
  final int unitPrice;
  final int myCapacity;

  const OrderRequestScreen({
    super.key,
    this.onBack,
    this.onAccept,
    this.onDecline,
    this.onFindArtisan,
    this.onOpenSpecs,
    this.onChatWithBuyer,
    this.onNavigateTab,
    this.buyerName = 'Heritage Handcrafts Pvt. Ltd.',
    this.productName = 'Bamboo Handwoven Basket',
    this.totalQuantity = 50,
    this.unitPrice = 450,
    this.myCapacity = 30,
  });

  @override
  State<OrderRequestScreen> createState() => _OrderRequestScreenState();
}

class _OrderRequestScreenState extends State<OrderRequestScreen> {
  bool _isPlayingAudio = false;
  String _selectedLanguage = 'हिंदी';
  int _currentNavIndex = 1; // Orders tab active

  int get _totalOrderValue => widget.totalQuantity * widget.unitPrice;
  int get _capacityGap => (widget.totalQuantity - widget.myCapacity).clamp(0, widget.totalQuantity);
  double get _capacityRatio => (widget.myCapacity / widget.totalQuantity).clamp(0.0, 1.0);

  Future<void> _toggleAudio() async {
    if (_isPlayingAudio) {
      await HardwareService().stopSpeaking();
      if (mounted) setState(() => _isPlayingAudio = false);
      return;
    }

    setState(() => _isPlayingAudio = true);
    final script = 'नमस्ते! हेरिटेज हैंडक्राफ्ट्स नई दिल्ली से 50 बांस की टोकरियों का थोक ऑर्डर मिला है। कुल मूल्य बाइस हजार पांच सौ रुपये एस्क्रो में सुरक्षित है।';
    await HardwareService().speak(
      script,
      onComplete: () {
        if (mounted) setState(() => _isPlayingAudio = false);
      },
    );
  }

  void _showDeclineDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
        ),
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
            const Text(
              'Decline Order Request?',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1F1612),
              ),
            ),
            const SizedBox(height: 6.0),
            const Text(
              'Please share a quick reason so the buyer can adjust specifications for future orders.',
              style: TextStyle(fontSize: 13.0, color: Color(0xFF6D4C41)),
            ),
            const SizedBox(height: 16.0),
            _buildDeclineOption(ctx, 'Workshop capacity currently full'),
            _buildDeclineOption(ctx, 'Delivery deadline too tight (need more time)'),
            _buildDeclineOption(ctx, 'Custom specifications not aligned with craft style'),
            const SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      side: const BorderSide(color: Color(0xFFD7CCC8)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                    ),
                    child: const Text('Cancel', style: TextStyle(color: Color(0xFF5D4037))),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                      if (widget.onDecline != null) {
                        widget.onDecline!();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Order request declined with feedback.'),
                          backgroundColor: Color(0xFFC53030),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC53030),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                    ),
                    child: const Text('Confirm Decline', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeclineOption(BuildContext ctx, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(ctx);
          if (widget.onDecline != null) widget.onDecline!();
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFDFBF9),
            border: Border.all(color: const Color(0xFFEADFD6)),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              const Icon(Icons.circle_outlined, size: 16.0, color: Color(0xFF8C3A16)),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Color(0xFF2D2421)),
                ),
              ),
            ],
          ),
        ),
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
            // 1. Top App Bar
            _buildTopAppBar(),

            // 2. Main Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title & Inbox Tray Header
                    _buildHeaderSection(),
                    const SizedBox(height: 14.0),

                    // Audio Guide Banner
                    _buildAudioGuideBanner(),
                    const SizedBox(height: 14.0),

                    // Buyer Profile Card
                    _buildBuyerProfileCard(),
                    const SizedBox(height: 14.0),

                    // Product Image Banner
                    _buildProductImageBanner(),
                    const SizedBox(height: 12.0),

                    // Product Title & Craft Tag
                    _buildProductTitleSection(),
                    const SizedBox(height: 14.0),

                    // Pricing & Quantity Grid
                    _buildPriceAndQuantityGrid(),
                    const SizedBox(height: 16.0),

                    // "What the buyer needs" Specs
                    _buildBuyerSpecsSection(),
                    const SizedBox(height: 16.0),

                    // "Can you complete this order?" Capacity Section
                    _buildCapacityCheckSection(),
                    const SizedBox(height: 16.0),

                    // "Your Expected Earnings" Card
                    _buildEarningsEscrowCard(),
                    const SizedBox(height: 20.0),

                    // Action Buttons (Decline & Accept)
                    _buildActionButtons(),
                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            ),

            // 3. Bottom Navigation Bar
            _buildBottomNavigationBar(),
          ],
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
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFEADFD6), width: 1.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: widget.onBack ?? () => Navigator.of(context).maybePop(),
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  width: 38.0,
                  height: 38.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFEADFD6)),
                  ),
                  child: const Icon(Icons.arrow_back, size: 20.0, color: Color(0xFF2D2421)),
                ),
              ),
              const SizedBox(width: 12.0),
              const Text(
                'HunarSangam',
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF8C3A16),
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          Row(
            children: [
              // Language Selector Pill
              PopupMenuButton<String>(
                onSelected: (val) {
                  setState(() => _selectedLanguage = val);
                },
                itemBuilder: (ctx) => [
                  const PopupMenuItem(value: 'हिंदी', child: Text('हिंदी (Hindi)')),
                  const PopupMenuItem(value: 'English', child: Text('English')),
                  const PopupMenuItem(value: 'বাংলা', child: Text('বাংলা (Bengali)')),
                  const PopupMenuItem(value: 'অসমীয়া', child: Text('অসমীয়া (Assamese)')),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFFEADFD6)),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.language, size: 14.0, color: Color(0xFF8C3A16)),
                      const SizedBox(width: 4.0),
                      Text(
                        _selectedLanguage,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D2421),
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      const Icon(Icons.arrow_drop_down, size: 16.0, color: Color(0xFF6D4C41)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              // Notification Bell
              Stack(
                children: [
                  Container(
                    width: 38.0,
                    height: 38.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFEADFD6)),
                    ),
                    child: const Icon(Icons.notifications_none_rounded, size: 20.0, color: Color(0xFF2D2421)),
                  ),
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: Container(
                      width: 7.0,
                      height: 7.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFC53030),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 2. Header Section
  Widget _buildHeaderSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Order Request',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1F1612),
                letterSpacing: -0.3,
              ),
            ),
            SizedBox(height: 2.0),
            Text(
              'You received a new order request',
              style: TextStyle(
                fontSize: 12.5,
                color: Color(0xFF6D4C41),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Container(
          width: 40.0,
          height: 40.0,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF8F4),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFFEADFD6)),
          ),
          child: const Icon(Icons.inbox_rounded, size: 20.0, color: Color(0xFF8C3A16)),
        ),
      ],
    );
  }

  // 3. Audio Guide Banner
  Widget _buildAudioGuideBanner() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5EE),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFF3DFD5)),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: _toggleAudio,
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: const Color(0xFF8C3A16),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Icon(
                _isPlayingAudio ? Icons.pause_rounded : Icons.volume_up_rounded,
                color: Colors.white,
                size: 22.0,
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'AUDIO GUIDE',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF8C3A16),
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  'Tap to listen to this order proposal in your language',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3D2C24),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF0E5DC),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: const Text(
              '28s',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF6D4C41),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 4. Buyer Profile Card
  Widget _buildBuyerProfileCard() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
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
        children: [
          Row(
            children: [
              Container(
                width: 44.0,
                height: 44.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFFCECE3),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text(
                  'HH',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900,
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
                      widget.buyerName,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1F1612),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Row(
                      children: const [
                        Icon(Icons.business, size: 12.0, color: Color(0xFF6D4C41)),
                        SizedBox(width: 3.0),
                        Text(
                          'B2B Buyer • ',
                          style: TextStyle(fontSize: 11.5, color: Color(0xFF6D4C41), fontWeight: FontWeight.w500),
                        ),
                        Icon(Icons.location_on, size: 12.0, color: Color(0xFF6D4C41)),
                        SizedBox(width: 2.0),
                        Text(
                          'New Delhi',
                          style: TextStyle(fontSize: 11.5, color: Color(0xFF6D4C41), fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Divider(height: 1.0, color: Color(0xFFF0E4DC)),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: const Color(0xFFC8E6C9)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.check_circle_rounded, size: 12.0, color: Color(0xFF2E7D32)),
                    SizedBox(width: 4.0),
                    Text(
                      'Verified B2B Buyer',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: const [
                  Icon(Icons.local_shipping_outlined, size: 14.0, color: Color(0xFF6D4C41)),
                  SizedBox(width: 4.0),
                  Text(
                    '14 Bulk Orders Placed',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6D4C41),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          // Direct Chat with Buyer CTA Button
          SizedBox(
            width: double.infinity,
            height: 42.0,
            child: OutlinedButton.icon(
              onPressed: () {
                if (widget.onChatWithBuyer != null) {
                  widget.onChatWithBuyer!();
                } else if (widget.onNavigateTab != null) {
                  widget.onNavigateTab!(3);
                }
              },
              icon: const Icon(Icons.chat_bubble_outline_rounded, size: 18.0, color: Color(0xFF8C3A16)),
              label: const Text(
                'Chat with Buyer / खरीदार से बात करें',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF8C3A16),
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF8C3A16), width: 1.5),
                backgroundColor: const Color(0xFFFAF5F0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 5. Product Image Banner
  Widget _buildProductImageBanner() {
    return Container(
      height: 190.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        image: const DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1590402494682-cd3fb53b1f70?w=800&auto=format&fit=crop&q=80',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Top Left: Eco Badge
          Positioned(
            top: 12.0,
            left: 12.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.65),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.eco_rounded, size: 13.0, color: Color(0xFF81C784)),
                  SizedBox(width: 4.0),
                  Text(
                    'Natural Eco Craft',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Right: Craft Specs Pill
          Positioned(
            bottom: 12.0,
            right: 12.0,
            child: InkWell(
              onTap: widget.onOpenSpecs,
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                  boxShadow: const [
                    BoxShadow(color: Color(0x1A000000), blurRadius: 4.0, offset: Offset(0, 2)),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.tune_rounded, size: 14.0, color: Color(0xFF8C3A16)),
                    SizedBox(width: 4.0),
                    Text(
                      'Craft Specs',
                      style: TextStyle(
                        color: Color(0xFF8C3A16),
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 6. Product Title & Craft Tag
  Widget _buildProductTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.productName,
          style: const TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1F1612),
          ),
        ),
        const SizedBox(height: 2.0),
        const Text(
          'Assam Style Fine Split Bamboo Construction',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF6D4C41),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // 7. Pricing & Quantity Grid
  Widget _buildPriceAndQuantityGrid() {
    return Column(
      children: [
        Row(
          children: [
            // Quantity Box
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.inventory_2_outlined, size: 13.0, color: Color(0xFF8D6E63)),
                        SizedBox(width: 4.0),
                        Text(
                          'Quantity',
                          style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Color(0xFF8D6E63)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '${widget.totalQuantity} pieces',
                      style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w900, color: Color(0xFF1F1612)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            // Unit Price Box
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.sell_outlined, size: 13.0, color: Color(0xFF8D6E63)),
                        SizedBox(width: 4.0),
                        Text(
                          'Unit Price',
                          style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Color(0xFF8D6E63)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '₹${widget.unitPrice}',
                            style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w900, color: Color(0xFF1F1612)),
                          ),
                          const TextSpan(
                            text: ' / pc',
                            style: TextStyle(fontSize: 11.5, color: Color(0xFF8D6E63), fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        // Total Order Value Box (Peach tinted)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF0E6),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: const Color(0xFFF5D8C7)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.receipt_long_rounded, size: 16.0, color: Color(0xFF8C3A16)),
                  SizedBox(width: 6.0),
                  Text(
                    'Total Order Value',
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: Color(0xFF8C3A16)),
                  ),
                ],
              ),
              Text(
                '₹${_totalOrderValue.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900, color: Color(0xFF8C3A16)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        // Delivery Deadline Box
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBF8),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: const Color(0xFFF0E4DA)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.calendar_month_outlined, size: 15.0, color: Color(0xFF8D6E63)),
                  SizedBox(width: 6.0),
                  Text(
                    'Delivery Deadline',
                    style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: Color(0xFF8D6E63)),
                  ),
                ],
              ),
              const Text(
                '28 Sept 2026',
                style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: Color(0xFF1F1612)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 8. "What the buyer needs" Specs
  Widget _buildBuyerSpecsSection() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'What the buyer needs',
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w900, color: Color(0xFF1F1612)),
                  ),
                  SizedBox(height: 1.0),
                  Text(
                    'Key specifications for batch production',
                    style: TextStyle(fontSize: 11.0, color: Color(0xFF8D6E63)),
                  ),
                ],
              ),
              InkWell(
                onTap: _toggleAudio,
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF0E6),
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: const Color(0xFFF5D8C7)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.volume_up, size: 13.0, color: Color(0xFF8C3A16)),
                      SizedBox(width: 4.0),
                      Text(
                        'Listen',
                        style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w800, color: Color(0xFF8C3A16)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          _buildSpecRow(
            icon: Icons.eco_outlined,
            iconBg: const Color(0xFFE8F5E9),
            iconColor: const Color(0xFF2E7D32),
            title: 'Natural bamboo finish',
            subtitle: 'Unbleached, chemical-free treatment',
          ),
          _buildSpecRow(
            icon: Icons.grain_outlined,
            iconBg: const Color(0xFFFFF3E0),
            iconColor: const Color(0xFFE65100),
            title: 'Traditional handwoven design',
            subtitle: 'Authentic herringbone weave base',
          ),
          _buildSpecRow(
            icon: Icons.straighten_outlined,
            iconBg: const Color(0xFFEFEBE9),
            iconColor: const Color(0xFF5D4037),
            title: 'Medium size',
            subtitle: '12" diameter × 8" height with handles',
          ),
          _buildSpecRow(
            icon: Icons.layers_outlined,
            iconBg: const Color(0xFFFBE9E7),
            iconColor: const Color(0xFFD84315),
            title: '50 pieces required',
            subtitle: 'Complete single batch delivery',
          ),
          _buildSpecRow(
            icon: Icons.local_shipping_outlined,
            iconBg: const Color(0xFFE8F8F5),
            iconColor: const Color(0xFF1ABC9C),
            title: 'Packed safely for delivery',
            subtitle: 'Corrugated cartons with moisture barrier paper',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSpecRow({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0.0 : 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.0,
            height: 32.0,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, size: 17.0, color: iconColor),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF1F1612)),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11.0, color: Color(0xFF6D4C41)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 9. "Can you complete this order?" Capacity Section
  Widget _buildCapacityCheckSection() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF8),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.help_outline_rounded, size: 18.0, color: Color(0xFF8C3A16)),
              SizedBox(width: 6.0),
              Text(
                'Can you complete this order?',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w900, color: Color(0xFF1F1612)),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          // Inner Capacity Breakdown Box
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: const Color(0xFFEADFD6)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: '● Your Available Capacity: ',
                            style: TextStyle(fontSize: 11.5, color: Color(0xFF6D4C41), fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: '${widget.myCapacity} pcs',
                            style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900, color: Color(0xFF8C3A16)),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Required: ',
                            style: TextStyle(fontSize: 11.5, color: Color(0xFF6D4C41), fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: '${widget.totalQuantity} pcs',
                            style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w900, color: Color(0xFF1F1612)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                // Split Capacity Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: SizedBox(
                    height: 10.0,
                    child: Row(
                      children: [
                        Expanded(
                          flex: (widget.myCapacity * 100 ~/ widget.totalQuantity),
                          child: Container(color: const Color(0xFF8C3A16)),
                        ),
                        Expanded(
                          flex: (_capacityGap * 100 ~/ widget.totalQuantity),
                          child: Container(color: const Color(0xFFD7CCC8)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your workshop (${(_capacityRatio * 100).round()}%)',
                      style: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFF6D4C41)),
                    ),
                    Text(
                      'Gap: $_capacityGap pieces',
                      style: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.w700, color: Color(0xFF6D4C41)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          // Collaboration note
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.group_add_outlined, size: 16.0, color: Color(0xFF8C3A16)),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  'Need extra hands? You can accept this entire order and invite a fellow weaver from your cluster to fulfill the remaining 20 pieces together.',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF5D4037),
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          // Find Artisan button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFFAF0E8),
                side: const BorderSide(color: Color(0xFFE8DDD5)),
                padding: const EdgeInsets.symmetric(vertical: 11.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
              onPressed: widget.onFindArtisan,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.handshake_outlined, size: 16.0, color: Color(0xFF8C3A16)),
                  SizedBox(width: 6.0),
                  Text(
                    'Find Artisan to Collaborate',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF8C3A16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 10. "Your Expected Earnings" Card
  Widget _buildEarningsEscrowCard() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Expected Earnings',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8D6E63),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    '₹${_totalOrderValue.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF8C3A16),
                    ),
                  ),
                ],
              ),
              Container(
                width: 44.0,
                height: 44.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F8F0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Icon(Icons.lock_outline_rounded, size: 22.0, color: Color(0xFF2E7D32)),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          const Divider(height: 1.0, color: Color(0xFFF0E4DC)),
          const SizedBox(height: 10.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Icon(Icons.shield_outlined, size: 16.0, color: Color(0xFF2E7D32)),
              SizedBox(width: 6.0),
              Expanded(
                child: Text(
                  '100% Escrow protected. Advance payment guaranteed by HunarSangam Trust Protocol upon order confirmation.',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFF4E342E),
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 11. Action Buttons
  Widget _buildActionButtons() {
    return Row(
      children: [
        // Decline Button
        Expanded(
          child: OutlinedButton(
            onPressed: _showDeclineDialog,
            style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFFFAF5F0),
              side: const BorderSide(color: Color(0xFFD7CCC8)),
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.close_rounded, size: 16.0, color: Color(0xFF2D2421)),
                SizedBox(width: 4.0),
                Text(
                  'Decline',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2D2421),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12.0),
        // Accept Button
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (widget.onAccept != null) {
                widget.onAccept!();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('✅ Order Accepted! ₹22,500 secured in Escrow.'),
                  backgroundColor: Color(0xFF2E7D32),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8C3A16),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
              elevation: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.check_rounded, size: 16.0, color: Colors.white),
                SizedBox(width: 4.0),
                Text(
                  'Accept & Confirm Order',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 12. Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return ArtisanBottomNavBar(
      currentIndex: 2,
      onTap: (idx) {
        if (widget.onNavigateTab != null) {
          widget.onNavigateTab!(idx);
        }
      },
    );
  }
}
