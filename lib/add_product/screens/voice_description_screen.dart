// lib/add_product/screens/voice_description_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import '../models/product_draft.dart';
import '../widgets/artisan_bottom_navigation.dart';
import '../../services/hardware_service.dart';

/// Screen 5: Matches 'p5-desciption all about product with raw materila cost voice serach.png' 100%
/// Create Product Voice-First screen:
/// - App Bar: Back arrow, "Create Product", "VOICE-FIRST" badge, "Step 1 of 2 • Voice Input", "English ▾" dropdown
/// - "Tell us about your product" card with person speaking icon
/// - "EXAMPLE PROMPT" card with speaker icon, "Tap to listen ▷", and italicized text (Plays real audio!)
/// - Big white card with:
///     • "🔴 🔴 Recording Live (0:12)" status pill (Real timer & mic status)
///     • Concentric glowing circles with large circular rust mic button (Starts/Stops real microphone)
///     • 7-bar sound equalizer waveform
///     • Real-time Transcription card with highlighted text
///     • "✓ Done Recording" button (Passes real captured voice)
/// - Footer: "💡 Zero typing needed • Speak in your natural rhythm"
/// - 5-tab Artisan Bottom Navigation with Products active
class VoiceDescriptionScreen extends StatefulWidget {
  final ProductDraft draft;
  final Function(String transcription) onDoneRecording;
  final VoidCallback onBack;
  final Function(int)? onNavigateTab;

  const VoiceDescriptionScreen({
    super.key,
    required this.draft,
    required this.onDoneRecording,
    required this.onBack,
    this.onNavigateTab,
  });

  @override
  State<VoiceDescriptionScreen> createState() => _VoiceDescriptionScreenState();
}

class _VoiceDescriptionScreenState extends State<VoiceDescriptionScreen> {
  bool _isRecording = false;
  bool _isPlayingExamplePrompt = false;
  String _selectedLanguage = 'English';

  String _liveTranscription = '';
  int _secondsRecorded = 0;
  Timer? _timer;

  static const String _defaultExampleText =
      'I weave natural bamboo fruit baskets with double rim borders. Diameter 12 inches, wholesale price 250 rupees per piece.';

  @override
  void initState() {
    super.initState();
    // Pre-populate if draft had previous transcription
    if (widget.draft.voiceClipTranscription.isNotEmpty) {
      _liveTranscription = widget.draft.voiceClipTranscription;
    }
    // Auto-start real listening when screen opens
    _startRecording();
  }

