// lib/screens/role_selection_screen.dart

import 'package:flutter/material.dart';
import '../models/onboarding_state.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/action_button.dart';

class RoleSelectionScreen extends StatefulWidget {
  final OnboardingState state;
  final ValueChanged<OnboardingState> onStateChanged;
  final VoidCallback onBack;
  final VoidCallback onContinue;

  const RoleSelectionScreen({
    super.key,
    required this.state,
    required this.onStateChanged,
    required this.onBack,
    required this.onContinue,
  });

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  late UserRole _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.state.selectedRole;
  }

  void _selectRole(UserRole role) {
    setState(() {
      _selectedRole = role;
    });
    widget.onStateChanged(widget.state.copyWith(selectedRole: role));
  }

  @override
  Widget build(BuildContext context) {
    final isArtisan = _selectedRole == UserRole.artisan;
    final isBuyer = _selectedRole == UserRole.buyer;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: Column(
          children: [
            OnboardingHeader(
              onBack: widget.onBack,
              currentLanguage: widget.state.selectedLanguage,
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Onboarding Step Tag
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDE8DF),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.verified_outlined, size: 14.0, color: Color(0xFFD85A2A)),
                          SizedBox(width: 4.0),
                          Text(
                            'ONBOARDING STEP',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: Color(0xFF7C3F24),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12.0),

                    const Text(
                      'Choose Your Role',
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF221C19),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    const Text(
                      'Select how you want to use HunarSangam.',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF6B584E),
                      ),
                    ),

                    const SizedBox(height: 20.0),

                    // Role 1: Artisan / Shilpkar Card -> Craft Maker
                    _RoleCard(
                      isSelected: isArtisan,
                      onTap: () => _selectRole(UserRole.artisan),
                      icon: Icons.palette_rounded,
                      roleBadge: 'CRAFT MAKER / SHILPKAR',
                      title: "I'm a Craft Maker",
                      description:
                          'Show your craft, create catalogs with your voice, sell to businesses, and collaborate on large orders.',
                      chips: const [
                        '🎙️ 📜 Voice Catalog',
                        '👥 🤝 Team Up on Large Orders',
                        '🏷️ 🏷️ Fair Price Help',
                      ],
                      footerNote: 'Audio & vernacular assistance active',
                      footerIcon: Icons.volume_up_outlined,
                      footerColor: const Color(0xFF2E7D32),
                    ),

                    const SizedBox(height: 16.0),

                    // Role 2: Business Buyer Card -> Bulk Buyer
                    _RoleCard(
                      isSelected: isBuyer,
                      onTap: () => _selectRole(UserRole.buyer),
                      icon: Icons.storefront_rounded,
                      roleBadge: 'B2B BULK SOURCING',
                      title: "I'm a Bulk Buyer",
                      description:
                          'Find skilled craft makers, source products in bulk, compare suitable suppliers, and track production.',
                      chips: const [
                        '📦 📦 Bulk Sourcing',
                        '⚡ ⚡ AI Craft Maker Match',
                        '📷 💼 Visual Milestones',
                      ],
                      footerNote: 'Escrow & GI certification guaranteed • Tiered Quotes',
                      footerIcon: Icons.verified_outlined,
                      footerColor: const Color(0xFF2E7D32),
                    ),

                    const SizedBox(height: 24.0),
                  ],
                ),
              ),
            ),

            // Bottom Continue Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ActionButton(
                text: isArtisan ? 'Continue as Craft Maker →' : 'Continue as Bulk Buyer →',
                footerNote: 'Designed for easy voice input and direct collaboration.',
                footerIcon: Icons.lightbulb_outline_rounded,
                onPressed: widget.onContinue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;
  final String roleBadge;
  final String title;
  final String description;
  final List<String> chips;
  final String footerNote;
  final IconData footerIcon;
  final Color footerColor;

  const _RoleCard({
    required this.isSelected,
    required this.onTap,
    required this.icon,
    required this.roleBadge,
    required this.title,
    required this.description,
    required this.chips,
    required this.footerNote,
    required this.footerIcon,
    required this.footerColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: isSelected ? const Color(0xFFA84318) : const Color(0xFFE8DDD5),
            width: isSelected ? 2.5 : 1.2,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: const Color(0xFFA84318).withValues(alpha: 0.08),
                blurRadius: 10.0,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFA84318) : const Color(0xFFEFE6E0),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 24.0,
                    color: isSelected ? Colors.white : const Color(0xFF5D4037),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        roleBadge,
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                          color: isSelected ? const Color(0xFFA84318) : const Color(0xFF8C5338),
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF221C19),
                        ),
                      ),
                    ],
                  ),
                ),
                // Radio icon
                Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? const Color(0xFFA84318) : const Color(0xFFB5A79E),
                      width: isSelected ? 6.5 : 1.8,
                    ),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Text(
              description,
              style: const TextStyle(
                fontSize: 13.0,
                color: Color(0xFF4A3B32),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: chips.map((chip) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7EFE9),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: const Color(0xFFEADCD3)),
                  ),
                  child: Text(
                    chip,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A3228),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12.0),
            const Divider(color: Color(0xFFF0E5DE), height: 1.0),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Icon(footerIcon, size: 15.0, color: footerColor),
                const SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    footerNote,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: footerColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
