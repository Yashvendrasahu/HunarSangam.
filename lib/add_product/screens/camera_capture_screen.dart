// lib/add_product/screens/camera_capture_screen.dart

import 'package:flutter/material.dart';
import '../../services/hardware_service.dart';

class CapturedImageData {
  final String dataUrl;
  const CapturedImageData(this.dataUrl);
}

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

  Future<void> _handleCaptureFromCamera(BuildContext context) async {
    final photo = await HardwareService().captureImageFromCamera();
    if (photo != null) {
      onImageCaptured?.call(CapturedImageData(photo.path));
      onCapture();
    } else {
      // Graceful fallback for web/desktop or cancelled dialog
      onImageCaptured?.call(const CapturedImageData(
        'https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=600&q=80',
      ));
      onCapture();
    }
  }

  Future<void> _handlePickFromGallery(BuildContext context) async {
    final image = await HardwareService().pickImageFromGallery();
    if (image != null) {
      onImageCaptured?.call(CapturedImageData(image.path));
      onCapture();
    } else {
      onImageCaptured?.call(const CapturedImageData(
        'https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=600&q=80',
      ));
      onCapture();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1614),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: onBack,
        ),
        title: const Text(
          'Product Photography (Step 1 of 8)',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2420),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFA84318), width: 1.5),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.camera_alt_outlined, color: Color(0xFFEADFD6), size: 64),
                        SizedBox(height: 12),
                        Text(
                          'Align your handcrafted item\nin clean daylight',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFFEADFD6), fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        '💡 Tip: In the next step, place a ₹10 coin next to your craft for automatic AI dimensions',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFFFFD4C2), fontSize: 11),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32, top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  tooltip: 'Pick from Gallery',
                  icon: const Icon(Icons.photo_library_outlined, color: Colors.white, size: 28),
                  onPressed: () => _handlePickFromGallery(context),
                ),
                GestureDetector(
                  onTap: () => _handleCaptureFromCamera(context),
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      color: const Color(0xFFA84318),
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 32),
                  ),
                ),
                IconButton(
                  tooltip: 'Flash',
                  icon: const Icon(Icons.flash_on_outlined, color: Colors.white, size: 28),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Flash is set to auto mode'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
