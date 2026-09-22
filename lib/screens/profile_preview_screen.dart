// lib/screens/profile_preview_screen.dart

import 'package:flutter/material.dart';
import '../models/onboarding_state.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/action_button.dart';

class ProfilePreviewScreen extends StatelessWidget {
  final OnboardingState state;
  final ValueChanged<OnboardingState> onStateChanged;
  final VoidCallback onBack;
  final VoidCallback onComplete;

  const ProfilePreviewScreen({
    super.key,
    required this.state,
    required this.onStateChanged,
    required this.onBack,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final name = state.artisanName.isNotEmpty ? state.artisanName : 'Ramu Kumar';
    final craft = state.selectedCraft.isNotEmpty ? state.selectedCraft : 'Master Bamboo & Cane Artisan';
    final photoUrl = state.profilePhotoUrl.isNotEmpty
        ? state.profilePhotoUrl
        : 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80';

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OnboardingHeader(
                currentStep: 7,
                totalSteps: 7,
                title: 'Review Your Maker Card',
                subtitle: 'Your GI-verified digital identity is ready to connect with wholesale buyers',
                onBack: onBack,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(photoUrl),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xFF2D2421)),
                        ),
                        const SizedBox(width: 6),
                        const Icon(Icons.verified, color: Color(0xFF2E7D32), size: 18),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      craft,
                      style: const TextStyle(fontSize: 13, color: Color(0xFFA84318), fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        '🎖️ GI Certified • 100% Verified Maker',
                        style: TextStyle(fontSize: 11, color: Color(0xFF2E7D32), fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: Color(0xFFEADBCE)),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        _StatBadge(label: 'Monthly Capacity', value: '450 pcs'),
                        _StatBadge(label: 'Cluster', value: 'Barabanki'),
                        _StatBadge(label: 'ONDC Status', value: 'Active'),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ActionButton(
                text: 'Launch Artisan Dashboard',
                onPressed: onComplete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String label;
  final String value;
  const _StatBadge({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF2D2421))),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF7A685F))),
      ],
    );
  }
}
