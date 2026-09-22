// lib/add_product/widgets/voice_waveform.dart

import 'package:flutter/material.dart';

class VoiceWaveformWidget extends StatelessWidget {
  final bool isRecording;
  final String statusText;
  final VoidCallback onToggleRecording;

  const VoiceWaveformWidget({
    super.key,
    this.isRecording = true,
    this.statusText = 'Recording Live (0:12)',
    required this.onToggleRecording,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Live status pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFBF4EE),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: const Color(0xFFEADFD6)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6.0,
                height: 6.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFC53030),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4.0),
              Container(
                width: 6.0,
                height: 6.0,
                decoration: const BoxDecoration(
                  color: Color(0xFFC53030),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6.0),
              Text(
                statusText,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF8C3A16),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20.0),

        // Concentric Ripple Mic Button
        GestureDetector(
          onTap: onToggleRecording,
          child: Container(
            width: 140.0,
            height: 140.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFEADFD6).withValues(alpha: 0.4),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF3E7DF),
              ),
              padding: const EdgeInsets.all(14.0),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFA84318),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFA84318).withValues(alpha: 0.3),
                      offset: const Offset(0, 4),
                      blurRadius: 12.0,
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.mic_rounded,
                    color: Colors.white,
                    size: 38.0,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16.0),

        // Waveform Equalizer Bars
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildBar(14.0),
            _buildBar(22.0),
            _buildBar(10.0),
            _buildBar(30.0),
            _buildBar(8.0),
            _buildBar(24.0),
            _buildBar(18.0),
            _buildBar(28.0),
            _buildBar(12.0),
          ],
        ),
      ],
    );
  }

  Widget _buildBar(double height) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      width: 3.5,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFA84318),
        borderRadius: BorderRadius.circular(2.0),
      ),
    );
  }
}
