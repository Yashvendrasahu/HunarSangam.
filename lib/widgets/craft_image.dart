// lib/widgets/craft_image.dart

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../utils/craft_assets.dart';

/// Robust image widget that seamlessly displays:
/// 1. Real Device Camera File Paths (e.g. /data/user/0/... or /storage/...)
/// 2. Web Blobs & Data URLs (blob:http://... or data:image/...)
/// 3. Flutter Asset paths (assets/...)
/// 4. Remote HTTPS URLs
///
/// If any image is invalid or missing, it gracefully falls back to authentic,
/// GI-cluster verified Indian handicraft visuals matching the craft category.
class CraftImage extends StatelessWidget {
  final String? imageSource;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final String craftCategoryOrTitle;
  final Widget? placeholder;

  const CraftImage({
    super.key,
    required this.imageSource,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.craftCategoryOrTitle = 'Bamboo & Cane',
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    final src = (imageSource ?? '').trim();
    final fallbackUrl = CraftAssets.getCraftFallbackImage(craftCategoryOrTitle);

    Widget imageWidget;

    if (src.isEmpty) {
      imageWidget = _buildNetworkImage(fallbackUrl);
    } else if (src.startsWith('assets/')) {
      imageWidget = Image.asset(
        src,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (ctx, err, stack) => _buildNetworkImage(fallbackUrl),
      );
    } else if (src.startsWith('http://') || src.startsWith('https://') || (kIsWeb && src.startsWith('blob:'))) {
      imageWidget = _buildNetworkImage(src, fallbackUrl: fallbackUrl);
    } else if (src.startsWith('data:image/')) {
      // Data URI
      imageWidget = Image.network(
        src,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (ctx, err, stack) => _buildNetworkImage(fallbackUrl),
      );
    } else {
      // Real Device Camera File (Mobile Android/iOS)
      if (kIsWeb) {
        imageWidget = _buildNetworkImage(src, fallbackUrl: fallbackUrl);
      } else {
        final file = File(src);
        if (file.existsSync()) {
          imageWidget = Image.file(
            file,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (ctx, err, stack) => _buildNetworkImage(fallbackUrl),
          );
        } else {
          imageWidget = _buildNetworkImage(fallbackUrl);
        }
      }
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildNetworkImage(String url, {String? fallbackUrl}) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return placeholder ??
            Container(
              width: width,
              height: height,
              color: const Color(0xFFF3EAE3),
              child: const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFBA4B20)),
                  ),
                ),
              ),
            );
      },
      errorBuilder: (context, error, stackTrace) {
        if (fallbackUrl != null && fallbackUrl != url) {
          return Image.network(
            fallbackUrl,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (ctx, err, stack) => _buildFallbackContainer(),
          );
        }
        return _buildFallbackContainer();
      },
    );
  }

  Widget _buildFallbackContainer() {
    return Container(
      width: width,
      height: height,
      color: const Color(0xFFF3EAE3),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          color: const Color(0xFFBA4B20).withOpacity(0.5),
          size: (width != null && width! < 50) ? 20 : 36,
        ),
      ),
    );
  }
}
