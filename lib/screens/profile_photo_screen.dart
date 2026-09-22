// lib/screens/profile_photo_screen.dart

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/onboarding_state.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/action_button.dart';
import '../services/hardware_service.dart';

class ProfilePhotoScreen extends StatefulWidget {
  final OnboardingState state;
  final ValueChanged<OnboardingState> onStateChanged;
  final VoidCallback onBack;
  final VoidCallback onContinue;

  const ProfilePhotoScreen({
    super.key,
    required this.state,
    required this.onStateChanged,
    required this.onBack,
    required this.onContinue,
  });

  @override
  State<ProfilePhotoScreen> createState() => _ProfilePhotoScreenState();
}

class _ProfilePhotoScreenState extends State<ProfilePhotoScreen> {
  String? _localPhotoPath;

  Future<void> _takePhotoWithCamera() async {
    final photo = await HardwareService().captureImageFromCamera();
    if (photo != null && mounted) {
      setState(() => _localPhotoPath = photo.path);
      widget.onStateChanged(widget.state.copyWith(profilePhotoUrl: photo.path));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('📸 Workshop photo captured successfully!'),
          backgroundColor: Color(0xFF2E7D32),
        ),
      );
    }
  }

  Future<void> _chooseFromGallery() async {
    final photo = await HardwareService().pickImageFromGallery();
    if (photo != null && mounted) {
      setState(() => _localPhotoPath = photo.path);
      widget.onStateChanged(widget.state.copyWith(profilePhotoUrl: photo.path));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('🖼️ Profile photo selected from gallery!'),
          backgroundColor: Color(0xFF2E7D32),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultUrl = widget.state.profilePhotoUrl.isNotEmpty
        ? widget.state.profilePhotoUrl
        : 'https://images.unsplash.com/photo-1544005313-94ddf0286df2?auto=format&fit=crop&w=400&q=80';

    ImageProvider photoProvider;
    if (_localPhotoPath != null) {
      photoProvider = FileImage(File(_localPhotoPath!));
    } else {
      photoProvider = NetworkImage(defaultUrl);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OnboardingHeader(
                currentStep: 6,
                totalSteps: 7,
                title: 'Add Your Workshop Photo',
                subtitle: 'Buyers love seeing the authentic master artisan behind the handcrafted creations',
                onBack: widget.onBack,
              ),
              const Spacer(),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFA84318), width: 3.5),
                        image: DecorationImage(
                          image: photoProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: _takePhotoWithCamera,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                            color: Color(0xFFA84318),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
                            ],
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 22),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.photo_camera, size: 16),
                      label: const Text('Camera'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA84318),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _takePhotoWithCamera,
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton.icon(
                      icon: const Icon(Icons.photo_library, size: 16),
                      label: const Text('Gallery'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFA84318),
                        side: const BorderSide(color: Color(0xFFA84318)),
                      ),
                      onPressed: _chooseFromGallery,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  widget.state.artisanName.isNotEmpty ? widget.state.artisanName : 'Ramu Kumar',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF2D2421)),
                ),
              ),
              Center(
                child: Text(
                  widget.state.selectedCraft.isNotEmpty ? widget.state.selectedCraft : 'Master Bamboo Artisan',
                  style: const TextStyle(fontSize: 13, color: Color(0xFF7A685F)),
                ),
              ),
              const Spacer(),
              ActionButton(
                text: 'Continue / आगे बढ़ें',
                onPressed: () {
                  widget.onContinue();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
