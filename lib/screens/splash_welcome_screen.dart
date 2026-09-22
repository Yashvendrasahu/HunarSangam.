// lib/screens/splash_welcome_screen.dart

import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../widgets/top_header_bar.dart';
import '../widgets/brand_logo_card.dart';

/// Primary Splash & Entry Point Screen for HunarSangam.
/// Features a warm artisanal Indian background, subtle mandala watermark,
/// central brand squircle identity, localized language selector, and trust marker.
class SplashWelcomeScreen extends StatefulWidget {
  final VoidCallback? onGetStarted;
  final Duration autoAdvanceDuration;

  const SplashWelcomeScreen({
    super.key,
    this.onGetStarted,
    this.autoAdvanceDuration = const Duration(seconds: 5),
  });

  @override
  State<SplashWelcomeScreen> createState() => _SplashWelcomeScreenState();
}

class _SplashWelcomeScreenState extends State<SplashWelcomeScreen> {
  String _selectedLanguage = 'English';
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _startAutoAdvanceTimer();
  }

  void _startAutoAdvanceTimer() {
    if (widget.autoAdvanceDuration > Duration.zero && widget.onGetStarted != null) {
      Future.delayed(widget.autoAdvanceDuration, () {
        if (mounted && !_hasNavigated) {
          _hasNavigated = true;
          widget.onGetStarted?.call();
        }
      });
    }
  }

  void _handleManualGetStarted() {
    if (!_hasNavigated) {
      _hasNavigated = true;
      widget.onGetStarted?.call();
    }
  }

  final List<String> _availableLanguages = const [
    'English',
    'हिंदी (Hindi)',
    'ગુજરાતી (Gujarati)',
    'বাংলা (Bengali)',
    'मराठी (Marathi)',
    'தமிழ் (Tamil)',
    'తెలుగు (Telugu)',
    'ಕನ್ನಡ (Kannada)',
  ];

  void _showLanguageSelector() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFFFFFBF9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Language / भाषा चुनें',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4A3B32),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Color(0xFF6E5D53)),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _availableLanguages.length,
                    itemBuilder: (context, index) {
                      final lang = _availableLanguages[index];
                      final isSelected = _selectedLanguage == lang ||
                          (lang.startsWith(_selectedLanguage) && _selectedLanguage != 'English');

                      return ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        tileColor: isSelected ? const Color(0xFFF3E7DF) : Colors.transparent,
                        title: Text(
                          lang,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            color: isSelected ? const Color(0xFF7C3F24) : const Color(0xFF4A3B32),
                          ),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check_circle, color: Color(0xFF7C3F24))
                            : null,
                        onTap: () {
                          setState(() {
                            _selectedLanguage = lang.split(' ').first;
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.sizeOf(context);
    final bool isSmallScreen = screenSize.height < 700;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF2EE),
      body: SafeArea(
        child: Stack(
          children: [
            // Background Artisan Floral Mandala Watermark Pattern
            Positioned.fill(
              child: CustomPaint(
                painter: _MandalaWatermarkPainter(),
              ),
            ),

            // Foreground Layout Content
            Column(
              children: [
                // Top Header Bar with SIH INITIATIVE and AI Helped craft badges
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // SIH INITIATIVE badge
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3E7DF),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: const Color(0xFFE5D5CB), width: 1.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6.5,
                              height: 6.5,
                              decoration: const BoxDecoration(
                                color: Color(0xFF2E7D32),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            const Text(
                              'SIH INITIATIVE',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF5A483E),
                                letterSpacing: 0.4,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // AI Helped craft badge
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.palette_outlined, size: 14.5, color: Color(0xFF6B584E)),
                          SizedBox(width: 4.0),
                          Text(
                            'AI Helped craft',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF6B584E),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Scrollable Central Body to adapt gracefully to any screen height
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: isSmallScreen ? 12.0 : 28.0),

                          // Brand Logo Card with Squircle Border & Halo
                          const BrandLogoCard(size: 138.0),

                          SizedBox(height: isSmallScreen ? 18.0 : 28.0),

                          // Primary Brand Title
                          const Text(
                            'HunarSangam',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 34.0,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                              color: Color(0xFF7C3F24),
                              height: 1.15,
                            ),
                          ),

                          const SizedBox(height: 12.0),

                          // Subtitle Headline
                          const Text(
                            'Where Artisans Connect,\nCollaborate & Grow',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2D2421),
                              height: 1.35,
                              letterSpacing: -0.2,
                            ),
                          ),

                          const SizedBox(height: 16.0),

                          // Secondary Tagline with Bullet Dividers
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Connect',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF7B665C),
                                ),
                              ),
                              _BulletDot(),
                              Text(
                                'Collaborate',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF7B665C),
                                ),
                              ),
                              _BulletDot(),
                              Text(
                                'Create',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF7B665C),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20.0),

                          // Language Selector Pill Button
                          _LanguageSelectorButton(
                            currentLanguage: _selectedLanguage,
                            onTap: _showLanguageSelector,
                          ),

                          const SizedBox(height: 24.0),

                          // Primary "Get Started / शुरू करें" CTA Button
                          if (widget.onGetStarted != null) ...[
                            SizedBox(
                              width: double.infinity,
                              height: 54.0,
                              child: ElevatedButton(
                                onPressed: _handleManualGetStarted,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFA84318),
                                  foregroundColor: Colors.white,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Get Started • शुरू करें',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    Icon(Icons.arrow_forward_rounded, size: 20.0),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                          ],

                          // Bottom Trust Marker
                          const _TrustMarkerBadge(),

                          SizedBox(height: isSmallScreen ? 16.0 : 32.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Small circular bullet dot divider for taglines
class _BulletDot extends StatelessWidget {
  const _BulletDot();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 4.5,
        height: 4.5,
        decoration: const BoxDecoration(
          color: Color(0xFFB85324),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

/// Pill button with Globe icon, current language text, and selector icon
class _LanguageSelectorButton extends StatelessWidget {
  final String currentLanguage;
  final VoidCallback onTap;

  const _LanguageSelectorButton({
    required this.currentLanguage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDFB),
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: const Color(0xFFE5D5CB),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C3F24).withValues(alpha: 0.04),
                offset: const Offset(0, 3),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.language_rounded,
                size: 16.5,
                color: Color(0xFF5D483E),
              ),
              const SizedBox(width: 7.0),
              Text(
                currentLanguage,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A372D),
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(width: 6.0),
              const Icon(
                Icons.unfold_more_rounded,
                size: 15.0,
                color: Color(0xFF7B665C),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Trust marker badge at the bottom with verified shield/checkmark and national pride text
class _TrustMarkerBadge extends StatelessWidget {
  const _TrustMarkerBadge();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(
          Icons.verified_rounded,
          size: 15.0,
          color: Color(0xFF2E7D32), // Emerald Forest Green
        ),
        SizedBox(width: 6.0),
        Text(
          'Crafted with pride in India',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF5A483E),
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}

/// Custom painter for the delicate artisan geometric mandala radiating behind the logo
class _MandalaWatermarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width * 0.5, size.height * 0.42);
    final Paint linePaint = Paint()
      ..color = const Color(0xFFEBD8CE).withValues(alpha: 0.45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final Paint fillPetalPaint = Paint()
      ..color = const Color(0xFFF2E2D8).withValues(alpha: 0.35)
      ..style = PaintingStyle.fill;

    // Concentric guideline rings
    canvas.drawCircle(center, 90.0, linePaint);
    canvas.drawCircle(center, 140.0, linePaint);
    canvas.drawCircle(center, 190.0, linePaint);

    // 12 Petals geometric flower radiating out
    const int petals = 12;
    const double angleStep = (2 * math.pi) / petals;

    for (int i = 0; i < petals; i++) {
      final double angle = i * angleStep;
      final double nextAngle = (i + 1) * angleStep;
      final double midAngle = angle + (angleStep / 2);

      final Path petalPath = Path();
      final double innerR = 100.0;
      final double outerR = 210.0;

      final Offset pStart = Offset(
        center.dx + innerR * math.cos(angle),
        center.dy + innerR * math.sin(angle),
      );
      final Offset pTip = Offset(
        center.dx + outerR * math.cos(midAngle),
        center.dy + outerR * math.sin(midAngle),
      );
      final Offset pEnd = Offset(
        center.dx + innerR * math.cos(nextAngle),
        center.dy + innerR * math.sin(nextAngle),
      );

      petalPath.moveTo(pStart.dx, pStart.dy);
      petalPath.quadraticBezierTo(
        center.dx + (outerR * 0.85) * math.cos(angle + 0.08),
        center.dy + (outerR * 0.85) * math.sin(angle + 0.08),
        pTip.dx,
        pTip.dy,
      );
      petalPath.quadraticBezierTo(
        center.dx + (outerR * 0.85) * math.cos(nextAngle - 0.08),
        center.dy + (outerR * 0.85) * math.sin(nextAngle - 0.08),
        pEnd.dx,
        pEnd.dy,
      );
      petalPath.close();

      canvas.drawPath(petalPath, fillPetalPaint);
      canvas.drawPath(petalPath, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
