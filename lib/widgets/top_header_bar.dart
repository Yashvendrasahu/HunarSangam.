// lib/widgets/top_header_bar.dart

import 'package:flutter/material.dart';
import 'api_config_dialog.dart';
import '../services/supabase_config.dart';

class TopHeaderBar extends StatelessWidget {
  final String? title;
  final VoidCallback? onBack;
  final List<Widget>? actions;
  final bool showCloudStatus;

  const TopHeaderBar({
    super.key,
    this.title,
    this.onBack,
    this.actions,
    this.showCloudStatus = true,
  });

  @override
  Widget build(BuildContext context) {
    final hasSupabase = SupabaseConfig.isSupabaseConfigured();
    final hasGemini = SupabaseConfig.isGeminiConfigured();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (onBack != null)
            IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Color(0xFF1F1612)),
              onPressed: onBack,
            )
          else
            const SizedBox(width: 40),
          if (title != null)
            Expanded(
              child: Text(
                title!,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1F1612),
                ),
              ),
            ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showCloudStatus)
                IconButton(
                  tooltip: 'Cloud & AI Setup',
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(Icons.tune_rounded, size: 20, color: Color(0xFF5A483E)),
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (hasSupabase && hasGemini) ? const Color(0xFF2E7D32) : const Color(0xFFE65100),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () => ApiConfigDialog.show(context),
                ),
              ...?actions,
              if (actions == null && !showCloudStatus) const SizedBox(width: 40),
            ],
          ),
        ],
      ),
    );
  }
}
