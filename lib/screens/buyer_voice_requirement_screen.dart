// lib/screens/buyer_voice_requirement_screen.dart
// 100% UI Match for 'r2- bulk — Voice-First Requirement Description.png'

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';
import '../services/hardware_service.dart';
import '../services/gemini_service.dart';

class BuyerVoiceRequirementScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onContinue;
  final VoidCallback onOpenRequirements;
  final VoidCallback onOpenDiscover;
  final VoidCallback onOpenHome;
  final VoidCallback? onOpenOrders;
  final VoidCallback? onOpenProfile;

  const BuyerVoiceRequirementScreen({
    super.key,
    required this.onBack,
    required this.onContinue,
    required this.onOpenRequirements,
    required this.onOpenDiscover,
    required this.onOpenHome,
    this.onOpenOrders,
    this.onOpenProfile,
  });

  @override
  State<BuyerVoiceRequirementScreen> createState() => _BuyerVoiceRequirementScreenState();
}

class _BuyerVoiceRequirementScreenState extends State<BuyerVoiceRequirementScreen> {
  bool _isListening = false;
  String _transcribedText =
      'Need 500 handwoven natural bamboo fruit baskets with reinforced dual-rim finish. Size approximately 10-inch diameter. Packaging required in individual biodegradable brown paper boxes with custom brand tags.';
  String _product = 'Bamboo Fruit Basket';
  String _quantity = '500 pcs';
  String _finish = 'Double-Rim Natural';
  String _packaging = 'Eco Gift Box';
  String _timeline = '18–24 Days for Crafting';

  final GeminiService _gemini = GeminiService();

  Future<void> _toggleVoiceRecording() async {
    if (_isListening) {
      await HardwareService().stopListening();
      if (mounted) setState(() => _isListening = false);
      _processAiExtraction();
      return;
    }

    setState(() {
      _isListening = true;
    });

    await HardwareService().startListening(
      onResult: (text, isFinal) {
        if (text.isNotEmpty && mounted) {
          setState(() => _transcribedText = text);
          if (isFinal) {
            setState(() => _isListening = false);
            _processAiExtraction();
          }
        }
      },
      onStopped: () {
        if (mounted) {
          setState(() => _isListening = false);
          _processAiExtraction();
        }
      },
      onError: (_) {
        if (mounted) setState(() => _isListening = false);
      },
    );
  }

