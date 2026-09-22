// lib/widgets/onboarding_header.dart

import 'package:flutter/material.dart';

class OnboardingHeader extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? stepLabel;
  final int currentStep;
  final int totalSteps;
  final VoidCallback? onBack;
  final String? currentLanguage;

  const OnboardingHeader({
    super.key,
    this.title,
    this.subtitle,
    this.stepLabel,
    this.currentStep = 1,
    this.totalSteps = 1,
    this.onBack,
    this.currentLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (onBack != null)
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF221C19)),
                  onPressed: onBack,
                )
              else
                const SizedBox(width: 40),
              if (stepLabel != null)
                Text(
                  stepLabel!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6B584E),
                  ),
                ),
              if (currentLanguage != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2ECE6),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    currentLanguage!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFA84318),
                    ),
                  ),
                )
              else
                const SizedBox(width: 40),
            ],
          ),
          if (totalSteps > 1) ...[
            const SizedBox(height: 8),
            Row(
              children: List.generate(totalSteps, (index) {
                final isActive = index < currentStep;
                return Expanded(
                  child: Container(
                    height: 4,
                    margin: EdgeInsets.only(right: index < totalSteps - 1 ? 6 : 0),
                    decoration: BoxDecoration(
                      color: isActive ? const Color(0xFFA84318) : const Color(0xFFE2D6CC),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              }),
            ),
          ],
          if (title != null) ...[
            const SizedBox(height: 12),
            Text(
              title!,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1F1612),
              ),
            ),
          ],
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF6D4C41),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
