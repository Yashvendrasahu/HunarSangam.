// lib/screens/collaboration_hub_screen.dart

import 'package:flutter/material.dart';
import '../models/onboarding_state.dart';
import '../add_product/widgets/artisan_bottom_navigation.dart';

/// Screen matching 'colloboration.png'
/// Full reproduction of the Collaboration Hub for Artisans
class CollaborationHubScreen extends StatefulWidget {
  final OnboardingState? state;
  final VoidCallback onBack;
  final ValueChanged<int>? onNavigateTab;
  final VoidCallback? onOpenFormCollective;
  final VoidCallback? onOpenSuggestedArtisans;
  final Function(String artisanName, String orderTitle)? onChatWithArtisan;
  final Function(String buyerName, String orderTitle)? onChatWithBuyer;

  const CollaborationHubScreen({
    super.key,
    this.state,
    required this.onBack,
    this.onNavigateTab,
    this.onOpenFormCollective,
    this.onOpenSuggestedArtisans,
    this.onChatWithArtisan,
    this.onChatWithBuyer,
  });

  @override
  State<CollaborationHubScreen> createState() => _CollaborationHubScreenState();
}

class _CollaborationHubScreenState extends State<CollaborationHubScreen> {
  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFDFBF9);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);

  bool _isAudioPlaying = false;
  bool _rameshAccepted = true;
  bool _meeraAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgCanvas,
      appBar: _buildTopAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Title
              const Text(
                'Collaboration',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: _textDark,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 2.0),
              const Text(
                'Work together. Complete more orders.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: _textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 14.0),

              // Audio Guide Banner
              _buildAudioGuideBanner(),
              const SizedBox(height: 20.0),

              // Section: Requests for You
              Row(
                children: [
                  const Text(
                    'Requests for You',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: _textDark,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFBA4B20),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      '2 New',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3.0),
              const Text(
                'Artisans want you to help complete their orders.',
                style: TextStyle(fontSize: 11.5, color: _textMuted),
              ),
              const SizedBox(height: 12.0),

              // Request Card 1: Ramesh Kumar
              _buildRameshKumarCard(),
              const SizedBox(height: 14.0),

              // Request Card 2: Meera Bai
              _buildMeeraBaiCard(),
              const SizedBox(height: 24.0),

              // Section: Your Invites
              Row(
                children: [
                  const Text(
                    'Your Invites',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: _textDark,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2D6CE),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const Text(
                      '3 Total',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: _textDark,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 3.0),
              const Text(
                "Artisans you've invited to collaborate on your active orders.",
                style: TextStyle(fontSize: 11.5, color: _textMuted),
              ),
              const SizedBox(height: 12.0),

              // Invite 1: Sohan Patel
              _buildSohanPatelCard(),
              const SizedBox(height: 12.0),

              // Invite 2: Biren Kalita
              _buildBirenKalitaCard(),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ArtisanBottomNavigation(
        currentIndex: 3, // Collaborate tab
        onTap: (idx) => widget.onNavigateTab?.call(idx),
      ),
    );
  }

  PreferredSizeWidget _buildTopAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: _textDark),
        onPressed: widget.onBack,
      ),
      title: const Text(
        'HunarSangam',
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w900,
          color: Color(0xFF8D3412),
          letterSpacing: -0.3,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12.0),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: const Color(0xFFE5D5CB)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.translate, size: 14, color: _textDark),
              SizedBox(width: 4.0),
              Text('English', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _textDark)),
            ],
          ),
        ),
        IconButton(
          icon: Stack(
            children: [
              const Icon(Icons.notifications_outlined, color: _textDark, size: 22),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: _primaryRust,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('🔔 2 new collaboration requests from nearby cluster artisans'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
        const SizedBox(width: 8.0),
      ],
    );
  }

  Widget _buildAudioGuideBanner() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF4EE),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFF5D6C6)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: _primaryRust,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.volume_up, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'AUDIO GUIDE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: _primaryRust,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  'Tap to hear updates in Assamese / Hindi / English',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: _textDark,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              _isAudioPlaying ? Icons.pause_circle_outline : Icons.play_circle_outline,
              color: _textDark,
              size: 26,
            ),
            onPressed: () {
              setState(() => _isAudioPlaying = !_isAudioPlaying);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRameshKumarCard() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFEFE8E2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Artisan info row
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=100&auto=format&fit=crop&q=80',
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const CircleAvatar(
                    radius: 21,
                    backgroundColor: Color(0xFFE5D5CB),
                    child: Text('RK', style: TextStyle(fontWeight: FontWeight.bold, color: _primaryRust)),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          'Ramesh Kumar',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: _textDark),
                        ),
                        SizedBox(width: 4.0),
                        Icon(Icons.verified, size: 14, color: Color(0xFF2E7D32)),
                      ],
                    ),
                    const SizedBox(height: 1.0),
                    const Text(
                      'Master Bamboo Craftsman • Barpeta',
                      style: TextStyle(fontSize: 11, color: _textMuted),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.star, size: 12, color: Color(0xFFF57C00)),
                    SizedBox(width: 2.0),
                    Text(
                      '4.9',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFFF57C00)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),

          // Listen to Request bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFDF6F0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Row(
                  children: [
                    Icon(Icons.hearing, size: 14, color: _primaryRust),
                    SizedBox(width: 5.0),
                    Text(
                      'Listen to Request 🔊',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _primaryRust),
                    ),
                  ],
                ),
                Text(
                  'Play (0:18s)',
                  style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: _primaryRust),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),

          // Order details box
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFDFBF9),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: const Color(0xFFEFE8E2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=100&auto=format&fit=crop&q=80',
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 44,
                          height: 44,
                          color: const Color(0xFFEFE8E2),
                          child: const Icon(Icons.inventory_2, color: _primaryRust, size: 20),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'BULK B2B ORDER',
                            style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: Color(0xFF2E7D32)),
                          ),
                          SizedBox(height: 1.0),
                          Text(
                            'Bamboo Handwoven Basket',
                            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: _textDark),
                          ),
                          SizedBox(height: 1.0),
                          Row(
                            children: [
                              Icon(Icons.apartment, size: 11, color: _textMuted),
                              SizedBox(width: 3.0),
                              Text(
                                'Heritage Handcrafts Pvt. Ltd.',
                                style: TextStyle(fontSize: 10.5, color: _textMuted),
                              ),
                              SizedBox(width: 3.0),
                              Icon(Icons.verified, size: 10, color: Color(0xFF2E7D32)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Your Contribution', style: TextStyle(fontSize: 10, color: _textMuted)),
                            SizedBox(height: 2.0),
                            Text('20 pieces', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: _textDark)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Deadline', style: TextStyle(fontSize: 10, color: _textMuted)),
                            SizedBox(height: 2.0),
                            Text('28 Sep 2026', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: _textDark)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Order Total: ₹22,500', style: TextStyle(fontSize: 10.5, color: _textMuted)),
                        SizedBox(height: 1.0),
                        Text(
                          'Your Share: ₹9,000',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: _primaryRust),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.lock, size: 10, color: Color(0xFF2E7D32)),
                          SizedBox(width: 3.0),
                          Text(
                            'Escrow Protected',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF2E7D32)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),

          // Accept / Decline Buttons
          if (!_rameshAccepted) ...[
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => setState(() => _rameshAccepted = true),
                    icon: const Icon(Icons.check, size: 16),
                    label: const Text('Accept', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryRust,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Request declined gracefully with cluster message.'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    },
                    icon: const Icon(Icons.close, size: 16, color: _textDark),
                    label: const Text('Decline', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: _textDark)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE5D5CB)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ),
              ],
            ),
          ],
          Center(
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                    title: const Text('Order & Craft Specs', style: TextStyle(fontWeight: FontWeight.w800)),
                    content: const Text(
                      '• Product: 500 Pcs Hand-carved Terracotta Planters\n'
                      '• Target Date: 15 Oct\n'
                      '• Payout: ₹45,000 via Escrow\n'
                      '• Clay & Kiln provided by lead artisan.',
                      style: TextStyle(height: 1.4),
                    ),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
                    ],
                  ),
                );
              },
              child: const Text(
                'View Order & Craft Specs >',
                style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _textDark),
              ),
            ),
          ),

          // Accepted confirmation banner
          if (_rameshAccepted) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: const Color(0xFFC8E6C9)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified, size: 16, color: Color(0xFF2E7D32)),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Collaboration Accepted',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF2E7D32)),
                        ),
                        Text(
                          'Escrow locked for 20 pcs',
                          style: TextStyle(fontSize: 10, color: Color(0xFF388E3C)),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      widget.onChatWithArtisan?.call('Ramesh Kumar', 'Bamboo Handwoven Basket');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: const Text('Chat with him', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMeeraBaiCard() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFEFE8E2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=100&auto=format&fit=crop&q=80',
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const CircleAvatar(
                    radius: 21,
                    backgroundColor: Color(0xFFE5D5CB),
                    child: Text('MB', style: TextStyle(fontWeight: FontWeight.bold, color: _primaryRust)),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Meera Bai ⏱️', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: _textDark)),
                    SizedBox(height: 1.0),
                    Text('Terracotta Water Jugs • Due in 12 days', style: TextStyle(fontSize: 11, color: _textMuted)),
                  ],
                ),
              ),
              const Text('₹4,500', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: _primaryRust)),
            ],
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFDFBF9),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Need: 10 pieces', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: _textDark)),
                Text('Buyer: Organic Living Co.', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _textDark)),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 38,
                  child: ElevatedButton.icon(
                    onPressed: () => setState(() => _meeraAccepted = true),
                    icon: const Icon(Icons.check, size: 14),
                    label: const Text('Accept', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryRust,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: SizedBox(
                  height: 38,
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Request declined.')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE5D5CB)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: const Text('Decline', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: _textDark)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton(
              onPressed: () {
                widget.onChatWithArtisan?.call('Meera Bai', 'Terracotta Water Jugs');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8D3412),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              child: const Text('Chat with him', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSohanPatelCard() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFEFE8E2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&auto=format&fit=crop&q=80',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFFE5D5CB),
                    child: Text('SP', style: TextStyle(fontWeight: FontWeight.bold, color: _primaryRust)),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Sohan Patel', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: _textDark)),
                    SizedBox(height: 1.0),
                    Text('Bamboo Craft Artisan • Kamrup', style: TextStyle(fontSize: 11, color: _textMuted)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.hourglass_top, size: 11, color: Color(0xFFE65100)),
                    SizedBox(width: 2.0),
                    Text(
                      'Waiting for\nResponse',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFFE65100)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFDFBF9),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Order:', style: TextStyle(fontSize: 10.5, color: _textMuted)),
                    Text('Bamboo Handwoven Basket', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: _textDark)),
                  ],
                ),
                const SizedBox(height: 4.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Requested: 15 pcs', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _textDark)),
                    Text('Capacity: 20 pcs', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _textDark)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 36,
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('WhatsApp & SMS reminder sent to Sohan Patel')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE5D5CB)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: const Text('🔔 Remind 🔔', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _textDark)),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 36,
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Viewing collaborator artisan portfolio & profile.')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE5D5CB)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    ),
                    child: const Text('View Profile', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _textDark)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBirenKalitaCard() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFEFE8E2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100&auto=format&fit=crop&q=80',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFFE5D5CB),
                    child: Text('BK', style: TextStyle(fontWeight: FontWeight.bold, color: _primaryRust)),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Biren Kalita', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: _textDark)),
                    SizedBox(height: 1.0),
                    Text('Master Weaver • Guwahati', style: TextStyle(fontSize: 11, color: _textMuted)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.check, size: 11, color: Color(0xFF2E7D32)),
                    SizedBox(width: 2.0),
                    Text('Accepted', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF2E7D32))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFDFBF9),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Bamboo Fruit Bowls', style: TextStyle(fontSize: 11.5, color: _textDark, fontWeight: FontWeight.w600)),
                Text('20 pieces assigned', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: _textDark)),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            height: 38,
            child: ElevatedButton.icon(
              onPressed: () {
                widget.onChatWithArtisan?.call('Biren Kalita', 'Bamboo Fruit Bowls');
              },
              icon: const Icon(Icons.chat_bubble_outline, size: 14),
              label: const Text('Chat with him', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8D3412),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