  Future<void> _processAiExtraction() async {
    if (_transcribedText.isEmpty) return;
    final extracted = await _gemini.parseBuyerRequirement(
      voiceOrTextRequirement: _transcribedText,
    );
    if (mounted) {
      setState(() {
        _product = extracted['craftCategory'] ?? _product;
        _quantity = '${extracted['quantity'] ?? 500} pcs';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const bgWarm = Color(0xFFFCF9F6);
    const textDark = Color(0xFF1E1714);
    const terracotta = Color(0xFF9E401A);
    const borderBeige = Color(0xFFEDE4DC);

    return Scaffold(
      backgroundColor: bgWarm,
      appBar: AppBar(
        backgroundColor: bgWarm,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textDark, size: 22),
          onPressed: widget.onBack,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Post Bulk Requirement',
              style: TextStyle(
                color: terracotta,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
            Text(
              'Step 1 of 3: Requirement Description',
              style: TextStyle(
                color: Color(0xFF7A6D66),
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.record_voice_over, size: 14, color: Color(0xFF2E7D32)),
                SizedBox(width: 4),
                Text(
                  'AI Voice',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.translate, color: terracotta, size: 20),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🌐 Voice Recognition Language: English & Hindi (Bilingual Speech Model)'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            tooltip: 'Voice Language',
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          children: [
            // 1. Role Badge
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBF1EB),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFF3DFD5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.circle, size: 6, color: terracotta),
                    SizedBox(width: 6),
                    Text(
                      'Role: Bulk Buyer Enterprise Portal',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: terracotta,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),

            // 2. Heading
            const Text(
              'Tell us what you need',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: textDark,
                letterSpacing: -0.6,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Speak naturally in Hindi, English, or regional languages. Our platform transcribes, extracts, and matches your craft specifications.',
              style: TextStyle(
                fontSize: 13.5,
                color: Color(0xFF70645E),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 20),

            // 3. Central Recording Card
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFFBF4ED),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFEFE4DA)),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _toggleVoiceRecording,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            color: terracotta.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color: terracotta.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 56,
                          height: 56,
                          decoration: const BoxDecoration(
                            color: terracotta,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x339E401A),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            _isListening ? Icons.stop : Icons.mic,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Tap to Speak / बोलें',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: terracotta,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _isListening ? 'Listening now... Speak in any language' : 'Listening: 00:14 • Hindi / Hinglish / English',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF8D8078),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Animated waveform visual
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3ECE4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        18,
                        (index) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 2.5),
                          width: 3.5,
                          height: (index % 4 == 0 ? 24.0 : (index % 2 == 0 ? 16.0 : 8.0)),
                          decoration: BoxDecoration(
                            color: terracotta.withValues(alpha: 0.75),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 4. Voice Prompt Idea
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFBF4ED),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFEFE4DA)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3E7DC),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.lightbulb_outline, size: 16, color: terracotta),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Voice Prompt Idea',
                              style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: textDark),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _transcribedText =
                                      'Looking for 300 hand-thrown terracotta dinner plates with glazed finish and custom studio logo for restaurant launch.';
                                });
                                _processAiExtraction();
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.refresh, size: 12, color: terracotta),
                                  SizedBox(width: 2),
                                  Text(
                                    'Try another',
                                    style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w700, color: terracotta),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '"Need 500 handwoven natural bamboo fruit baskets, 10-inch diameter, delivery in Delhi within 3 weeks with food-grade polish."',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF7A6D66),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 5. Transcribed Requirement Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderBeige),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.check_circle, size: 18, color: Color(0xFF2E7D32)),
                          SizedBox(width: 6),
                          Text(
                            'Transcribed Requirement',
                            style: TextStyle(fontSize: 14.5, fontWeight: FontWeight.w800, color: textDark),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'AI Processed',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFCFAF7),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFEFE7DE)),
                    ),
                    child: Text(
                      '"$_transcribedText"',
                      style: const TextStyle(
                        fontSize: 13,
                        color: textDark,
                        height: 1.45,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          // Allow editing text
                        },
                        icon: const Icon(Icons.edit_outlined, size: 14, color: Color(0xFF6E5F57)),
                        label: const Text(
                          'Edit Text',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6E5F57)),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFD4C5B9)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: _toggleVoiceRecording,
                        icon: const Icon(Icons.mic_none, size: 14, color: Color(0xFF6E5F57)),
                        label: const Text(
                          'Speak Again',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF6E5F57)),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFD4C5B9)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _transcribedText = '';
                          });
                        },
                        icon: const Icon(Icons.delete_outline, color: Color(0xFFD32F2F), size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 6. Auto-Extracted Specifications
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Auto-Extracted Specifications',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: textDark),
                ),
                Text(
                  '4 tags confirmed',
                  style: TextStyle(fontSize: 12, color: Color(0xFF8D8078), fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildSpecCard(Icons.category_outlined, 'PRODUCT', _product),
                _buildSpecCard(Icons.inventory_2_outlined, 'QUANTITY', _quantity),
                _buildSpecCard(Icons.brush_outlined, 'FINISH', _finish),
                _buildSpecCard(Icons.eco_outlined, 'PACKAGING', _packaging),
              ],
            ),

            const SizedBox(height: 14),

            // 7. Target Dispatch Within
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFBF4ED),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFEFE4DA)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3E7DC),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.handshake_outlined, size: 18, color: terracotta),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Target Dispatch Within',
                          style: TextStyle(fontSize: 12, color: Color(0xFF8D8078)),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Recommended: $_timeline',
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('✍️ Edit fields above or record additional voice instructions to adjust requirement parameters.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: const Text(
                      'Adjust',
                      style: TextStyle(color: terracotta, fontWeight: FontWeight.w700, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: terracotta,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BuyerBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) widget.onOpenHome();
          if (index == 1) widget.onOpenDiscover();
          if (index == 2) widget.onOpenRequirements();
          if (index == 3 && widget.onOpenOrders != null) widget.onOpenOrders!();
          if (index == 4 && widget.onOpenProfile != null) widget.onOpenProfile!();
        },
      ),
    );
  }

  static Widget _buildSpecCard(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF3EC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEDE2D7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 13, color: const Color(0xFF9E401A)),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF8D8078),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E1714),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
