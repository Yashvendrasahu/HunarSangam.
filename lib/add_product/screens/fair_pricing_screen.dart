// lib/add_product/screens/fair_pricing_screen.dart

import 'package:flutter/material.dart';
import '../models/product_draft.dart';
import '../widgets/artisan_bottom_navigation.dart';
import '../../services/hardware_service.dart';
import '../../widgets/craft_image.dart';

/// Screen matching 'p7— Fair Pricing Assistant.png'
/// Know Your Fair Price • Step 3 of 3 • Price Intelligence
class FairPricingScreen extends StatefulWidget {
  final ProductDraft draft;
  final ValueChanged<double> onLockPrice;
  final VoidCallback onBack;
  final Function(int)? onNavigateTab;

  const FairPricingScreen({
    super.key,
    required this.draft,
    required this.onLockPrice,
    required this.onBack,
    this.onNavigateTab,
  });

  @override
  State<FairPricingScreen> createState() => _FairPricingScreenState();
}

class _FairPricingScreenState extends State<FairPricingScreen> {
  double _rawMaterials = 85.0;
  double _artisanLabor = 120.0;
  double _overhead = 25.0;
  double _profit = 50.0;

  double get _totalCost => _rawMaterials + _artisanLabor + _overhead;
  double get _recommendedPrice => _totalCost + _profit; // ₹280

  bool _isPlayingAudio = false;

