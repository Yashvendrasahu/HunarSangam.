// lib/add_product/screens/camera_capture_screen.dart

import 'package:flutter/material.dart';
import '../../services/hardware_service.dart';
import '../widgets/artisan_studio_tips.dart';

class CapturedImageData {
  final String dataUrl;
  const CapturedImageData(this.dataUrl);
}

/// Screen matching 'p2-camer open.png'
/// Step 2 of 3 • Product Photography
class CameraCaptureScreen extends StatelessWidget {
  final ValueChanged<CapturedImageData?>? onImageCaptured;
  final VoidCallback onCapture;
  final VoidCallback onBack;

  const CameraCaptureScreen({
    super.key,
    this.onImageCaptured,
    required this.onCapture,
    required this.onBack,
  });

  Future<void> _handleCapture(BuildContext context) async {
    final photo = await HardwareService().captureImageFromCamera();
    if (photo != null) {
      onImageCaptured?.call(CapturedImageData(photo.path));
      onCapture();
    }
  }

  Future<void> _handleGallery(BuildContext context) async {
    final photo = await HardwareService().pickImageFromGallery();
    if (photo != null) {
      onImageCaptured?.call(CapturedImageData(photo.path));
      onCapture();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF1F1612)),
                      onPressed: onBack,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'STEP 2 OF 3',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFBA4B20),
                          letterSpacing: 0.8,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        'Product Photography',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1F1612),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Camera Viewfinder Canvas
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFD3D8D7),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 64,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Frame your handcrafted product\nwith natural lighting',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Artisan Studio Tips Box
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: ArtisanStudioTips(),
            ),

            // Shutter Button & Gallery Option
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 20.0, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo_library_outlined, size: 28, color: Color(0xFF8C3A16)),
                    tooltip: 'Choose from Gallery',
                    onPressed: () => _handleGallery(context),
                  ),
                  GestureDetector(
                    onTap: () => _handleCapture(context),
                    child: Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFF3D5C5),
                        border: Border.all(color: const Color(0xFFE5BFA8), width: 3),
                      ),
                      child: Center(
                        child: Container(
                          width: 58,
                          height: 58,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF9C3C18),
                          ),
                          child: const Center(
                            child: Text(
                              'Click',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.flash_auto_outlined, size: 28, color: Color(0xFF8C3A16)),
                    tooltip: 'Flash',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
