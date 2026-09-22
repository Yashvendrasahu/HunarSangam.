// lib/add_product/widgets/add_product_app_bar.dart

import 'package:flutter/material.dart';

class AddProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? stepSubtitle;
  final String? badgeText;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final VoidCallback? onBack;
  final VoidCallback? onClose;
  final Widget? trailing;
  final String language;
  final ValueChanged<String>? onLanguageChanged;
  final bool showLanguageDropdown;

  const AddProductAppBar({
    super.key,
    required this.title,
    this.stepSubtitle,
    this.badgeText,
    this.badgeColor,
    this.badgeTextColor,
    this.onBack,
    this.onClose,
    this.trailing,
    this.language = 'English',
    this.onLanguageChanged,
    this.showLanguageDropdown = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back or Close Button
          if (onClose != null)
            IconButton(
              icon: const Icon(Icons.close, color: Color(0xFF2D2421), size: 24.0),
              onPressed: onClose,
              splashRadius: 22.0,
            )
          else if (onBack != null)
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF2D2421), size: 24.0),
              onPressed: onBack,
              splashRadius: 22.0,
            )
          else
            const SizedBox(width: 40.0),

          // Center Title + Step Header
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (stepSubtitle != null)
                  Text(
                    stepSubtitle!.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFB85324),
                      letterSpacing: 0.5,
                    ),
                  ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF221C19),
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                    if (badgeText != null) ...[
                      const SizedBox(width: 6.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.5),
                        decoration: BoxDecoration(
                          color: badgeColor ?? const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6.0,
                              height: 6.0,
                              decoration: BoxDecoration(
                                color: badgeTextColor ?? const Color(0xFF2E7D32),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              badgeText!,
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700,
                                color: badgeTextColor ?? const Color(0xFF2E7D32),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Trailing widget or language pill
          if (trailing != null)
            trailing!
          else if (showLanguageDropdown)
            PopupMenuButton<String>(
              onSelected: onLanguageChanged,
              itemBuilder: (ctx) => [
                const PopupMenuItem(value: 'English', child: Text('English')),
                const PopupMenuItem(value: 'हिंदी / Hindi', child: Text('हिंदी / Hindi')),
                const PopupMenuItem(value: 'অসমীয়া / Assamese', child: Text('অসমীয়া / Assamese')),
                const PopupMenuItem(value: 'বাংলা / Bengali', child: Text('বাংলা / Bengali')),
              ],
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E7DF),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFE5D5CB)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      language,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A372D),
                      ),
                    ),
                    const SizedBox(width: 2.0),
                    const Icon(Icons.arrow_drop_down, size: 16.0, color: Color(0xFF7B665C)),
                  ],
                ),
              ),
            )
          else
            const SizedBox(width: 40.0),
        ],
      ),
    );
  }
}
