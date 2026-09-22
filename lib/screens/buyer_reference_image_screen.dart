// lib/screens/buyer_reference_image_screen.dart
// 100% UI Match for 'r4- bulk  — Reference Image.png'
// Post Bulk Requirement - Step 2 of 4: Reference Image & Details

import 'package:flutter/material.dart';
import '../widgets/buyer_bottom_nav_bar.dart';
import '../services/hardware_service.dart';

class BuyerReferenceImageScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onContinue;
  final VoidCallback onSkip;
  final VoidCallback onOpenRequirements;
  final VoidCallback onOpenDiscover;
  final VoidCallback onOpenHome;
  final VoidCallback? onOpenOrders;
  final VoidCallback? onOpenProfile;

  const BuyerReferenceImageScreen({
    super.key,
    required this.onBack,
    required this.onContinue,
    required this.onSkip,
    required this.onOpenRequirements,
    required this.onOpenDiscover,
    required this.onOpenHome,
    this.onOpenOrders,
    this.onOpenProfile,
  });

  @override
  State<BuyerReferenceImageScreen> createState() => _BuyerReferenceImageScreenState();
}

class _BuyerReferenceImageScreenState extends State<BuyerReferenceImageScreen> {
  final TextEditingController _notesController = TextEditingController(
    text:
        'Please ensure rim edges are smooth sanded with zero splinters. All baskets must nest inside each other in sets of 3 for compact shipping.',
  );

  bool _customBranding = true;
  bool _foodGradeVarnish = true;
  bool _ecoPackaging = true;
  bool _fumigationCert = false;

  final List<Map<String, String>> _uploadedAssets = [
    {
      'title': 'bamboo_basket_sample_angle1.jpg',
      'size': '2.4 MB • Primary Master Spec',
      'tag': 'High-Res CAD / Photo',
    },
    {
      'title': 'dual_rim_weave_pattern_spec.png',
      'size': '1.1 MB • Secondary Detail',
      'tag': 'Detail Spec',
    },
  ];

