// lib/screens/digital_visiting_card_screen.dart

import 'package:flutter/material.dart';

class DigitalVisitingCardScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onShareWhatsApp;
  final VoidCallback? onDownloadPdf;
  final VoidCallback? onCopyLink;
  final VoidCallback? onAddToWallet;
  final VoidCallback? onVoiceRecordStory;
  final VoidCallback? onShareCard;
  final Function(int)? onBottomNavTapped;

  const DigitalVisitingCardScreen({
    super.key,
    this.onBack,
    this.onShareWhatsApp,
    this.onDownloadPdf,
    this.onCopyLink,
    this.onAddToWallet,
    this.onVoiceRecordStory,
    this.onShareCard,
    this.onBottomNavTapped,
  });

  @override
  State<DigitalVisitingCardScreen> createState() => _DigitalVisitingCardScreenState();
}

enum VisitingCardTemplate {
  phoneCard,
  stallStandee,
  packagingTag,
}

class _DigitalVisitingCardScreenState extends State<DigitalVisitingCardScreen> {
  VisitingCardTemplate _selectedTemplate = VisitingCardTemplate.phoneCard;
  bool _isPlayingAudio = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            _buildTopAppBar(context),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Verified Artisan Identity B2B Banner
                    _buildIdentityBanner(),
                    const SizedBox(height: 12.0),

                    // Add Your Craft Story by Voice CTA
                    _buildVoiceStoryCTA(),
                    const SizedBox(height: 14.0),

                    // Central Digital Visiting Card (Artisan Passport)
                    _buildDigitalVisitingCard(),
                    const SizedBox(height: 20.0),

                    // Quick Sharing Section
                    _buildQuickSharingSection(),
                    const SizedBox(height: 22.0),

                    // Visiting Card Formats Section
                    _buildVisitingCardFormatsSection(),
                    const SizedBox(height: 18.0),

