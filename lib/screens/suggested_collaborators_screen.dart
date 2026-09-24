// lib/screens/suggested_collaborators_screen.dart
import 'package:flutter/material.dart';
import '../models/onboarding_state.dart';
import '../widgets/artisan_bottom_nav_bar.dart';

/// Screen 26: Suggested Collaborators matching 'o5 - suggested colloborater from page order updation page.png'
class SuggestedCollaboratorsScreen extends StatefulWidget {
  final OnboardingState? state;
  final VoidCallback? onBack;
  final Function(int)? onNavigateTab;

  const SuggestedCollaboratorsScreen({
    super.key,
    this.state,
    this.onBack,
    this.onNavigateTab,
  });

  @override
  State<SuggestedCollaboratorsScreen> createState() =>
      _SuggestedCollaboratorsScreenState();
}

class _SuggestedCollaboratorsScreenState
    extends State<SuggestedCollaboratorsScreen> {
  String _selectedLanguage = 'हिंदी';
  bool _isPlayingAllAudio = false;
  bool _isPlayingRameshAudio = false;
  bool _isPlayingSohanAudio = false;
  bool _sohanInviteSent = true;
  bool _rameshInviteSheetOpen = true;
  bool _rameshInviteSent = false;
  bool _meeraInviteSent = false;
  int _currentBottomNavIndex = 2; // Orders tab active

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                msg,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF5F0),
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
                    // 1. Active Order Card (#HS-8841)
                    _buildActiveOrderCard(),

                    const SizedBox(height: 18.0),

                    // 2. Section Header (Suggested for Your Order + Listen All)
                    _buildSectionHeader(),

                    const SizedBox(height: 14.0),

                    // 3. Artisan Card 1: Ramesh Kumar
                    _buildRameshKumarCard(),

                    const SizedBox(height: 14.0),

                    // 4. Artisan Card 2: Sohan Patel
                    _buildSohanPatelCard(),

                    const SizedBox(height: 14.0),

                    // 5. Artisan Card 3: Meera Bai
                    _buildMeeraBaiCard(),

                    const SizedBox(height: 14.0),

                    // 6. Expandable Invite Confirmation Card (Invite Ramesh to collaborate?)
                    if (_rameshInviteSheetOpen) _buildInviteRameshSheet(),

                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            ),

            // Bottom Navigation Bar
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  /// 1. Top App Bar matching reference exactly
  Widget _buildTopAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: const BoxDecoration(
        color: Color(0xFFFAF5F0),
        border: Border(
          bottom: BorderSide(color: Color(0xFFEADFD6), width: 1.0),
        ),
      ),
      child: Row(
        children: [
          // Back Arrow Button
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF2D2421), size: 24),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              if (widget.onBack != null) {
                widget.onBack!();
              } else {
                Navigator.of(context).maybePop();
              }
            },
          ),
          const SizedBox(width: 12.0),

          // Title & Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'Suggested Artisans',
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF221C19),
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(height: 1.0),
                Text(
                  'Artisans who can help fulfill this order',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF7C685E),
                  ),
                ),
              ],
            ),
          ),

          // Language Selector Pill
          Container(
            height: 32,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF6EDE6),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: const Color(0xFFE5D7CD), width: 1.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedLanguage,
                icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF4E382E), size: 18),
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF4E382E),
                ),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _selectedLanguage = val);
                    _showSnack('भाषा बदलकर $_selectedLanguage की गई');
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: 'हिंदी',
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('文A ', style: TextStyle(fontSize: 10, color: Color(0xFF7C3F24))),
                        Text('हिंदी'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'English',
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: 'অসমীয়া',
                    child: Text('অসমীয়া'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8.0),

          // Notification Bell
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF3A2A22), size: 24),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              _showSnack('🔔 कोई नया नोटिफिकेशन नहीं है');
            },
          ),
        ],
      ),
    );
  }

  /// 2. Active Order Card (#HS-8841)
  Widget _buildActiveOrderCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDFB),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFF0E2D8), width: 1.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Order Info Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Craft Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  width: 54.0,
                  height: 54.0,
                  color: const Color(0xFFEADFD6),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=300&q=80',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.inventory_2, color: Color(0xFF7C3F24)),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),

              // Order Title & Tag
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'ACTIVE ORDER #HS-8841',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFFB84D20),
                            letterSpacing: 0.3,
                          ),
                        ),
                        // Need Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFDFF4E5),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: const Color(0xFFC6E7D0), width: 1.0),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.group_add, size: 11, color: Color(0xFF1B7339)),
                              SizedBox(width: 4),
                              Text(
                                'Need 20 pcs',
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1B7339),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3.0),
                    const Text(
                      'Bamboo Handwoven Basket',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF221C19),
                      ),
                    ),
                    const SizedBox(height: 3.0),
                    Row(
                      children: const [
                        Icon(Icons.storefront_outlined, size: 13, color: Color(0xFF705A4E)),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Bulk Buyer: Heritage Handcrafts Pvt. Ltd.',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF705A4E),
                            ),
                            overflow: TextOverflow.ellipsis,
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
          const Divider(height: 1.0, color: Color(0xFFF2E6DC)),
          const SizedBox(height: 12.0),

          // 3 Metric Blocks Row
          Row(
            children: [
              // Required
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: const Color(0xFFEFE4DA), width: 1.0),
                  ),
                  child: Column(
                    children: const [
                      Text(
                        'Required',
                        style: TextStyle(fontSize: 10.5, color: Color(0xFF7E6A5F), fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        '50 pcs',
                        style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: Color(0xFF221C18)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),

              // Capacity Gap (Highlighted in Soft Pink / Coral)
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDF0ED),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: const Color(0xFFF8D0C7), width: 1.0),
                  ),
                  child: Column(
                    children: const [
                      Text(
                        'Capacity Gap',
                        style: TextStyle(fontSize: 10.5, color: Color(0xFFAD3C27), fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        '20 pcs',
                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w900, color: Color(0xFFC73820)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),

              // Deadline
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: const Color(0xFFEFE4DA), width: 1.0),
                  ),
                  child: Column(
                    children: const [
                      Text(
                        'Deadline',
                        style: TextStyle(fontSize: 10.5, color: Color(0xFF7E6A5F), fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        '28 Sep 2026',
                        style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: Color(0xFF221C18)),
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

  /// 3. Section Header (Suggested for Your Order + Listen All)
  Widget _buildSectionHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Title & Hindi subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Suggested for Your Order',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E1815),
                  letterSpacing: -0.3,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                'आपके ऑर्डर के लिए उपयुक्त कारीगर',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF78645A),
                ),
              ),
            ],
          ),
        ),

        // 3 Verified Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: const Color(0xFFEFE4DC),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '3',
                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w900, color: Color(0xFF5C493E)),
              ),
              Text(
                'Verified',
                style: TextStyle(fontSize: 8.5, fontWeight: FontWeight.w700, color: Color(0xFF5C493E)),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8.0),

        // Listen All Button
        InkWell(
          onTap: () {
            setState(() => _isPlayingAllAudio = !_isPlayingAllAudio);
            _showSnack(_isPlayingAllAudio ? '🔊 सभी कारीगरों का विवरण सुनाया जा रहा है...' : 'ऑडियो रोका गया');
          },
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFBF0E8),
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: const Color(0xFFEAD5C8), width: 1.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _isPlayingAllAudio ? Icons.pause_circle_filled : Icons.volume_up_outlined,
                  size: 15,
                  color: const Color(0xFF8C3A16),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Listen\nAll',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF8C3A16),
                    height: 1.1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 4. Artisan Card 1: Ramesh Kumar (Full detail match)
  Widget _buildRameshKumarCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0xFFECDED4), width: 1.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar + Name + Rating
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar with verified badge
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      color: const Color(0xFFE5D7CD),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&q=80',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.person, color: Color(0xFF7C3F24)),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: const Icon(Icons.check_circle, size: 14, color: Color(0xFF15803D)),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12.0),

              // Name, Craft & Location
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ramesh Kumar',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E1815),
                          ),
                        ),
                        // Star Rating Pill
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDF4EE),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: const Color(0xFFF2DFD2), width: 1.0),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, size: 12, color: Color(0xFFE67E22)),
                              SizedBox(width: 3),
                              Text(
                                '4.9',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF554136),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2.0),
                    const Text(
                      'Master Bamboo Craftsman • 8 yrs exp',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6B564B),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Row(
                      children: const [
                        Icon(Icons.near_me_outlined, size: 12, color: Color(0xFF6B564B)),
                        SizedBox(width: 3),
                        Text(
                          'Barpeta, Assam (Nearby • 6 km away)',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B564B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10.0),

          // Badges Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF5E5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: const Color(0xFFC1E8CD), width: 1.0),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.inventory_2_outlined, size: 12, color: Color(0xFF1B7439)),
                    SizedBox(width: 4),
                    Text(
                      'Available: 20 pieces',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1B7439),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF4ED),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: const Color(0xFFEFE1D6), width: 1.0),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.timer_outlined, size: 12, color: Color(0xFF7A4529)),
                    SizedBox(width: 4),
                    Text(
                      'Fast turnaround',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF7A4529),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10.0),

          // Listen to Artisan Details Audio Bar
          InkWell(
            onTap: () {
              setState(() => _isPlayingRameshAudio = !_isPlayingRameshAudio);
              _showSnack(_isPlayingRameshAudio ? '🎙️ रमेश कुमार का परिचय बज रहा है (0:38)' : 'ऑडियो रोका गया');
            },
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 9.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF6F0),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: const Color(0xFFF4DDD0), width: 1.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.mic_none, size: 15, color: Color(0xFF8C3A16)),
                      SizedBox(width: 6),
                      Text(
                        'Listen to Artisan Details',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF7C391C),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '(0:38)',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF9B634A),
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    _isPlayingRameshAudio ? Icons.pause_circle_filled : Icons.play_circle_fill,
                    size: 20,
                    color: const Color(0xFF8C3A16),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12.0),

          // Recent Bamboo Craft Work Gallery
          const Text(
            'Recent Bamboo Craft Work:',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF342821),
            ),
          ),
          const SizedBox(height: 6.0),
          Row(
            children: [
              _buildGalleryImage('https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=300&q=80'),
              const SizedBox(width: 8.0),
              _buildGalleryImage('https://images.unsplash.com/photo-1607344645866-009c320c5ab8?auto=format&fit=crop&w=300&q=80'),
              const SizedBox(width: 8.0),
              _buildGalleryImage('https://images.unsplash.com/photo-1544816155-12df9643f363?auto=format&fit=crop&w=300&q=80'),
            ],
          ),

          const SizedBox(height: 12.0),

          // Why Ramesh is Suited Box
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF9F5),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: const Color(0xFFF2DACB), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  children: [
                    Icon(Icons.thumb_up_alt_outlined, size: 14, color: Color(0xFF9C411B)),
                    SizedBox(width: 6),
                    Text(
                      'Why Ramesh is suited for this order:',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF9C411B),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
                _BulletCheck(text: 'Makes identical Assam bamboo weave baskets'),
                SizedBox(height: 4.0),
                _BulletCheck(text: 'Has full capacity needed (20 pcs ready for weaving)'),
                SizedBox(height: 4.0),
                _BulletCheck(text: 'Can finish comfortably before 28 Sept deadline'),
              ],
            ),
          ),

          const SizedBox(height: 12.0),

          // Action Buttons: View Profile + Invite to Collaborate
          Row(
            children: [
              Expanded(
                flex: 4,
                child: OutlinedButton(
                  onPressed: () {
                    _showSnack('👤 रमेश कुमार का प्रोफाइल देखा जा रहा है');
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFFAF5F1),
                    side: const BorderSide(color: Color(0xFFD5C4B8), width: 1.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    padding: const EdgeInsets.symmetric(vertical: 11.0),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_outline, size: 15, color: Color(0xFF2A201B)),
                      SizedBox(width: 4),
                      Text(
                        'View Profile',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2A201B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                flex: 5,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _rameshInviteSheetOpen = true;
                    });
                    _showSnack('🤝 रमेश कुमार को आमंत्रण फॉर्म खोला गया');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8C3A16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    padding: const EdgeInsets.symmetric(vertical: 11.0),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.handshake_outlined, size: 15, color: Colors.white),
                      SizedBox(width: 5),
                      Text(
                        'Invite to Collaborate',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
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

  Widget _buildGalleryImage(String url) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            color: const Color(0xFFEBE0D8),
            child: Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.photo, color: Color(0xFF8C3A16)),
            ),
          ),
        ),
      ),
    );
  }

  /// 5. Artisan Card 2: Sohan Patel (with Invite Sent status)
  Widget _buildSohanPatelCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0xFFECDED4), width: 1.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar + Name + Rating
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      color: const Color(0xFFE5D7CD),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=200&q=80',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.person, color: Color(0xFF7C3F24)),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: const Icon(Icons.check_circle, size: 14, color: Color(0xFF15803D)),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12.0),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sohan Patel',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E1815),
                          ),
                        ),
                        // Rating
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDF4EE),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: const Color(0xFFF2DFD2), width: 1.0),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, size: 12, color: Color(0xFFE67E22)),
                              SizedBox(width: 3),
                              Text(
                                '4.8',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF554136),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2.0),
                    const Text(
                      'Bamboo & Cane Weaver • 12 yrs exp',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6B564B),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Row(
                      children: const [
                        Icon(Icons.near_me_outlined, size: 12, color: Color(0xFF6B564B)),
                        SizedBox(width: 3),
                        Text(
                          'Kamrup, Assam (14 km away)',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B564B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10.0),

          // Badges Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF5E5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: const Color(0xFFC1E8CD), width: 1.0),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.inventory_2_outlined, size: 12, color: Color(0xFF1B7439)),
                    SizedBox(width: 4),
                    Text(
                      'Available: 25 pieces',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1B7439),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF4ED),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: const Color(0xFFEFE1D6), width: 1.0),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.local_offer_outlined, size: 12, color: Color(0xFF7A4529)),
                    SizedBox(width: 4),
                    Text(
                      'Prior 5★ Cluster Partner',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF7A4529),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10.0),

          // Audio Bio with Weave Thumbnail
          InkWell(
            onTap: () {
              setState(() => _isPlayingSohanAudio = !_isPlayingSohanAudio);
              _showSnack(_isPlayingSohanAudio ? '🎙️ सोहन पटेल का बायो बज रहा है (असमिया & हिंदी)' : 'ऑडियो रोका गया');
            },
            borderRadius: BorderRadius.circular(12.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF6F0),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: const Color(0xFFF4DDD0), width: 1.0),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      width: 42.0,
                      height: 42.0,
                      color: const Color(0xFFEADFD6),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=150&q=80',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Row(
                          children: [
                            Icon(Icons.mic_none, size: 14, color: Color(0xFF8C3A16)),
                            SizedBox(width: 4),
                            Text(
                              'Artisan Audio Bio',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF342821),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          'Speaks Assamese & Hindi',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF7A665C),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _isPlayingSohanAudio ? Icons.pause_circle_filled : Icons.play_circle_fill,
                    size: 22,
                    color: const Color(0xFF8C3A16),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10.0),

          // Why Suited
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF9F5),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: const Color(0xFFF2DACB), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _BulletCheck(text: 'Master weaver in Assam split bamboo technique'),
                SizedBox(height: 4.0),
                _BulletCheck(text: 'High monthly workshop output capacity'),
              ],
            ),
          ),

          const SizedBox(height: 10.0),

          // Status: Invite Sent to Sohan
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF5F0),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: const Color(0xFFEBDCCE), width: 1.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8.0,
                      height: 8.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1B7339),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Invite Sent to Sohan',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2C221C),
                          ),
                        ),
                        SizedBox(height: 1.0),
                        Text(
                          'Awaiting confirmation via SMS / App',
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF7A665C),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    setState(() => _sohanInviteSent = !_sohanInviteSent);
                    _showSnack('सोहन पटेल का इनवाइट रद्द किया गया');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Cancel Invite',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFA83B20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 6. Artisan Card 3: Meera Bai
  Widget _buildMeeraBaiCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0xFFECDED4), width: 1.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      color: const Color(0xFFE5D7CD),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(Icons.person, color: Color(0xFF7C3F24)),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: const Icon(Icons.check_circle, size: 14, color: Color(0xFF15803D)),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Meera Bai',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1E1815),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFDF4EE),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: const Color(0xFFF2DFD2), width: 1.0),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, size: 12, color: Color(0xFFE67E22)),
                              SizedBox(width: 3),
                              Text(
                                '4.9',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF554136),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2.0),
                    const Text(
                      'Artisan Weaver • 6 yrs exp',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF6B564B),
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Row(
                      children: const [
                        Icon(Icons.near_me_outlined, size: 12, color: Color(0xFF6B564B)),
                        SizedBox(width: 3),
                        Text(
                          'Hajo, Assam (9 km away)',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF6B564B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10.0),

          // Badges
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFDFF5E5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: const Color(0xFFC1E8CD), width: 1.0),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.inventory_2_outlined, size: 12, color: Color(0xFF1B7439)),
                    SizedBox(width: 4),
                    Text(
                      'Available: 15 pieces',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1B7439),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF4ED),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: const Color(0xFFEFE1D6), width: 1.0),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified_user_outlined, size: 12, color: Color(0xFF7A4529)),
                    SizedBox(width: 4),
                    Text(
                      'GI Craft Certified',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF7A4529),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10.0),

          // Why Suited
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF9F5),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: const Color(0xFFF2DACB), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _BulletCheck(text: 'Exact GI craft certification match'),
                SizedBox(height: 4.0),
                _BulletCheck(text: 'Fast delivery track record in cluster projects'),
              ],
            ),
          ),

          const SizedBox(height: 12.0),

          // Action Buttons
          Row(
            children: [
              Expanded(
                flex: 4,
                child: OutlinedButton(
                  onPressed: () {
                    _showSnack('👤 मीरा बाई का प्रोफाइल देखा जा रहा है');
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFFAF5F1),
                    side: const BorderSide(color: Color(0xFFD5C4B8), width: 1.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    padding: const EdgeInsets.symmetric(vertical: 11.0),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_outline, size: 15, color: Color(0xFF2A201B)),
                      SizedBox(width: 4),
                      Text(
                        'View Profile',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2A201B),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                flex: 5,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _meeraInviteSent = true;
                    });
                    _showSnack('🤝 मीरा बाई को आमंत्रण भेजा गया');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8C3A16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    padding: const EdgeInsets.symmetric(vertical: 11.0),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.handshake_outlined, size: 15, color: Colors.white),
                      SizedBox(width: 5),
                      Text(
                        'Invite to Collaborate',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
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

  /// 7. Expandable Invite Confirmation Card ("Invite Ramesh to collaborate?")
  Widget _buildInviteRameshSheet() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDFB),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFE5CDBE), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with handshake icon + Hindi subtitle + Chevron
          Row(
            children: [
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF1EB),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: const Color(0xFFF0D5C7), width: 1.0),
                ),
                child: const Icon(Icons.handshake_outlined, size: 20, color: Color(0xFF8C3A16)),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Invite Ramesh to collaborate?',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF221B18),
                      ),
                    ),
                    SizedBox(height: 1.0),
                    Text(
                      'रमेश कुमार को इस ऑर्डर में जोड़ें',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7E6A5F),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF8C3A16)),
                onPressed: () {
                  setState(() => _rameshInviteSheetOpen = !_rameshInviteSheetOpen);
                },
              ),
            ],
          ),

          const SizedBox(height: 12.0),

          // Order Details Summary Box
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF6F2),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: const Color(0xFFEFE3D8), width: 1.0),
            ),
            child: Column(
              children: [
                _buildSummaryRow('Order Item:', 'Bamboo Handwoven Basket', isBold: true),
                const SizedBox(height: 6.0),
                _buildSummaryRow('Quantity Needed:', '20 pieces', valueColor: const Color(0xFFC43820), isBold: true),
                const SizedBox(height: 6.0),
                _buildSummaryRow('Delivery Deadline:', '28 September 2026', isBold: true),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(height: 1.0, color: Color(0xFFEFE3D8)),
                ),
                _buildSummaryRow(
                  'Escrow Partner Share:',
                  '₹9,000',
                  valueColor: const Color(0xFF177D3D),
                  valueFontSize: 14.0,
                  isBold: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 10.0),

          // Escrow Trust Protocol Box
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFBF6F0),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: const Color(0xFFF0DDD1), width: 1.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.lock_outline, size: 14, color: Color(0xFF1B7339)),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'Escrow funds will be held securely in the HunarSangam craft trust account until both artisans inspect and deliver.',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF59453B),
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14.0),

          // Bottom Action Buttons: Cancel + Send Invite
          Row(
            children: [
              Expanded(
                flex: 4,
                child: OutlinedButton(
                  onPressed: () {
                    setState(() => _rameshInviteSheetOpen = false);
                    _showSnack('आमंत्रण रद्द किया गया');
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFFFAF5F1),
                    side: const BorderSide(color: Color(0xFFD5C4B8), width: 1.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2A201B),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                flex: 6,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _rameshInviteSent = true;
                      _rameshInviteSheetOpen = false;
                    });
                    _showSnack('🚀 रमेश कुमार को ₹9,000 एस्क्रो आमंत्रण भेज दिया गया!');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8C3A16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.send_outlined, size: 16, color: Colors.white),
                      SizedBox(width: 6),
                      Text(
                        'Send Invite',
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    Color? valueColor,
    double valueFontSize = 12.0,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
            color: Color(0xFF7A665C),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: valueFontSize,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w600,
            color: valueColor ?? const Color(0xFF221B18),
          ),
        ),
      ],
    );
  }

  /// 8. Bottom Navigation Bar matching 5 tabs in image
  Widget _buildBottomNavigationBar() {
    return ArtisanBottomNavBar(
      currentIndex: _currentBottomNavIndex,
      onTap: (idx) {
        setState(() => _currentBottomNavIndex = idx);
        if (widget.onNavigateTab != null) {
          widget.onNavigateTab!(idx);
        }
      },
    );
  }
}

class _BulletCheck extends StatelessWidget {
  final String text;

  const _BulletCheck({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.check_circle_outline, size: 14, color: Color(0xFF15803D)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: Color(0xFF362A24),
              height: 1.3,
            ),
          ),
        ),
      ],
    );
  }
}