  Future<void> _handleCamera() async {
    final photo = await HardwareService().captureImageFromCamera();
    if (photo != null && mounted) {
      setState(() {
        _uploadedAssets.add({
          'title': photo.name,
          'size': '1.8 MB • Camera Snapshot',
          'tag': 'Captured Photo',
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('📸 Reference photo captured: ${photo.name}'),
          backgroundColor: const Color(0xFF2E7D32),
        ),
      );
    }
  }

  Future<void> _handleGallery() async {
    final file = await HardwareService().pickImageFromGallery();
    if (file != null && mounted) {
      setState(() {
        _uploadedAssets.add({
          'title': file.name,
          'size': '2.2 MB • Gallery Upload',
          'tag': 'Spec Sheet',
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🖼️ Spec sheet attached: ${file.name}'),
          backgroundColor: const Color(0xFF2E7D32),
        ),
      );
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bgWarm = Color(0xFFFCF9F6);
    const textDark = Color(0xFF1E1714);
    const terracotta = Color(0xFF9E401A);
    const borderBeige = Color(0xFFEDE4DC);

    return Scaffold(
      backgroundColor: bgWarm,
      appBar: AppBar(
        backgroundColor: bgWarm,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: textDark, size: 22),
          onPressed: widget.onBack,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Post Bulk Requirement',
              style: TextStyle(
                color: terracotta,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
            Text(
              'Step 2 of 4: Reference Image & Details',
              style: TextStyle(
                color: Color(0xFF7A6D66),
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: widget.onSkip,
            child: const Text(
              'Skip for Now',
              style: TextStyle(
                color: Color(0xFF8D8078),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          children: [
            // 1. Heading
            const Text(
              'Share Reference Photos or CAD / Sketches',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: textDark,
                letterSpacing: -0.4,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Help artisans understand your exact weave pattern, dimensions, finish quality, and packaging expectation.',
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF70645E),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),

            // 2. Drag & drop / upload card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFDFD0C3), style: BorderStyle.solid),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFBF1EB),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.cloud_upload_outlined, color: terracotta, size: 28),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Drag & drop photos or tap to upload',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: textDark),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Supports JPG, PNG, WEBP, PDF spec sheets (up to 15MB each)',
                    style: TextStyle(fontSize: 11.5, color: Color(0xFF8D8078)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _handleCamera,
                          icon: const Icon(Icons.camera_alt_outlined, size: 16, color: terracotta),
                          label: const Text(
                            'Take Photo',
                            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: terracotta),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFDFD0C3)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            backgroundColor: const Color(0xFFFCFAF7),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _handleGallery,
                          icon: const Icon(Icons.photo_library_outlined, size: 16, color: textDark),
                          label: const Text(
                            'Upload Gallery',
                            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: textDark),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFDFD0C3)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            backgroundColor: const Color(0xFFFCFAF7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // 3. Uploaded Reference Assets (2)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Uploaded Reference Assets (${_uploadedAssets.length})',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: textDark),
                ),
                TextButton(
                  onPressed: _handleGallery,
                  child: const Text(
                    '+ Add More',
                    style: TextStyle(color: terracotta, fontSize: 12.5, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            ..._uploadedAssets.map((asset) => _buildAssetItem(asset)),

            const SizedBox(height: 22),

            // 4. Quality & Customization Requirements
            const Text(
              'Quality & Customization Requirements',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: textDark),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderBeige),
              ),
              child: Column(
                children: [
                  _buildCheckboxTile(
                    title: 'Custom brand laser engraving / tag attachment',
                    value: _customBranding,
                    onChanged: (v) => setState(() => _customBranding = v ?? false),
                  ),
                  const Divider(height: 1, color: Color(0xFFF3ECE5), indent: 14, endIndent: 14),
                  _buildCheckboxTile(
                    title: 'Food-grade non-toxic organic varnish coating',
                    value: _foodGradeVarnish,
                    onChanged: (v) => setState(() => _foodGradeVarnish = v ?? false),
                  ),
                  const Divider(height: 1, color: Color(0xFFF3ECE5), indent: 14, endIndent: 14),
                  _buildCheckboxTile(
                    title: 'Individual eco-friendly corrugated packing box',
                    value: _ecoPackaging,
                    onChanged: (v) => setState(() => _ecoPackaging = v ?? false),
                  ),
                  const Divider(height: 1, color: Color(0xFFF3ECE5), indent: 14, endIndent: 14),
                  _buildCheckboxTile(
                    title: 'Export grade fumigation certificate (Phytosanitary)',
                    value: _fumigationCert,
                    onChanged: (v) => setState(() => _fumigationCert = v ?? false),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // 5. Special Instructions & Notes for Artisan
            const Text(
              'Special Instructions & Notes for Artisan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: textDark),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderBeige),
              ),
              child: TextField(
                controller: _notesController,
                maxLines: 3,
                style: const TextStyle(fontSize: 13.5, color: textDark, height: 1.4),
                decoration: const InputDecoration(
                  hintText: 'Enter any specific dimensions, weave tightness or packaging instructions...',
                  hintStyle: TextStyle(fontSize: 12.5, color: Color(0xFFA89E97)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 6. Save & Review Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: terracotta,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Save & Review Requirement',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 6),
                    Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BuyerBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) widget.onOpenHome();
          if (index == 1) widget.onOpenDiscover();
          if (index == 2) widget.onOpenRequirements();
          if (index == 3 && widget.onOpenOrders != null) widget.onOpenOrders!();
          if (index == 4 && widget.onOpenProfile != null) widget.onOpenProfile!();
        },
      ),
    );
  }

  Widget _buildAssetItem(Map<String, String> asset) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFEDE4DC)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFFBF4ED),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFEFE6DE)),
            ),
            child: const Icon(Icons.image_outlined, color: Color(0xFF9E401A), size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  asset['title'] ?? '',
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E1714),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  asset['size'] ?? '',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF8D8078)),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '✔ ${asset['tag']}',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, size: 20, color: Color(0xFF8D8078)),
            onPressed: () {
              setState(() {
                _uploadedAssets.remove(asset);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxTile({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFF9E401A),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E1714),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
