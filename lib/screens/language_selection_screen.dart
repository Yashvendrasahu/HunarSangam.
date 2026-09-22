// lib/screens/language_selection_screen.dart

import 'package:flutter/material.dart';
import '../models/onboarding_state.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/action_button.dart';

class LanguageSelectionScreen extends StatelessWidget {
  final OnboardingState state;
  final ValueChanged<OnboardingState> onStateChanged;
  final VoidCallback onBack;
  final VoidCallback onContinue;

  const LanguageSelectionScreen({
    super.key,
    required this.state,
    required this.onStateChanged,
    required this.onBack,
    required this.onContinue,
  });

  static const List<Map<String, String>> languages = [
    {'name': 'English', 'native': 'English', 'sub': 'Default'},
    {'name': 'Hindi', 'native': 'हिन्दी', 'sub': 'North India'},
    {'name': 'Bengali', 'native': 'বাংলা', 'sub': 'West Bengal & East'},
    {'name': 'Tamil', 'native': 'தமிழ்', 'sub': 'Tamil Nadu'},
    {'name': 'Telugu', 'native': 'తెలుగు', 'sub': 'Andhra & Telangana'},
    {'name': 'Gujarati', 'native': 'ગુજરાતી', 'sub': 'Gujarat'},
    {'name': 'Marathi', 'native': 'मराठी', 'sub': 'Maharashtra'},
    {'name': 'Odia', 'native': 'ଓଡ଼ିଆ', 'sub': 'Odisha'},
    {'name': 'Assamese', 'native': 'অসমীয়া', 'sub': 'Assam & NE'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OnboardingHeader(
                currentStep: 1,
                totalSteps: 7,
                title: 'Choose Your Language',
                subtitle: 'अपनी पसंदीदा भाषा चुनें / Select your native language for AI voice assistance',
                onBack: onBack,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2.2,
                  ),
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    final lang = languages[index];
                    final isSelected = state.selectedLanguage == lang['name'] ||
                        (state.selectedLanguage.isEmpty && lang['name'] == 'Hindi');

                    return InkWell(
                      onTap: () {
                        onStateChanged(state.copyWith(selectedLanguage: lang['name']));
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFFDECE8) : Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected ? const Color(0xFFA84318) : const Color(0xFFEADFD6),
                            width: isSelected ? 2.0 : 1.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    lang['native']!,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                      color: isSelected ? const Color(0xFFA84318) : const Color(0xFF2D2421),
                                    ),
                                  ),
                                  Text(
                                    lang['name']!,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF7A685F),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const Icon(Icons.check_circle, color: Color(0xFFA84318), size: 18),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              ActionButton(
                text: 'Continue / आगे बढ़ें',
                onPressed: onContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