  void _listenAudioGuide() async {
    if (_isPlayingAudio) {
      await HardwareService().stopAudio();
      setState(() => _isPlayingAudio = false);
    } else {
      setState(() => _isPlayingAudio = true);
      await HardwareService().speakText(
        'Based on 3.5 hours of artisan weaving and raw material cost, your recommended fair price is 280 rupees per piece, ensuring a dignified daily wage.',
        onDone: () {
          if (mounted) setState(() => _isPlayingAudio = false);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Color(0xFF1F1612)),
                    onPressed: widget.onBack,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text(
                          'Know Your Fair Price',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1F1612),
                          ),
                        ),
                        SizedBox(height: 1),
                        Text(
                          'Step 3 of 3 • Price Intelligence',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFBA4B20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _listenAudioGuide,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6EAE2),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color(0xFFE5D5CB)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _isPlayingAudio ? Icons.stop : Icons.volume_up,
                            size: 15.0,
                            color: const Color(0xFF8C3A16),
                          ),
                          const SizedBox(width: 4.0),
                          const Text(
                            'Listen',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF8C3A16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Price Breakdown
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AI Cost & Wage Calculator Banner
                    Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF2EC),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color(0xFFECDACF)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3DCCE),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: const Icon(Icons.calculate_outlined, color: Color(0xFF9C3C18), size: 20),
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
                                      'AI Cost & Wage\nCalculator',
                                      style: TextStyle(
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF221C19),
                                        height: 1.2,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD4EDDA),
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: const Text(
                                        'Active',
                                        style: TextStyle(
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF1E6B24),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6.0),
                                const Text(
                                  'Ensuring you never sell below fair living wage while staying competitive for bulk B2B buyers.',
                                  style: TextStyle(
                                    fontSize: 11.5,
                                    color: Color(0xFF6B584E),
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12.0),

                    // Mini Product Summary Card
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(color: const Color(0xFFEADFD6)),
                      ),
                      child: Row(
                        children: [
                          CraftImage(
                            imageSource: widget.draft.photoUrl,
                            craftCategoryOrTitle: widget.draft.category.isNotEmpty ? widget.draft.category : widget.draft.title,
                            width: 60,
                            height: 44,
                            borderRadius: BorderRadius.circular(8.0),
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 12),
                                    SizedBox(width: 4),
                                    Text(
                                      'GI Certified • Assam Bamboo',
                                      style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Color(0xFF2E7D32)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Handmade Woven Bamboo Fr...',
                                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF221C19)),
                                ),
                                Text(
                                  'Cluster Code: ASM-KAM-42',
                                  style: TextStyle(fontSize: 10.5, color: const Color(0xFF8B776E)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16.0),

                    // Section Title: Interactive Cost Breakdown
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.tune, size: 16, color: Color(0xFF8C3A16)),
                            SizedBox(width: 6),
                            Text(
                              'Interactive Cost Breakdown',
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF221C19),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Tap card to edit',
                          style: TextStyle(fontSize: 11, color: Color(0xFF8B776E)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10.0),

                    // 1. Raw Materials
                    _buildCostCard(
                      icon: Icons.forest_outlined,
                      iconBg: const Color(0xFFFCEFE9),
                      iconColor: const Color(0xFF9C3C18),
                      title: 'Raw Materials',
                      subtitle: 'Treated Assam Cane ₹55 • Polish ₹30',
                      price: '₹${_rawMaterials.toInt()}',
                      actionText: 'Adjust ✎',
                      actionColor: const Color(0xFFBA4B20),
                    ),

                    const SizedBox(height: 8.0),

                    // 2. Artisan Labor & Time (with Benchmark tag)
                    _buildCostCard(
                      icon: Icons.person_outline,
                      iconBg: const Color(0xFFE8F5E9),
                      iconColor: const Color(0xFF2E7D32),
                      title: 'Artisan Labor & Time',
                      titleTag: 'Benchmark',
                      subtitle: '3.5 hours weaving @ ₹34/hr benchmark',
                      price: '₹${_artisanLabor.toInt()}',
                      actionText: 'Fair rate',
                      actionColor: const Color(0xFF2E7D32),
                      highlightBorder: true,
                    ),

                    const SizedBox(height: 8.0),

                    // 3. Cluster Overhead
                    _buildCostCard(
                      icon: Icons.lightbulb_outline,
                      iconBg: const Color(0xFFF3ECE7),
                      iconColor: const Color(0xFF6B584E),
                      title: 'Cluster Overhead',
                      subtitle: 'Tools, shared shed & transport',
                      price: '₹${_overhead.toInt()}',
                      actionText: 'Adjust ✎',
                      actionColor: const Color(0xFFBA4B20),
                    ),

                    const SizedBox(height: 8.0),

                    // 4. Fair Profit (20%)
                    _buildCostCard(
                      icon: Icons.trending_up,
                      iconBg: const Color(0xFFFEF3C7),
                      iconColor: const Color(0xFFD97706),
                      title: 'Fair Profit (20%)',
                      titleTag: 'Reinvest',
                      subtitle: 'Artisan growth & tool maintenance',
                      price: '₹${_profit.toInt()}',
                      actionText: 'Automated',
                      actionColor: const Color(0xFF6B584E),
                    ),

                    const SizedBox(height: 10.0),

                    // Voice Adjust Prompt Bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF2EC),
                        borderRadius: BorderRadius.circular(24.0),
                        border: Border.all(color: const Color(0xFFECDACF)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.mic_none, size: 18, color: Color(0xFF8C3A16)),
                          const SizedBox(width: 8.0),
                          const Expanded(
                            child: Text(
                              'Say “Increase labor to 150 rupees” or tap to',
                              style: TextStyle(fontSize: 11.5, color: Color(0xFF6B584E)),
                            ),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: Color(0xFF9C3C18),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.mic, color: Colors.white, size: 16),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14.0),

                    // Total Cost & Recommended Base Price Card
                    Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF2EC),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color(0xFFECDACF)),
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
                                    'Total Production Cost',
                                    style: TextStyle(fontSize: 11.0, color: Color(0xFF6B584E), fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '₹${_totalCost.toInt()}',
                                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w900, color: Color(0xFF221C19)),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Recommended Base Price',
                                    style: TextStyle(fontSize: 11.0, color: Color(0xFFBA4B20), fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 2),
                                  RichText(
                                    text: TextSpan(
                                      text: '₹${_recommendedPrice.toInt()}',
                                      style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w900, color: Color(0xFF9C3C18)),
                                      children: const [
                                        TextSpan(text: ' / piece', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF6B584E))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10.0),
                          Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE2F4E6),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.verified_outlined, color: Color(0xFF2E7D32), size: 18),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Fair Wage Certified • ₹780/day artisan income',
                                        style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800, color: Color(0xFF1E6B24)),
                                      ),
                                      Text(
                                        'Meets Indian Handicraft Living Standard Benchmark',
                                        style: TextStyle(fontSize: 10.0, color: Color(0xFF2E7D32)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16.0),

                    // Market Benchmark Comparison Container
                    Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color(0xFFEADFD6)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Market Benchmark Comparison',
                                style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: Color(0xFF221C19)),
                              ),
                              Icon(Icons.info_outline, size: 16, color: Color(0xFF8B776E)),
                            ],
                          ),
                          const SizedBox(height: 4.0),
                          const Text(
                            'Transparency check against local middlemen and urban commercial retail margins.',
                            style: TextStyle(fontSize: 11.0, color: Color(0xFF6B584E)),
                          ),
                          const SizedBox(height: 12.0),

                          // 3-color progress bar: Red, Green, Gray
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.0),
                            child: Row(
                              children: [
                                Expanded(flex: 3, child: Container(height: 7, color: const Color(0xFFD32F2F))),
                                Expanded(flex: 4, child: Container(height: 7, color: const Color(0xFF2E7D32))),
                                Expanded(flex: 5, child: Container(height: 7, color: const Color(0xFFD6CBC3))),
                              ],
                            ),
                          ),

                          const SizedBox(height: 14.0),

                          // Middleman offer row
                          Row(
                            children: [
                              Container(width: 7, height: 7, decoration: const BoxDecoration(color: Color(0xFFD32F2F), shape: BoxShape.circle)),
                              const SizedBox(width: 8),
                              const Expanded(
                                child: Text('Local Middleman Offer', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF221C19))),
                              ),
                              const Text('₹160', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFFD32F2F))),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(color: const Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(6)),
                                child: const Text('Exploitative', style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: Color(0xFFC62828))),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10.0),

                          // HunarSangam Living Wage row
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F5E9),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              children: [
                                Container(width: 7, height: 7, decoration: const BoxDecoration(color: Color(0xFF2E7D32), shape: BoxShape.circle)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text('HunarSangam Living\nWage', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF1E6B24), height: 1.1)),
                                      Text('Direct artisan\nempowerment', style: TextStyle(fontSize: 9.5, color: Color(0xFF2E7D32), height: 1.1)),
                                    ],
                                  ),
                                ),
                                const Text('₹250 –\n₹280', textAlign: TextAlign.right, style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w900, color: Color(0xFF1E6B24))),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                                  decoration: BoxDecoration(color: const Color(0xFF2E7D32), borderRadius: BorderRadius.circular(6)),
                                  child: const Text('Fair &\nViable', textAlign: TextAlign.center, style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.w800, color: Colors.white, height: 1.1)),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10.0),

                          // Retail Metro Market Price
                          Row(
                            children: [
                              Container(width: 7, height: 7, decoration: const BoxDecoration(color: Color(0xFF8B776E), shape: BoxShape.circle)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Retail Metro Market Price', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF221C19))),
                                    Text('Delhi, Mumbai lifestyle stores', style: TextStyle(fontSize: 9.5, color: Color(0xFF8B776E))),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text('₹650 – ₹850', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF221C19))),
                                  Text('Healthy B2B buyer margin', style: TextStyle(fontSize: 9.0, color: Color(0xFF2E7D32), fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16.0),

                    // Bottom Sticky Actions
                    Row(
                      children: [
                        SizedBox(
                          height: 48,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF3B2A22)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                            ),
                            onPressed: () {
                              _showCustomPriceDialog();
                            },
                            child: const Text('Custom', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF3B2A22))),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF9C3C18),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () => widget.onLockPrice(_recommendedPrice),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Lock Fair Price (₹280) & \nProceed', textAlign: TextAlign.center, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, height: 1.1)),
                                  SizedBox(width: 6),
                                  Icon(Icons.arrow_forward, size: 16),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8.0),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.shield_outlined, size: 12, color: Color(0xFF2E7D32)),
                          SizedBox(width: 4),
                          Text(
                            'Verified against Ministry of Textiles & Handicraft Fair Wage Index',
                            style: TextStyle(fontSize: 9.0, color: Color(0xFF6B584E)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ArtisanBottomNavigation(
        currentIndex: 1, // Products
        onTap: widget.onNavigateTab,
      ),
    );
  }

  Widget _buildCostCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    String? titleTag,
    required String subtitle,
    required String price,
    required String actionText,
    required Color actionColor,
    bool highlightBorder = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF2EC),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: highlightBorder ? const Color(0xFF2E7D32) : const Color(0xFFECDACF),
          width: highlightBorder ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: Color(0xFF221C19)),
                    ),
                    if (titleTag != null) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: titleTag == 'Benchmark' ? const Color(0xFFD4EDDA) : const Color(0xFFFFE8DC),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          titleTag,
                          style: TextStyle(
                            fontSize: 9.0,
                            fontWeight: FontWeight.w700,
                            color: titleTag == 'Benchmark' ? const Color(0xFF1E6B24) : const Color(0xFFBA4B20),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 10.5, color: Color(0xFF7A685F)),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w900, color: Color(0xFF221C19)),
              ),
              Text(
                actionText,
                style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w700, color: actionColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCustomPriceDialog() {
    double tempPrice = _recommendedPrice;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: const Text('Enter Custom Price', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('₹${tempPrice.toInt()}', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF9C3C18))),
              Slider(
                value: tempPrice,
                min: 180,
                max: 800,
                divisions: 62,
                activeColor: const Color(0xFF9C3C18),
                onChanged: (v) => setDialogState(() => tempPrice = v),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel', style: TextStyle(color: Color(0xFF6B584E))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF9C3C18)),
              onPressed: () {
                Navigator.pop(ctx);
                widget.onLockPrice(tempPrice);
              },
              child: const Text('Confirm', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
