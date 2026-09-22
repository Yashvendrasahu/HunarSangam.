// lib/screens/conversations_list_screen.dart

import 'package:flutter/material.dart';

class ConversationItemData {
  final String id;
  final String buyerName;
  final String orderNumber;
  final String orderTitle;
  final String escrowAmount;
  final String deliveryDate;
  final String lastMessage;
  final String time;
  final int unreadCount;

  const ConversationItemData({
    required this.id,
    required this.buyerName,
    required this.orderNumber,
    required this.orderTitle,
    required this.escrowAmount,
    required this.deliveryDate,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
  });
}

class ConversationsListScreen extends StatelessWidget {
  final String userRole; // 'artisan' or 'buyer'
  final String currentUserName;
  final VoidCallback onBack;
  final ValueChanged<ConversationItemData> onOpenConversation;

  const ConversationsListScreen({
    super.key,
    this.userRole = 'artisan',
    required this.currentUserName,
    required this.onBack,
    required this.onOpenConversation,
  });

  @override
  Widget build(BuildContext context) {
    final demoConversations = [
      const ConversationItemData(
        id: 'conv_1',
        buyerName: 'FabIndia Retail Network',
        orderNumber: 'PO-2026-8891',
        orderTitle: 'Woven Bamboo Fruit Baskets (50 pcs)',
        escrowAmount: '₹5,600',
        deliveryDate: '28 Mar 2026',
        lastMessage: 'Advance payment released into escrow account.',
        time: '10:45 AM',
        unreadCount: 1,
      ),
      const ConversationItemData(
        id: 'conv_2',
        buyerName: 'The Bombay Store (Mumbai)',
        orderNumber: 'PO-2026-9042',
        orderTitle: 'Terracotta Planters (60 pcs)',
        escrowAmount: '₹10,800',
        deliveryDate: '05 Apr 2026',
        lastMessage: 'Can you confirm the packaging specification?',
        time: 'Yesterday',
        unreadCount: 0,
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D2421)),
          onPressed: onBack,
        ),
        title: Text(
          '$currentUserName Discussions',
          style: const TextStyle(color: Color(0xFF2D2421), fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: demoConversations.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final conv = demoConversations[index];
          return InkWell(
            onTap: () => onOpenConversation(conv),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFEADFD6)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFFFDECE8),
                    child: Text(
                      conv.buyerName.substring(0, 1),
                      style: const TextStyle(color: Color(0xFFA84318), fontWeight: FontWeight.w800),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              conv.buyerName,
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: Color(0xFF2D2421)),
                            ),
                            Text(
                              conv.time,
                              style: const TextStyle(fontSize: 11, color: Color(0xFF8D6E63)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          conv.orderTitle,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFFA84318)),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          conv.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12, color: Color(0xFF7A685F)),
                        ),
                      ],
                    ),
                  ),
                  if (conv.unreadCount > 0) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFFA84318),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${conv.unreadCount}',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
