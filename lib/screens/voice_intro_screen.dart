// lib/screens/voice_intro_screen.dart

import 'package:flutter/material.dart';
import '../models/onboarding_state.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/action_button.dart';
import '../services/hardware_service.dart';

class VoiceIntroScreen extends StatefulWidget {
  final OnboardingState state;
  final ValueChanged<OnboardingState> onStateChanged;
  final VoidCallback onBack;
  final VoidCallback onContinue;

  const VoiceIntroScreen({
    super.key,
    required this.state,
    required this.onStateChanged,
    required this.onBack,
    required this.onContinue,
  });

  @override
  State<VoiceIntroScreen> createState() => _VoiceIntroScreenState();
}

class _VoiceIntroScreenState extends State<VoiceIntroScreen> with SingleTickerProviderStateMixin {
  bool _isListening = false;
  bool _isPlayingAudio = false;
  String _transcribedStory = '';
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _transcribedStory = widget.state.voiceStoryTranscript;
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    HardwareService().stopListening();
    HardwareService().stopSpeaking();
    super.dispose();
  }

  Future<void> _toggleRecording() async {
    if (_isListening) {
      await HardwareService().stopListening();
      if (mounted) setState(() => _isListening = false);
      return;
    }

    setState(() {
      _isListening = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🎙️ Microphone active! Speak in Hindi, English, or your local language.'),
        backgroundColor: Color(0xFFBA4B1D),
        duration: Duration(seconds: 2),
      ),
    );

    await HardwareService().startListening(
      onResult: (text, isFinal) {
        if (text.isNotEmpty && mounted) {
          setState(() {
            _transcribedStory = text;
          });
          widget.onStateChanged(
            widget.state.copyWith(
              hasRecordedVoice: true,
              voiceStoryTranscript: text,
              voiceDuration: '0:24',
            ),
          );
          if (isFinal) {
            setState(() => _isListening = false);
          }
        }
      },
      onStopped: () {
        if (mounted) setState(() => _isListening = false);
      },
      onError: (err) {
        if (mounted) setState(() => _isListening = false);
      },
    );
  }

  Future<void> _playVoiceSample() async {
    final textToPlay = _transcribedStory.isNotEmpty
        ? _transcribedStory
        : 'नमस्ते! मैं रामू कुमार हूँ। मैं बाराबंकी में पिछले 15 वर्षों से हस्तनिर्मित बाँस की टोकरियाँ और कलाकृतियाँ बनाता हूँ।';

    if (_isPlayingAudio) {
      await HardwareService().stopSpeaking();
      if (mounted) setState(() => _isPlayingAudio = false);
      return;
    }

    setState(() => _isPlayingAudio = true);
    await HardwareService().speak(
      textToPlay,
      onComplete: () {
        if (mounted) setState(() => _isPlayingAudio = false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: Column(
          children: [
            OnboardingHeader(
              currentStep: 2,
              totalSteps: 5,
              stepLabel: 'Craft Maker Setup',
              onBack: widget.onBack,
              currentLanguage: widget.state.selectedLanguage,
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8.0),

                    const Text(
                      'Tell us about yourself',
                      style: TextStyle(
                        fontSize: 27.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF221C19),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'Speak naturally. We will create your artisan profile for you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF6B584E),
                        height: 1.35,
                      ),
                    ),

                    const SizedBox(height: 14.0),

                    // Audio Assistance Active Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: const Color(0xFFC8E6C9)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.hearing_rounded, size: 16.0, color: Color(0xFF2E7D32)),
                          SizedBox(width: 6.0),
                          Text(
                            'Audio assistance active\nHindi/English/other supported',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF2E7D32),
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24.0),

                    // Concentric Glowing Microphone Recording Button
                    GestureDetector(
                      onTap: _toggleRecording,
                      child: AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          final pulse = _isListening ? _pulseController.value * 16.0 : 0.0;
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              // Outer Ring
                              Container(
                                width: 190.0 + pulse,
                                height: 190.0 + pulse,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (_isListening ? Colors.red : const Color(0xFFD85A2A)).withValues(alpha: 0.12),
                                ),
                              ),
                              // Middle Ring
                              Container(
                                width: 155.0,
                                height: 155.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (_isListening ? Colors.red : const Color(0xFFD85A2A)).withValues(alpha: 0.22),
                                ),
                              ),
                              // Core Mic Button
                              Container(
                                width: 120.0,
                                height: 120.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: _isListening
                                        ? [Colors.redAccent, Colors.red.shade900]
                                        : [
                                            const Color(0xFFBA4B1D),
                                            const Color(0xFF8C3814),
                                          ],
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x338C3814),
                                      blurRadius: 16.0,
                                      offset: Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  _isListening ? Icons.stop_rounded : Icons.mic_rounded,
                                  size: 48.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16.0),

                    // Tap to speak instruction
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isListening ? Icons.graphic_eq_rounded : Icons.mic_none_rounded,
                          size: 16.0,
                          color: _isListening ? Colors.red : const Color(0xFFA84318),
                        ),
                        const SizedBox(width: 6.0),
                        Flexible(
                          child: Text(
                            _isListening ? 'Listening now... Speak your story' : 'Tap the microphone and speak naturally.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: _isListening ? Colors.red : const Color(0xFFA84318),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'Tell us your craft name, village, or years of work.',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Color(0xFF7A685F),
                      ),
                    ),

                    if (_transcribedStory.isNotEmpty) ...[
                      const SizedBox(height: 14.0),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F8E9),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFC8E6C9)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.record_voice_over, color: Color(0xFF2E7D32), size: 16),
                                const SizedBox(width: 6),
                                const Text(
                                  'Voice Transcribed Successfully',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF2E7D32)),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: Icon(
                                    _isPlayingAudio ? Icons.stop_circle : Icons.volume_up_rounded,
                                    color: const Color(0xFF2E7D32),
                                    size: 20,
                                  ),
                                  onPressed: _playVoiceSample,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '“$_transcribedStory”',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 12.5, fontStyle: FontStyle.italic, color: Color(0xFF1B5E20)),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 20.0),

                    // Speak Your Following Details Card with Prompt Chips
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBF9),
                        borderRadius: BorderRadius.circular(18.0),
                        border: Border.all(color: const Color(0xFFF0E2D8)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.lightbulb_rounded, size: 16.0, color: Color(0xFFB85324)),
                              SizedBox(width: 6.0),
                              Text(
                                'SPEAK YOUR FOLLOWING DETAILS',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.6,
                                  color: Color(0xFF8C4421),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: const [
                              _DetailChip(label: 'Full Name'),
                              _DetailChip(label: 'Full Address'),
                              _DetailChip(label: 'Experience'),
                              _DetailChip(label: 'Specialities'),
                              _DetailChip(label: 'Products You are making'),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFBF6F2),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: const Text(
                              'Example : "I make handmade bamboo baskets and have been doing this for many years in Barabanki, UP." All About Your self',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontStyle: FontStyle.italic,
                                color: Color(0xFF4A3B32),
                                height: 1.35,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20.0),

                    // Secondary Action: Test Voice Synthesis
                    ActionButton(
                      text: _isPlayingAudio ? 'Stop Playing Audio' : 'Play Voice Audio Guide',
                      icon: _isPlayingAudio ? Icons.stop_circle_outlined : Icons.play_circle_fill_rounded,
                      isOutlined: true,
                      onPressed: _playVoiceSample,
                    ),

                    const SizedBox(height: 12.0),
                  ],
                ),
              ),
            ),

            // Fixed Bottom Action Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ActionButton(
                text: 'Continue',
                backgroundColor: const Color(0xFFE66B38),
                footerNote: 'Designed for speaking, seeing and tapping — zero typing required.',
                footerIcon: Icons.verified_user_outlined,
                onPressed: widget.onContinue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  final String label;
  const _DetailChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF7EFE9),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFEADAD0)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w600,
          color: Color(0xFF4A3B32),
        ),
      ),
    );
  }
}