                    // Primary Action Button
                    _buildShareDigitalCardCTA(),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),

            // Bottom 4-Tab Navigation Bar
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFDFB),
        border: Border(
          bottom: BorderSide(color: Color(0xFFEADFD6), width: 1.0),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: widget.onBack ?? () => Navigator.maybePop(context),
            icon: const Icon(Icons.arrow_back, color: Color(0xFF221C19), size: 22.0),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32.0, minHeight: 32.0),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Digital Visiting Card',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF221C19),
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 1.0),
                Row(
                  children: [
                    Container(
                      width: 6.0,
                      height: 6.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2E7D32),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    const Text(
                      'Official GI Identity',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Audio Listen Button
          InkWell(
            onTap: () {
              setState(() {
                _isPlayingAudio = !_isPlayingAudio;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_isPlayingAudio
                      ? 'Playing audio artisan passport introduction...'
                      : 'Audio stopped'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFDF2EB),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: const Color(0xFFF3DFD5)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.volume_up, size: 14.0, color: Color(0xFF8C3A16)),
                  const SizedBox(width: 4.0),
                  Text(
                    _isPlayingAudio ? '|||| /' : '||||',
                    style: const TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF8C3A16),
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  const Text(
                    'Listen',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF8C3A16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          // Language
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'English',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A3228),
                ),
              ),
              Icon(Icons.arrow_drop_down, size: 16.0, color: Color(0xFF4A3228)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIdentityBanner() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6F0),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFFBE0D2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: const Color(0xFFF9EDE6),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Icon(Icons.badge_outlined, color: Color(0xFFA84318), size: 20.0),
          ),
          const SizedBox(width: 12.0),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Verified Artisan Identity for B2B Buyers',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF221C19),
                    height: 1.25,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'Share via WhatsApp, print at craft melas, or show your QR passport directly at domestic and export exhibitions.',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF6B584E),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceStoryCTA() {
    return InkWell(
      onTap: widget.onVoiceRecordStory,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: const Color(0xFF8C140E),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8C140E).withOpacity(0.25),
              blurRadius: 8.0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30.0,
              height: 30.0,
              decoration: const BoxDecoration(
                color: Color(0xFFFDF0EB),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.mic, color: Color(0xFF8C140E), size: 18.0),
            ),
            const SizedBox(width: 10.0),
            const Text(
              'Add your craft story by voice',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDigitalVisitingCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDFB),
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: const Color(0xFFE8DDD5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Brown Accent Header Bar
          Container(
            height: 6.0,
            decoration: const BoxDecoration(
              color: Color(0xFF8C4421),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // HunarSangam Artisan & GI Reg #431 Pill
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'HunarSangam',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF8C3A16),
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(width: 6.0),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7EFE9),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            'Artisan',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF7A5A4A),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: const Color(0xFFC8E6C9)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified, size: 13.0, color: Color(0xFF2E7D32)),
                          SizedBox(width: 4.0),
                          Text(
                            'GI Reg #431 – Assam Cane',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14.0),

                // Artisan Avatar & Profile Info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Image.network(
                            'https://images.unsplash.com/photo-1544816155-12df9643f363?w=300&auto=format&fit=crop&q=80',
                            width: 58.0,
                            height: 58.0,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 58.0,
                              height: 58.0,
                              color: const Color(0xFFF0DDD0),
                              child: const Icon(Icons.person, color: Color(0xFF8C3A16), size: 32.0),
                            ),
                          ),
                        ),
                        Positioned(
                          right: -3.0,
                          bottom: -3.0,
                          child: Container(
                            width: 18.0,
                            height: 18.0,
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E7D32),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2.0),
                            ),
                            child: const Icon(Icons.check, size: 11.0, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Ramu Kumar',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF221C19),
                                ),
                              ),
                              const SizedBox(width: 6.0),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFDF2EB),
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(color: const Color(0xFFF5D8CA)),
                                ),
                                child: const Text(
                                  'GI Certified',
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFFA84318),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2.0),
                          const Text(
                            'Master Craftsman • 3rd Gen Weaver',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF6B584E),
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          const Row(
                            children: [
                              Icon(Icons.location_on, size: 12.0, color: Color(0xFF8C3A16)),
                              SizedBox(width: 2.0),
                              Text(
                                'Assam & Barabanki Weavers Guild',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  color: Color(0xFF7A685F),
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

                // Award & Verification Badges
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF4EE),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: const Color(0xFFF0DFD3)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('🏆', style: TextStyle(fontSize: 11.0)),
                          SizedBox(width: 4.0),
                          Text(
                            'National Merit Awardee 2019',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF7A4A28),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: const Color(0xFFC8E6C9)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('🌱', style: TextStyle(fontSize: 11.0)),
                          SizedBox(width: 4.0),
                          Text(
                            'Fair Wage Certified',
                            style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14.0),

                // Stylized QR Code Box
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      color: const Color(0xFFDCCEC4),
                      width: 1.5,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Stylized QR Graphic
                      _buildStylizedQRGraphic(),
                      const SizedBox(height: 12.0),
                      const Text(
                        'Scan to view live catalog, audio story & verified bulk pricing',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF221C19),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 3.0),
                      const Text(
                        'Instant B2B Buyer direct connect via HunarSangam',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10.5,
                          color: Color(0xFF7A685F),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12.0),

                // 3 Metrics Bar
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDF5EE),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: const Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '8 Types',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF8C3A16),
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              'Verified Crafts',
                              style: TextStyle(fontSize: 10.0, color: Color(0xFF7A685F), fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                        child: VerticalDivider(color: Color(0xFFEADFD6), thickness: 1.0),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '250 pcs/mo',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF221C19),
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              'Bulk Capacity',
                              style: TextStyle(fontSize: 10.0, color: Color(0xFF7A685F), fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24.0,
                        child: VerticalDivider(color: Color(0xFFEADFD6), thickness: 1.0),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '100%',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              'On-Time Dispatch',
                              style: TextStyle(fontSize: 10.0, color: Color(0xFF7A685F), fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),

                // Card Bottom ID and GI Verified
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '🪪 ID:  HS-IND-AS-0431-RK',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 10.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF6B584E),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.shield_outlined, size: 13.0, color: Color(0xFF2E7D32)),
                          SizedBox(width: 3.0),
                          Text(
                            'Govt. GI Verified',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2E7D32),
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
        ],
      ),
    );
  }

  Widget _buildStylizedQRGraphic() {
    return Container(
      width: 140.0,
      height: 140.0,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Simulated Stylized 2D QR Pattern with brand colors
          CustomPaint(
            size: const Size(124.0, 124.0),
            painter: _StylizedQRPainter(),
          ),
          // Center Seed/Leaf Craft Node
          Container(
            width: 28.0,
            height: 28.0,
            decoration: BoxDecoration(
              color: const Color(0xFF8C3A16),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.0),
            ),
            child: const Center(
              child: Text(
                '🌿',
                style: TextStyle(fontSize: 13.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickSharingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'QUICK SHARING',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.8,
            color: Color(0xFF6B584E),
          ),
        ),
        const SizedBox(height: 10.0),

        // Share on WhatsApp
        InkWell(
          onTap: widget.onShareWhatsApp,
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: const Color(0xFF25D366),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF25D366).withOpacity(0.25),
                  blurRadius: 6.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.send_rounded, color: Colors.white, size: 18.0),
                SizedBox(width: 8.0),
                Text(
                  'Share on WhatsApp',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10.0),

        // Download PDF & Copy Link
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: widget.onDownloadPdf,
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 11.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF5EE),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: const Color(0xFFEADFD6)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.download, size: 16.0, color: Color(0xFF8C3A16)),
                      SizedBox(width: 6.0),
                      Text(
                        'Download PDF / Print',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A3228),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: InkWell(
                onTap: widget.onCopyLink,
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 11.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF5EE),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: const Color(0xFFEADFD6)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.link, size: 16.0, color: Color(0xFF8C3A16)),
                      SizedBox(width: 6.0),
                      Text(
                        'Copy Profile Link',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A3228),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),

        // Add to Apple / Google Wallet
        InkWell(
          onTap: widget.onAddToWallet,
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 11.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: const Color(0xFFEADFD6)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_balance_wallet_outlined, size: 16.0, color: Color(0xFF8C3A16)),
                SizedBox(width: 8.0),
                Text(
                  'Add to Apple / Google Wallet',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4A3228),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVisitingCardFormatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Visiting Card Formats',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w900,
                color: Color(0xFF221C19),
              ),
            ),
            Text(
              '3 Templates Ready',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8C3A16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),

        // Option 1: Digital Phone Card
        _buildFormatOptionCard(
          template: VisitingCardTemplate.phoneCard,
          icon: Icons.smartphone,
          title: 'Digital Phone Card',
          subtitle: 'Optimized for WhatsApp status & direct phone scans',
          isSelected: _selectedTemplate == VisitingCardTemplate.phoneCard,
        ),
        const SizedBox(height: 8.0),

        // Option 2: Printable Stall Standee (A4 QR)
        _buildFormatOptionCard(
          template: VisitingCardTemplate.stallStandee,
          icon: Icons.storefront_outlined,
          title: 'Printable Stall Standee (A4 QR)',
          subtitle: 'For Shilp Melas, Dastkar exhibitions & trade desks',
          badgeText: 'Print A4',
          isSelected: _selectedTemplate == VisitingCardTemplate.stallStandee,
        ),
        const SizedBox(height: 8.0),

        // Option 3: Packaging Hang Tag (Mini QR)
        _buildFormatOptionCard(
          template: VisitingCardTemplate.packagingTag,
          icon: Icons.label_outline,
          title: 'Packaging Hang Tag (Mini QR)',
          subtitle: 'Attach with dispatched cane & bamboo handicraft lots',
          badgeText: 'Batch (50)',
          isSelected: _selectedTemplate == VisitingCardTemplate.packagingTag,
        ),
      ],
    );
  }

  Widget _buildFormatOptionCard({
    required VisitingCardTemplate template,
    required IconData icon,
    required String title,
    required String subtitle,
    String? badgeText,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTemplate = template;
        });
      },
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFFBF8) : Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: isSelected ? const Color(0xFF8C3A16) : const Color(0xFFEADFD6),
            width: isSelected ? 1.8 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 38.0,
              height: 38.0,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF8C3A16) : const Color(0xFFFDF4EE),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : const Color(0xFF8C3A16),
                size: 20.0,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF221C19),
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11.0,
                      color: Color(0xFF7A685F),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            if (isSelected)
              Container(
                width: 20.0,
                height: 20.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF8C3A16),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 13.0, color: Colors.white),
              )
            else if (badgeText != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF4EE),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  badgeText,
                  style: const TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF8C3A16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareDigitalCardCTA() {
    return InkWell(
      onTap: widget.onShareCard,
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        decoration: BoxDecoration(
          color: const Color(0xFF8C3A16),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8C3A16).withOpacity(0.3),
              blurRadius: 8.0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.share, color: Colors.white, size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'Share Digital Card Now',
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFEADFD6), width: 1.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(icon: Icons.storefront_outlined, label: 'Home', index: 0, isSelected: false),
          _buildNavItem(icon: Icons.palette_outlined, label: 'Products', index: 1, isSelected: false),
          _buildNavItem(icon: Icons.receipt_long_outlined, label: 'Orders', index: 2, isSelected: false),
          _buildNavItem(icon: Icons.people_outline, label: 'Collaborate', index: 3, isSelected: false),
          _buildNavItem(icon: Icons.person, label: 'Profile', index: 4, isSelected: true),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        if (widget.onBottomNavTapped != null) {
          widget.onBottomNavTapped!(index);
        }
      },
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFDECE2) : Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20.0,
              color: isSelected ? const Color(0xFF8C3A16) : const Color(0xFF7A685F),
            ),
            const SizedBox(height: 2.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                color: isSelected ? const Color(0xFF8C3A16) : const Color(0xFF7A685F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StylizedQRPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final darkPaint = Paint()..color = const Color(0xFF221C19);
    final rustPaint = Paint()..color = const Color(0xFF8C3A16);

    final w = size.width;
    final h = size.height;

    // Corner Finder Patterns (Top-Left, Top-Right, Bottom-Left)
    _drawFinderPattern(canvas, 0, 0, 36, rustPaint, darkPaint);
    _drawFinderPattern(canvas, w - 36, 0, 36, rustPaint, darkPaint);
    _drawFinderPattern(canvas, 0, h - 36, 36, rustPaint, darkPaint);

    // Decorative Data Blocks
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(42, 6, 20, 10), const Radius.circular(2)),
      darkPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(68, 6, 14, 18), const Radius.circular(2)),
      rustPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(42, 22, 18, 12), const Radius.circular(2)),
      darkPaint,
    );

    // Bottom Right Blocks
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w - 34, h - 34, 34, 34), const Radius.circular(4)),
      darkPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(42, h - 28, 24, 12), const Radius.circular(2)),
      rustPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(w - 48, 44, 16, 24), const Radius.circular(2)),
      darkPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(12, 44, 18, 14), const Radius.circular(2)),
      darkPaint,
    );
  }

  void _drawFinderPattern(Canvas canvas, double x, double y, double s, Paint outer, Paint inner) {
    // Outer rounded box
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(x, y, s, s), const Radius.circular(6)),
      outer,
    );
    // Inner white cutout
    final whitePaint = Paint()..color = Colors.white;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(x + 5, y + 5, s - 10, s - 10), const Radius.circular(4)),
      whitePaint,
    );
    // Center dot
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(x + 10, y + 10, s - 20, s - 20), const Radius.circular(3)),
      inner,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
