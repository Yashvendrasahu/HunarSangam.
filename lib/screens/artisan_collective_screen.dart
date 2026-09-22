// lib/screens/artisan_collective_screen.dart
// Production-grade Flutter screen matching 'o4- collaboration from oreder page with other artisan.png'
// Form Artisan Collective & Cluster Collaboration Hub for B2B Bulk Orders

import 'package:flutter/material.dart';

/// Production-ready Flutter screen matching 'o4- collaboration from oreder page with other artisan.png'
/// Screen: Form Artisan Collective (FabIndia PO #PO-FAB-9102 - 400 pcs)
class ArtisanCollectiveScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onLockOrder;
  final Function(int)? onNavigateTab;
  final String orderPoNumber;
  final int targetCapacity;

  const ArtisanCollectiveScreen({
    super.key,
    this.onBack,
    this.onLockOrder,
    this.onNavigateTab,
    this.orderPoNumber = 'FabIndia PO #PO-FAB-9102',
    this.targetCapacity = 400,
  });

  @override
  State<ArtisanCollectiveScreen> createState() => _ArtisanCollectiveScreenState();
}

class _ArtisanCollectiveScreenState extends State<ArtisanCollectiveScreen> {
  bool _isListenAudioPlaying = false;
  bool _isSunitaAudioPlaying = false;
  bool _sunitaSelected = true;
  bool _birenSelected = true;
  int _currentNavIndex = 2; // Orders tab active

  // Quotas
  final int _ramuQuota = 150;
  int get _sunitaQuota => _sunitaSelected ? 150 : 0;
  int get _birenQuota => _birenSelected ? 100 : 0;

  int get _currentFilledCapacity => _ramuQuota + _sunitaQuota + _birenQuota;
  bool get _isCapacityFull => _currentFilledCapacity >= widget.targetCapacity;
  double get _fillPercentage => (_currentFilledCapacity / widget.targetCapacity).clamp(0.0, 1.0);

