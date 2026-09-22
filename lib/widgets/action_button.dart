// lib/widgets/action_button.dart

import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;
  final IconData? footerIcon;
  final Color? backgroundColor;
  final Color? textColor;
  final String? footerNote;

  const ActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
    this.footerIcon,
    this.backgroundColor,
    this.textColor,
    this.footerNote,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: 52,
          child: isOutlined
              ? OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: textColor ?? const Color(0xFFA84318),
                    side: BorderSide(color: backgroundColor ?? const Color(0xFFA84318), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: isLoading ? null : onPressed,
                  child: _buildContent(),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor ?? const Color(0xFFA84318),
                    foregroundColor: textColor ?? Colors.white,
                    disabledBackgroundColor: const Color(0xFFD7CCC8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: isLoading ? null : onPressed,
                  child: _buildContent(),
                ),
        ),
        if (footerNote != null) ...[
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (footerIcon != null) ...[
                Icon(footerIcon, size: 14, color: const Color(0xFF8D6E63)),
                const SizedBox(width: 4),
              ],
              Text(
                footerNote!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF8D6E63),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