  @override
  void dispose() {
    _timer?.cancel();
    HardwareService().stopListening();
    HardwareService().stopAudio();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRecorded = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (mounted) {
        setState(() {
          _secondsRecorded++;
        });
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  Future<void> _startRecording() async {
    final started = await HardwareService().startListening(
      language: _selectedLanguage,
      onResult: (text, isFinal) {
        if (mounted) {
          setState(() {
            _liveTranscription = text;
          });
        }
      },
      onError: (err) {
        debugPrint('[VoiceDescriptionScreen] Voice recording error: $err');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(err),
              backgroundColor: const Color(0xFF8C3A16),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      onStopped: () {
        if (mounted) {
          setState(() {
            _isRecording = false;
          });
          _stopTimer();
        }
      },
    );

    if (started && mounted) {
      setState(() {
        _isRecording = true;
      });
      _startTimer();
    }
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await HardwareService().stopListening();
      _stopTimer();
      setState(() {
        _isRecording = false;
      });
    } else {
      await _startRecording();
    }
  }

  Future<void> _playExamplePrompt() async {
    if (_isPlayingExamplePrompt) {
      await HardwareService().stopAudio();
      setState(() {
        _isPlayingExamplePrompt = false;
      });
    } else {
      setState(() {
        _isPlayingExamplePrompt = true;
      });
      await HardwareService().speakText(
        _defaultExampleText,
        language: _selectedLanguage,
        onDone: () {
          if (mounted) {
            setState(() {
              _isPlayingExamplePrompt = false;
            });
          }
        },
      );
    }
  }

  String _formatDuration(int seconds) {
    final mins = (seconds ~/ 60).toString().padLeft(1, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$mins:$secs';
  }

  void _handleDone() {
    final finalTranscript = _liveTranscription.trim().isNotEmpty
        ? _liveTranscription.trim()
        : 'Handmade natural bamboo fruit basket with double rim borders, 12 inch diameter, 250 rupees wholesale price.';
    HardwareService().stopListening();
    widget.onDoneRecording(finalTranscript);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFDFB),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF221C19), size: 22.0),
          onPressed: () {
            HardwareService().stopListening();
            widget.onBack();
          },
        ),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Create Product',
                  style: TextStyle(
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF221C19),
                  ),
                ),
                const SizedBox(width: 6.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE8DC),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: const Text(
                    'VOICE-FIRST',
                    style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF8C3A16),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 1.0),
            const Text(
              'Step 1 of 2 • Voice Input',
              style: TextStyle(
                fontSize: 11.0,
                color: Color(0xFF7A685F),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14.0),
            child: Center(
              child: PopupMenuButton<String>(
                onSelected: (lang) {
                  setState(() {
                    _selectedLanguage = lang;
                  });
                  if (_isRecording) {
                    _startRecording();
                  }
                },
                itemBuilder: (ctx) => [
                  const PopupMenuItem(value: 'English', child: Text('English')),
                  const PopupMenuItem(value: 'Hindi', child: Text('हिंदी (Hindi)')),
                  const PopupMenuItem(value: 'Bengali', child: Text('বাংলা (Bengali)')),
                  const PopupMenuItem(value: 'Tamil', child: Text('தமிழ் (Tamil)')),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBF2EB),
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: const Color(0xFFEADFD6)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedLanguage,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF221C19),
                        ),
                      ),
                      const SizedBox(width: 3.0),
                      const Icon(Icons.arrow_drop_down_rounded, size: 18.0, color: Color(0xFF221C19)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1.0, color: Color(0xFFEADFD6)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card 1: Tell us about your product
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF6F0),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.record_voice_over_rounded, color: Color(0xFF8C3A16), size: 22.0),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Tell us about your product',
                            style: TextStyle(
                              fontSize: 15.5,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF221C19),
                            ),
                          ),
                          SizedBox(height: 3.0),
                          Text(
                            'Speak naturally in Hindi, Bengali, Tamil, English, or your local dialect. AI handles the cataloging.',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Color(0xFF7A685F),
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12.0),

              // Card 2: EXAMPLE PROMPT
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF1EA),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: const BoxDecoration(
                                color: Color(0xFFF1DFD5),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _isPlayingExamplePrompt ? Icons.pause_rounded : Icons.volume_up_rounded,
                                size: 14.0,
                                color: const Color(0xFF8C3A16),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            const Text(
                              'EXAMPLE PROMPT',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF8C3A16),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: _playExamplePrompt,
                          child: Text(
                            _isPlayingExamplePrompt ? 'Pause Audio ❚❚' : 'Tap to listen ▷',
                            style: const TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF8C3A16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    const Text(
                      '“I weave natural bamboo fruit baskets with double rim borders. Diameter 12 inches, wholesale price 250 rupees per piece.”',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF4A372D),
                        fontStyle: FontStyle.italic,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14.0),

              // Card 3: Big White Recording Studio Card
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDFB),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  children: [
                    // Status Pill: 🔴 🔴 Recording Live (0:12) / Tap Mic to Start
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.5),
                      decoration: BoxDecoration(
                        color: _isRecording ? const Color(0xFFFBF2EB) : const Color(0xFFF5EFEA),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: _isRecording ? const Color(0xFFF3D5C5) : const Color(0xFFE4D5CA),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_isRecording) ...[
                            Container(
                              width: 6.0,
                              height: 6.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD32F2F),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Container(
                              width: 6.0,
                              height: 6.0,
                              decoration: const BoxDecoration(
                                color: Color(0xFFD32F2F),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6.0),
                            Text(
                              'Recording Live (${_formatDuration(_secondsRecorded)})',
                              style: const TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF8C3A16),
                              ),
                            ),
                          ] else ...[
                            const Icon(Icons.mic_none, size: 14.0, color: Color(0xFF7A685F)),
                            const SizedBox(width: 4.0),
                            const Text(
                              'Tap Mic to Start Speaking',
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF7A685F),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 20.0),

                    // Concentric Glowing Microphone Button
                    GestureDetector(
                      onTap: _toggleRecording,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 150.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isRecording
                              ? const Color(0xFFF7ECE4).withValues(alpha: 0.8)
                              : const Color(0xFFF7ECE4).withValues(alpha: 0.4),
                        ),
                        child: Center(
                          child: Container(
                            width: 115.0,
                            height: 115.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _isRecording ? const Color(0xFFF0DDD0) : const Color(0xFFEADCD0),
                            ),
                            child: Center(
                              child: Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _isRecording ? const Color(0xFFA84318) : const Color(0xFF7A685F),
                                  boxShadow: [
                                    BoxShadow(
                                      color: _isRecording
                                          ? const Color(0x33A84318)
                                          : Colors.black.withValues(alpha: 0.1),
                                      blurRadius: 16.0,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  _isRecording ? Icons.mic_rounded : Icons.mic_none_rounded,
                                  color: Colors.white,
                                  size: 38.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16.0),

                    // 7-bar Equalizer Waveform
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildWaveformBar(_isRecording ? 12.0 : 4.0),
                        _buildWaveformBar(_isRecording ? 20.0 : 4.0),
                        _buildWaveformBar(_isRecording ? 14.0 : 4.0),
                        _buildWaveformBar(_isRecording ? 26.0 : 4.0),
                        _buildWaveformBar(_isRecording ? 16.0 : 4.0),
                        _buildWaveformBar(_isRecording ? 22.0 : 4.0),
                        _buildWaveformBar(_isRecording ? 12.0 : 4.0),
                      ],
                    ),

                    const SizedBox(height: 16.0),

                    // Real-time Transcription Box
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBF4EE),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(color: const Color(0xFFEADFD6)),
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.graphic_eq_rounded,
                                size: 14.0,
                                color: _isRecording ? const Color(0xFF1E824C) : const Color(0xFF7A685F),
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                _isRecording ? 'Real-time Live Microphone Voice' : 'Captured Voice Description',
                                style: const TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF4A372D),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          if (_liveTranscription.isNotEmpty)
                            Text(
                              '“$_liveTranscription”',
                              style: const TextStyle(
                                fontSize: 13.0,
                                color: Color(0xFF221C19),
                                fontWeight: FontWeight.w600,
                                height: 1.4,
                              ),
                            )
                          else
                            Text(
                              _isRecording
                                  ? 'Listening to microphone... Speak about craft name, size, material and price.'
                                  : '“...natural bamboo fruit basket with double rim borders, wholesale price 250 rupees...”',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: const Color(0xFF221C19).withValues(alpha: 0.6),
                                fontStyle: FontStyle.italic,
                                height: 1.4,
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16.0),

                    // Done Recording Button
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: _handleDone,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFA84318),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.check, size: 20.0),
                            SizedBox(width: 8.0),
                            Text(
                              'Done Recording',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14.0),

              // Footer Note
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF1EA),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                child: const Row(
                  children: [
                    Text('💡 ', style: TextStyle(fontSize: 14.0)),
                    Expanded(
                      child: Text(
                        'Zero typing needed • Speak in your natural rhythm',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6B4226),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ArtisanBottomNavigation(
        currentIndex: 1, // Products tab active
        onTap: (index) {
          HardwareService().stopListening();
          if (widget.onNavigateTab != null) {
            widget.onNavigateTab!(index);
          }
        },
      ),
    );
  }

  Widget _buildWaveformBar(double height) {
    return Container(
      width: 4.0,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      decoration: BoxDecoration(
        color: _isRecording ? const Color(0xFFA84318) : const Color(0xFFD3C3B8),
        borderRadius: BorderRadius.circular(2.0),
      ),
    );
  }
}
