// lib/screens/craft_selection_screen.dart

import 'package:flutter/material.dart';
import '../models/onboarding_state.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/action_button.dart';

class CraftSelectionScreen extends StatelessWidget {
  final OnboardingState state;
  final ValueChanged<OnboardingState> onStateChanged;
  final VoidCallback onBack;
  final VoidCallback onContinue;

  const CraftSelectionScreen({
    super.key,
    required this.state,
    required this.onStateChanged,
    required this.onBack,
    required this.onContinue,
  });

  static const List<Map<String, dynamic>> crafts = [
    {'name': 'Pottery & Ceramics', 'icon': Icons.soup_kitchen_outlined, 'desc': 'Khurja & Jaipur blue pottery, terracotta'},
    {'name': 'Bamboo & Cane', 'icon': Icons.shopping_basket_outlined, 'desc': 'North-East & Kerala woven utility crafts'},
    {'name': 'Handloom & Textiles', 'icon': Icons.dry_cleaning_outlined, 'desc': 'Varanasi silk, Chanderi, Ikat weaving'},
    {'name': 'Brass & Metal Craft', 'icon': Icons.hardware_outlined, 'desc': 'Moradabad brassware, Dokra bell metal'},
    {'name': 'Woodcarving', 'icon': Icons.carpenter_outlined, 'desc': 'Saharanpur & Kashmir walnut woodcraft'},
    {'name': 'Leather Craft', 'icon': Icons.shopping_bag_outlined, 'desc': 'Kolhapuri chappals & Shantiniketan leather'},
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
                currentStep: 5,
                totalSteps: 7,
                title: 'Select Your Primary Craft',
                subtitle: 'Choose the traditional craft category you practice and produce',
                onBack: onBack,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: crafts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final craft = crafts[index];
                    final isSelected = state.selectedCraft == craft['name'] ||
                        (state.selectedCraft.isEmpty && index == 1);

                    return InkWell(
                      onTap: () {
                        onStateChanged(state.copyWith(selectedCraft: craft['name'] as String));
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.all(14),
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
                            CircleAvatar(
                              backgroundColor: isSelected ? const Color(0xFFA84318) : const Color(0xFFFAF6F2),
                              child: Icon(
                                craft['icon'] as IconData,
                                color: isSelected ? Colors.white : const Color(0xFFA84318),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    craft['name'] as String,
                                    style: TextStyle(
                                      fontSize: 14.5,
                                      fontWeight: FontWeight.w800,
                                      color: isSelected ? const Color(0xFFA84318) : const Color(0xFF2D2421),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    craft['desc'] as String,
                                    style: const TextStyle(fontSize: 11.5, color: Color(0xFF7A685F)),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const Icon(Icons.check_circle, color: Color(0xFFA84318), size: 20),
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