  // App Palette
  static const Color _terracotta = Color(0xFF8C3A16);
  static const Color _terracottaDark = Color(0xFF702E11);
  static const Color _peachLight = Color(0xFFFCECE3);
  static const Color _peachBorder = Color(0xFFF5D8C7);
  static const Color _cardBg = Colors.white;
  static const Color _borderSubtle = Color(0xFFEADFD6);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6D4C41);
  static const Color _greenCheck = Color(0xFF2E7D32);
  static const Color _greenBg = Color(0xFFE8F5E9);
  static const Color _mustardGold = Color(0xFFB86B14);
  static const Color _darkForest = Color(0xFF2E5A36);

  void _toggleListenAudio() {
    setState(() {
      _isListenAudioPlaying = !_isListenAudioPlaying;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isListenAudioPlaying
              ? '▶ Playing voice overview: Collective quota allocation for FabIndia order'
              : '⏸ Voice overview paused',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: _terracotta,
      ),
    );
  }

  void _toggleSunitaAudio() {
    setState(() {
      _isSunitaAudioPlaying = !_isSunitaAudioPlaying;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isSunitaAudioPlaying
              ? '▶ Playing Sunita Devi\'s craft audio intro (0:22)'
              : '⏸ Sunita Devi\'s audio paused',
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: _terracotta,
      ),
    );
  }

  void _handleVoiceCommand() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🎙️ Voice recognized: "Allocating 120 pcs to Sunita and 130 pcs to Biren"'),
        duration: Duration(seconds: 3),
        backgroundColor: _terracotta,
      ),
    );
  }

  void _submitLockOrder() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: _greenCheck),
            SizedBox(width: 8),
            Text('Collective Locked!'),
          ],
        ),
        content: Text(
          'WhatsApp and Voice Call invitations sent to Sunita Devi & Biren Kalita with Escrow Contract for ${widget.targetCapacity} pcs.\n\nEscrow secured: ₹70,000 via HunarSangam Trust.',
          style: const TextStyle(fontSize: 13, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (widget.onLockOrder != null) {
                widget.onLockOrder!();
              }
            },
            child: const Text('Back to Orders', style: TextStyle(color: _terracotta, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F4),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTargetCapacityCard(),
                    const SizedBox(height: 14),
                    _buildLeadArtisanCard(),
                    const SizedBox(height: 18),
                    _buildClusterMatchHeader(),
                    const SizedBox(height: 10),
                    _buildSunitaDeviCard(),
                    const SizedBox(height: 12),
                    _buildBirenKalitaCard(),
                    const SizedBox(height: 14),
                    _buildVoiceCommandCard(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            _buildBottomCtaArea(),
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      leading: IconButton(
        icon: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _borderSubtle),
          ),
          child: const Icon(Icons.arrow_back, color: _textDark, size: 20),
        ),
        onPressed: widget.onBack ?? () => Navigator.of(context).maybePop(),
      ),
      titleSpacing: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Form Craft Maker Collective',
            style: TextStyle(
              color: _textDark,
              fontSize: 16,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.2,
            ),
          ),
          Text(
            '${widget.orderPoNumber} (${widget.targetCapacity} pcs)',
            style: const TextStyle(
              color: _terracotta,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 14.0),
          child: InkWell(
            onTap: _toggleListenAudio,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _peachLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _peachBorder),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _isListenAudioPlaying ? Icons.pause : Icons.volume_up,
                    size: 15,
                    color: _terracotta,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    '| | | /',
                    style: TextStyle(
                      color: _terracotta,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Listen',
                    style: TextStyle(
                      color: _terracotta,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTargetCapacityCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _borderSubtle),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: _greenBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.people_alt, color: _greenCheck, size: 22),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TARGET CAPACITY',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: _textMuted,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      '${widget.targetCapacity} pcs',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: _textDark,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                    decoration: BoxDecoration(
                      color: _isCapacityFull ? const Color(0xFF2E7D32) : const Color(0xFFB86B14),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle_outline, color: Colors.white, size: 12),
                        const SizedBox(width: 4),
                        Text(
                          _isCapacityFull
                              ? '100% Filled'
                              : '${(_fillPercentage * 100).toInt()}% Filled',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _isCapacityFull ? 'Team Complete' : 'Need ${widget.targetCapacity - _currentFilledCapacity} pcs',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: _isCapacityFull ? _greenCheck : const Color(0xFFC53030),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Multi-segmented capacity progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 10,
              child: Row(
                children: [
                  // Ramu Quota (150 pcs => 37.5%)
                  Flexible(
                    flex: _ramuQuota,
                    child: Container(color: _terracotta),
                  ),
                  const SizedBox(width: 2),
                  // Sunita Quota (150 pcs => 37.5%)
                  if (_sunitaQuota > 0)
                    Flexible(
                      flex: _sunitaQuota,
                      child: Container(color: _mustardGold),
                    ),
                  if (_sunitaQuota > 0 && _birenQuota > 0) const SizedBox(width: 2),
                  // Biren Quota (100 pcs => 25%)
                  if (_birenQuota > 0)
                    Flexible(
                      flex: _birenQuota,
                      child: Container(color: _darkForest),
                    ),
                  // Remaining Unfilled
                  if (!_isCapacityFull)
                    Flexible(
                      flex: widget.targetCapacity - _currentFilledCapacity,
                      child: Container(color: const Color(0xFFE0D7D0)),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLegendItem('Ramu (150)', _terracotta),
              _buildLegendItem('Sunita ($_sunitaQuota)', _mustardGold),
              _buildLegendItem('Biren ($_birenQuota)', _darkForest),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10.5,
            fontWeight: FontWeight.w600,
            color: _textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildLeadArtisanCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _peachBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://images.unsplash.com/photo-1544816155-12df9643f363?w=200&auto=format&fit=crop&q=80',
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) => Container(
                    width: 48,
                    height: 48,
                    color: _peachLight,
                    child: const Icon(Icons.person, color: _terracotta),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Ramu Kumar',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w900,
                            color: _textDark,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: _peachLight,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _peachBorder),
                          ),
                          child: const Text(
                            'You',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              color: _terracotta,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Master Craftsman • Lead Coordinator',
                      style: TextStyle(
                        fontSize: 11,
                        color: _textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _greenBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFC8E6C9)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified_user, color: _greenCheck, size: 13),
                    SizedBox(width: 3),
                    Text(
                      'Lead & QC',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: _greenCheck,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBF7F4),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFF0E4DA)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Committed Quota',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: _textMuted,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '150 pcs',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: _textDark,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '37.5% share',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: _greenCheck,
                        ),
                      ),
                    ],
                  ),
              ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBF7F4),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFF0E4DA)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Estimated Payout',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: _textMuted,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '₹47,600',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: _terracotta,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '₹42k craft + ₹5.6k QC fee',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: _textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClusterMatchHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.auto_awesome, color: _terracotta, size: 18),
            SizedBox(width: 6),
            Text(
              'Cluster Match Suggestions',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: _textDark,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
        Text(
          'Assam & Barabanki Guild',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: _textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildSunitaDeviCard() {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _sunitaSelected ? _terracotta.withOpacity(0.5) : _borderSubtle),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&auto=format&fit=crop&q=80',
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) => Container(
                    width: 44,
                    height: 44,
                    color: _peachLight,
                    child: const Icon(Icons.person, color: _terracotta),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sunita Devi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: _textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Row(
                      children: [
                        Icon(Icons.location_on, size: 12, color: _textMuted),
                        SizedBox(width: 2),
                        Text(
                          'Barabanki Cluster (1.2 km away)',
                          style: TextStyle(fontSize: 11, color: _textMuted),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _sunitaSelected = !_sunitaSelected;
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _sunitaSelected ? _greenCheck : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _sunitaSelected ? _greenCheck : _textMuted,
                      width: 1.5,
                    ),
                  ),
                  child: _sunitaSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Badges row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _greenBg,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFC8E6C9)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified, size: 11, color: _greenCheck),
                    SizedBox(width: 3),
                    Text(
                      'GI Certified #431',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _greenCheck),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFFFE0B2)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, size: 11, color: Color(0xFFE65100)),
                    SizedBox(width: 3),
                    Text(
                      '4.9 (18 Batches)',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFFE65100)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Available quota pill
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: _peachLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                '150 pcs available',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _terracotta),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Audio player bar: Sunita's Craft Intro
          InkWell(
            onTap: _toggleSunitaAudio,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF2EC),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFEEDDD2)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: _terracotta,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _isSunitaAudioPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Sunita\'s Craft Intro',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _textDark),
                  ),
                  const Spacer(),
                  const Text(
                    '0 : 22',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _textMuted),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFF0E4DA)),
          const SizedBox(height: 8),

          // Bottom allocation row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Allocated: ${_sunitaSelected ? 150 : 0} pcs',
                style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _textDark),
              ),
              Text(
                _sunitaSelected ? '₹42,000 direct escrow' : '₹0 (Paused)',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: _sunitaSelected ? _greenCheck : _textMuted,
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
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _birenSelected ? _terracotta.withOpacity(0.5) : _borderSubtle),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&auto=format&fit=crop&q=80',
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) => Container(
                    width: 44,
                    height: 44,
                    color: _peachLight,
                    child: const Icon(Icons.person, color: _terracotta),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Biren Kalita',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: _textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Row(
                      children: [
                        Icon(Icons.location_on, size: 12, color: _textMuted),
                        SizedBox(width: 2),
                        Text(
                          'Kamrup Weavers Guild (3.5 km away)',
                          style: TextStyle(fontSize: 11, color: _textMuted),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _birenSelected = !_birenSelected;
                  });
                },
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _birenSelected ? _greenCheck : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _birenSelected ? _greenCheck : _textMuted,
                      width: 1.5,
                    ),
                  ),
                  child: _birenSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                      : null,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Badges row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _greenBg,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFC8E6C9)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified, size: 11, color: _greenCheck),
                    SizedBox(width: 3),
                    Text(
                      'GI Certified #431',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _greenCheck),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: const Color(0xFFFFE0B2)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, size: 11, color: Color(0xFFE65100)),
                    SizedBox(width: 3),
                    Text(
                      '4.8 (12 Batches)',
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFFE65100)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Available quota pill
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: _peachLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                '150 pcs available',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _terracotta),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: Color(0xFFF0E4DA)),
          const SizedBox(height: 8),

          // Bottom allocation row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Allocated: ${_birenSelected ? 100 : 0} pcs',
                style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: _textDark),
              ),
              Text(
                _birenSelected ? '₹28,000 direct escrow' : '₹0 (Paused)',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  color: _birenSelected ? _greenCheck : _textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceCommandCard() {
    return InkWell(
      onTap: _handleVoiceCommand,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFFFF5F0),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _peachBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                color: _terracotta,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.mic, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'VOICE COMMAND REBALANCE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: _terracotta,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '"Give Sunita 120 pieces and Biren 130 pieces"',
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      color: _textDark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomCtaArea() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _isCapacityFull ? _submitLockOrder : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _terracotta,
                disabledBackgroundColor: const Color(0xFFC0A090),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 1,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Send Team Invites & Lock Order',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.chat_bubble_outline, size: 12, color: _greenCheck),
              SizedBox(width: 4),
              Text(
                'Craft Makers receive WhatsApp & Voice call invites with audio confirmation',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: _textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    final navItems = [
      {'label': 'Home', 'icon': Icons.storefront_outlined},
      {'label': 'Products', 'icon': Icons.palette_outlined},
      {'label': 'Orders', 'icon': Icons.receipt_long_outlined},
      {'label': 'Collaborate', 'icon': Icons.people_outline},
      {'label': 'Profile', 'icon': Icons.person_outline},
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: _borderSubtle)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (idx) {
          final isSelected = _currentNavIndex == idx;
          final item = navItems[idx];
          return InkWell(
            onTap: () {
              setState(() {
                _currentNavIndex = idx;
              });
              if (widget.onNavigateTab != null) {
                widget.onNavigateTab!(idx);
              }
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: isSelected ? _peachLight : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    item['icon'] as IconData,
                    size: 20,
                    color: isSelected ? _terracotta : _textMuted,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item['label'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                      color: isSelected ? _terracotta : _textMuted,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
