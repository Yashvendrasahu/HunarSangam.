// lib/screens/artisan_orders_screen.dart

import 'package:flutter/material.dart';
import '../services/order_service.dart';
import '../models/order_model.dart';
import '../add_product/widgets/artisan_bottom_navigation.dart';

class ArtisanOrdersScreen extends StatefulWidget {
  final String artisanName;
  final ValueChanged<int>? onNavigateTab;
  final Function(String orderId, String buyerName, int totalQty, int completed)? onOrderTap;
  final VoidCallback? onOrderRequestTap;
  final VoidCallback? onCollaborateTap;
  final Function(String buyerName, String orderTitle)? onChatWithBuyer;

  const ArtisanOrdersScreen({
    super.key,
    this.artisanName = 'Ramu Kumar',
    this.onNavigateTab,
    this.onOrderTap,
    this.onOrderRequestTap,
    this.onCollaborateTap,
    this.onChatWithBuyer,
  });

  @override
  State<ArtisanOrdersScreen> createState() => _ArtisanOrdersScreenState();
}

class _ArtisanOrdersScreenState extends State<ArtisanOrdersScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['All Orders', 'In Production', 'Pending Advance', 'Completed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Orders & Production (${widget.artisanName})',
          style: const TextStyle(color: Color(0xFF2D2421), fontSize: 16, fontWeight: FontWeight.w800),
        ),
        actions: [
          if (widget.onOrderRequestTap != null)
            IconButton(
              icon: const Icon(Icons.notifications_active_outlined, color: Color(0xFFA84318)),
              onPressed: widget.onOrderRequestTap,
            ),
        ],
      ),
      body: Column(
        children: [
          // Filter tabs
          Container(
            height: 48,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _filters.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final isSelected = _selectedFilterIndex == index;
                return ChoiceChip(
                  label: Text(_filters[index]),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => _selectedFilterIndex = index);
                    }
                  },
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF6D4C41),
                  ),
                  selectedColor: const Color(0xFFA84318),
                  backgroundColor: const Color(0xFFF5EBE1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                );
              },
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEADFD6)),

          // Orders Stream
          Expanded(
            child: StreamBuilder<List<OrderModel>>(
              stream: OrderService().getArtisanOrdersStream(widget.artisanName),
              builder: (context, snapshot) {
                final orders = snapshot.data ?? [];
                if (orders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.assignment_outlined, size: 48, color: Color(0xFFD7CCC8)),
                        const SizedBox(height: 12),
                        const Text('No orders found in this status', style: TextStyle(color: Color(0xFF8D6E63))),
                        const SizedBox(height: 12),
                        if (widget.onOrderRequestTap != null)
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFA84318),
                              foregroundColor: Colors.white,
                            ),
                            onPressed: widget.onOrderRequestTap,
                            child: const Text('View Sample Order Request'),
                          ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: orders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final order = orders[index];
                    return InkWell(
                      onTap: () {
                        widget.onOrderTap?.call(
                          order.id,
                          order.buyerName,
                          order.unitsTotal,
                          order.unitsCompleted,
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFEADFD6)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  order.orderNumber,
                                  style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFFA84318), fontSize: 13),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8F5E9),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    order.status.toUpperCase(),
                                    style: const TextStyle(color: Color(0xFF2E7D32), fontSize: 10, fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              order.buyerName,
                              style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: Color(0xFF2D2421)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${order.unitsTotal} units • ₹${order.totalAmount.toInt()} (Escrow: ₹${order.escrowAmount.toInt()})',
                              style: const TextStyle(fontSize: 12.5, color: Color(0xFF7A685F)),
                            ),
                            const SizedBox(height: 10),
                            LinearProgressIndicator(
                              value: order.unitsTotal > 0 ? (order.unitsCompleted / order.unitsTotal) : 0,
                              backgroundColor: const Color(0xFFF5EBE1),
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFA84318)),
                              minHeight: 6,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Progress: ${order.unitsCompleted}/${order.unitsTotal} Units Made',
                                  style: const TextStyle(fontSize: 11, color: Color(0xFF8D6E63), fontWeight: FontWeight.w600),
                                ),
                                TextButton.icon(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(50, 30),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  icon: const Icon(Icons.chat_bubble_outline_rounded, size: 14, color: Color(0xFFA84318)),
                                  label: const Text(
                                    'Chat with Buyer',
                                    style: TextStyle(fontSize: 11.5, color: Color(0xFFA84318), fontWeight: FontWeight.w800),
                                  ),
                                  onPressed: () {
                                    if (widget.onChatWithBuyer != null) {
                                      widget.onChatWithBuyer!(order.buyerName, 'Order #${order.orderNumber}');
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: widget.onNavigateTab != null
          ? ArtisanBottomNavigation(
              currentIndex: 2,
              onTabSelected: widget.onNavigateTab,
            )
          : null,
    );
  }
}
