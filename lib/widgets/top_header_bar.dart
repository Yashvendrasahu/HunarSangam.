// lib/widgets/top_header_bar.dart

import 'package:flutter/material.dart';

class TopHeaderBar extends StatelessWidget {
  final String? title;
  final VoidCallback? onBack;
  final List<Widget>? actions;

  const TopHeaderBar({
    super.key,
    this.title,
    this.onBack,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
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
            Text(
              title!,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1F1612),
              ),
            ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: actions ?? [const SizedBox(width: 40)],
          ),
        ],
      ),
    );
  }
}
