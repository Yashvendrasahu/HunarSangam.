// lib/screens/buyer_orders_hub_screen.dart
// Production-grade Flutter screen matching 'bulk - order section 1.png'
// Enterprise Buyer Portal - Orders & Production Management Hub

import 'package:flutter/material.dart';
import '../widgets/brand_logo_card.dart';

class BuyerOrdersHubScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final Function(String orderId)? onViewOrderDetails;
  final Function(String orderId)? onMessageArtisan;
  final VoidCallback? onOpenHome;
  final VoidCallback? onOpenDiscover;
  final VoidCallback? onOpenRequirements;
  final VoidCallback? onOpenProfile;

  const BuyerOrdersHubScreen({
    super.key,
    this.onBack,
    this.onViewOrderDetails,
    this.onMessageArtisan,
    this.onOpenHome,
    this.onOpenDiscover,
    this.onOpenRequirements,
    this.onOpenProfile,
  });

  @override
  State<BuyerOrdersHubScreen> createState() => _BuyerOrdersHubScreenState();
}

class _BuyerOrdersHubScreenState extends State<BuyerOrdersHubScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['All (4)', 'Pending 1', 'Accepted', 'In Production', 'Completed'];

  @override
  Widget build(BuildContext context) {
    const Color primaryRust = Color(0xFF9C3C18);
    const Color textDark = Color(0xFF1F1612);
    const Color textMuted = Color(0xFF7A6A60);
    const Color bgCanvas = Color(0xFFFCF9F6);

    return Scaffold(
      backgroundColor: bgCanvas,
      appBar: AppBar(
        backgroundColor: bgCanvas,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryRust),
          onPressed: widget.onBack ?? () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Orders & Production',
          style: TextStyle(
            color: primaryRust,
            fontWeight: FontWeight.w900,
            fontSize: 19,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: textDark),
            onPressed: () {},
          ),
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: primaryRust,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                // Enterprise Buyer Portal Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'ENTERPRISE BUYER PORTAL',
                            style: TextStyle(
                              color: primaryRust,
                              fontWeight: FontWeight.w900,
                              fontSize: 11,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Track the orders you\'ve placed with artisans',
                            style: TextStyle(
                              color: textMuted,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFA5D6A7)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: Color(0xFF2E7D32),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            '4 Active',
                            style: TextStyle(
                              color: Color(0xFF1B5E20),
                              fontWeight: FontWeight.w800,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Filter Tabs
                SizedBox(
                  height: 34,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filters.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final isSelected = _selectedFilterIndex == index;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedFilterIndex = index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryRust : const Color(0xFFF9F1EA),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isSelected ? primaryRust : const Color(0xFFEADBCE),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _filters[index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : const Color(0xFF3B281E),
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // ORDER 1: Handwoven Bamboo Baskets (In Production 65%)
                _buildOrderCard(
                  context: context,
                  orderId: '#HS-BKT-892',
                  datePlaced: '17 Sep 2026',
                  quantity: '500 pieces',
                  requiredDate: '28 Oct 2026',
                  statusBadge: 'In Production (65%)',
                  statusBg: const Color(0xFFD1FAE5),
                  statusText: const Color(0xFF065F46),
                  statusDot: const Color(0xFF10B981),
                  title: 'Handwoven Bamboo Baskets',
                  artisan: 'Ramesh Kumar • Barpeta Bamboo',
                  orderValue: '₹1,90,000',
                  imageUrl: 'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=300&q=80',
                  showProgress: true,
                  primaryActionText: 'View Status / Details',
                  onPrimaryAction: () => widget.onViewOrderDetails?.call('HS-BKT-892'),
                  onSecondaryAction: () => widget.onMessageArtisan?.call('HS-BKT-892'),
                ),
                const SizedBox(height: 14),

                // ORDER 2: Hexagonal Bamboo Planters (Awaiting Artisan)
                _buildOrderCard(
                  context: context,
                  orderId: '#HS-ORD-8819',
                  datePlaced: '18 Sep 2026',
                  quantity: '200 pieces',
                  requiredDate: '15 Nov 2026',
                  statusBadge: '⏳ Awaiting Artisan',
                  statusBg: const Color(0xFFFEF3C7),
                  statusText: const Color(0xFF92400E),
                  title: 'Hexagonal Bamboo Planters',
                  artisan: 'Sunita Devi • Barpeta Women SHG',
                  orderValue: '₹76,000',
                  imageUrl: 'https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=300&q=80',
                  footerNote: 'Artisan has 18 hrs left to review',
                  singleButtonAction: true,
                  primaryActionText: 'View Status / Details',
                  onPrimaryAction: () => widget.onViewOrderDetails?.call('HS-ORD-8819'),
                ),
                const SizedBox(height: 14),

                // ORDER 3: Clay Terracotta Kulhads (Counter Offer Received)
                _buildCounterOfferCard(
                  context: context,
                  orderId: '#HS-ORD-8740',
                  datePlaced: '16 Sep 2026',
                  quantity: '1,000 pieces',
                  requiredDate: '20 Oct 2026',
                  title: 'Clay Terracotta Kulhads',
                  artisan: 'Kishan Prajapati • Kutch Guild',
                  originalValue: '₹45,000',
                  counterOfferText: 'Artisan offered: 900 pcs @ ₹48',
                  note: 'Kiln capacity limits initial batch to 900 units before festival cutoff.',
                  imageUrl: 'https://images.unsplash.com/photo-1578749556568-bc2c40e68b61?auto=format&fit=crop&w=300&q=80',
                  onReview: () => widget.onViewOrderDetails?.call('HS-ORD-8740'),
                  onAcceptCounter: () => widget.onViewOrderDetails?.call('HS-ORD-8740'),
                ),
                const SizedBox(height: 14),

                // ORDER 4: Handcrafted Sheesham Trays (Completed)
                _buildCompletedCard(
                  context: context,
                  orderId: '#HS-ORD-8210',
                  deliveredDate: '05 Sep 2026',
                  quantitySummary: '150 pieces • Delivered successfully',
                  title: 'Handcrafted Sheesham Trays',
                  artisan: 'Mohammad Yusuf • Saharanpur Wood',
                  settledValue: '₹52,500',
                  imageUrl: 'https://images.unsplash.com/photo-1513519245088-0e12902e5a38?auto=format&fit=crop&w=300&q=80',
                  onReorder: () {},
                  onViewDetails: () => widget.onViewOrderDetails?.call('HS-ORD-8210'),
                ),
                const SizedBox(height: 16),

                // Craft Trust Escrow Protected Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBF4ED),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFF0DEC8)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD1FAE5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.shield_outlined, color: Color(0xFF065F46), size: 24),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Craft Trust Escrow Protected',
                              style: TextStyle(
                                color: Color(0xFF1F1612),
                                fontWeight: FontWeight.w900,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Protected by HunarSangam Craft Trust Escrow — Staged milestone releases tied to verified craft progress.',
                              style: TextStyle(
                                color: Color(0xFF6B5A4E),
                                fontSize: 11.5,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Icon(Icons.lock_outline, size: 13, color: Color(0xFF065F46)),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    '100% Buyer Guarantee on Defective Batches',
                                    style: TextStyle(
                                      color: Color(0xFF065F46),
                                      fontWeight: FontWeight.w800,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),

          // Bottom Navigation
          _buildBottomNav(),
        ],
      ),
    );
  }

  Widget _buildOrderCard({
    required BuildContext context,
    required String orderId,
    required String datePlaced,
    required String quantity,
    required String requiredDate,
    required String statusBadge,
    required Color statusBg,
    required Color statusText,
    Color? statusDot,
    required String title,
    required String artisan,
    required String orderValue,
    required String imageUrl,
    bool showProgress = false,
    String? footerNote,
    bool singleButtonAction = false,
    required String primaryActionText,
    required VoidCallback onPrimaryAction,
    VoidCallback? onSecondaryAction,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFF0DFD3)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order ID & Status Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '$orderId • Placed: $datePlaced\n$quantity • Required: $requiredDate',
                  style: const TextStyle(
                    color: Color(0xFF7A6A60),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    height: 1.35,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (statusDot != null) ...[
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: statusDot,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                    ],
                    Text(
                      statusBadge,
                      style: TextStyle(
                        color: statusText,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Product & Artisan Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: 62,
                  height: 62,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF1F1612),
                        fontWeight: FontWeight.w900,
                        fontSize: 14.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.storefront, size: 13, color: Color(0xFF9C3C18)),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            artisan,
                            style: const TextStyle(
                              color: Color(0xFF7A6A60),
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'Order Value: ',
                        style: const TextStyle(
                          color: Color(0xFF7A6A60),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: orderValue,
                            style: const TextStyle(
                              color: Color(0xFF9C3C18),
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Progress Milestone Box (if active)
          if (showProgress) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF2EB),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFEFE0D5)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('✓ Raw Material', style: TextStyle(color: Color(0xFF065F46), fontSize: 9.5, fontWeight: FontWeight.bold)),
                      Text('↻ Weaving ⌛', style: TextStyle(color: Color(0xFF9C3C18), fontSize: 9.5, fontWeight: FontWeight.bold)),
                      Text('QC Audit', style: TextStyle(color: Color(0xFF7A6A60), fontSize: 9.5, fontWeight: FontWeight.w600)),
                      Text('Dispatch', style: TextStyle(color: Color(0xFF7A6A60), fontSize: 9.5, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: SizedBox(
                      height: 6,
                      child: Row(
                        children: [
                          Expanded(flex: 30, child: Container(color: const Color(0xFF10B981))),
                          Expanded(flex: 35, child: Container(color: const Color(0xFF9C3C18))),
                          Expanded(flex: 35, child: Container(color: const Color(0xFFE5D5C8))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Milestone 2 of 4 reached', style: TextStyle(color: Color(0xFF7A6A60), fontSize: 10, fontWeight: FontWeight.w600)),
                      Text('Stage verified on video', style: TextStyle(color: Color(0xFF9C3C18), fontSize: 10, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 12),

          // Bottom Action Row
          if (singleButtonAction) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (footerNote != null)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        footerNote,
                        style: const TextStyle(
                          color: Color(0xFF7A6A60),
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                OutlinedButton(
                  onPressed: onPrimaryAction,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF9C3C18),
                    side: const BorderSide(color: Color(0xFF9C3C18)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('View Status / Details', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 13),
                    ],
                  ),
                ),
              ],
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onSecondaryAction ?? () {},
                    icon: const Icon(Icons.chat_bubble_outline, size: 14),
                    label: const Text('Message Craft Maker', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF1F1612),
                      side: const BorderSide(color: Color(0xFFDCC8BB)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPrimaryAction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9C3C18),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('View Status /\nDetails', textAlign: TextAlign.center, style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold)),
                        SizedBox(width: 4),
                        Icon(Icons.arrow_forward, size: 14),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCounterOfferCard({
    required BuildContext context,
    required String orderId,
    required String datePlaced,
    required String quantity,
    required String requiredDate,
    required String title,
    required String artisan,
    required String originalValue,
    required String counterOfferText,
    required String note,
    required String imageUrl,
    required VoidCallback onReview,
    required VoidCallback onAcceptCounter,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFF0DFD3)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$orderId • Placed:\n$datePlaced\n$quantity •\nRequired: $requiredDate',
                style: const TextStyle(color: Color(0xFF7A6A60), fontSize: 11, fontWeight: FontWeight.w700, height: 1.3),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.swap_horiz, size: 13, color: Color(0xFF92400E)),
                    SizedBox(width: 4),
                    Text('Counter Offer Received', style: TextStyle(color: Color(0xFF92400E), fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(imageUrl, width: 62, height: 62, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Color(0xFF1F1612), fontWeight: FontWeight.w900, fontSize: 14.5)),
                    const SizedBox(height: 2),
                    Text(artisan, style: const TextStyle(color: Color(0xFF7A6A60), fontSize: 11)),
                    const SizedBox(height: 2),
                    Text(originalValue, style: const TextStyle(color: Color(0xFF9C3C18), fontWeight: FontWeight.w900, fontSize: 15)),
                    Text(counterOfferText, style: const TextStyle(color: Color(0xFF92400E), fontWeight: FontWeight.w700, fontSize: 10.5)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFDE68A)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.info_outline, size: 14, color: Color(0xFFB45309)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(note, style: const TextStyle(color: Color(0xFF78350F), fontSize: 10.5, height: 1.3)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: onReview,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1F1612),
                    side: const BorderSide(color: Color(0xFFDCC8BB)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: const Text('Review Proposal', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: onAcceptCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9C3C18),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Accept / Counter', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 13),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedCard({
    required BuildContext context,
    required String orderId,
    required String deliveredDate,
    required String quantitySummary,
    required String title,
    required String artisan,
    required String settledValue,
    required String imageUrl,
    required VoidCallback onReorder,
    required VoidCallback onViewDetails,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFF0DFD3)),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$orderId • Delivered: $deliveredDate\n$quantitySummary',
                style: const TextStyle(color: Color(0xFF7A6A60), fontSize: 11, fontWeight: FontWeight.w700, height: 1.3),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFD1FAE5),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.check_circle_outline, size: 12, color: Color(0xFF065F46)),
                    SizedBox(width: 3),
                    Text('Completed ✓', style: TextStyle(color: Color(0xFF065F46), fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(imageUrl, width: 62, height: 62, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: Color(0xFF1F1612), fontWeight: FontWeight.w900, fontSize: 14.5)),
                    const SizedBox(height: 2),
                    Text(artisan, style: const TextStyle(color: Color(0xFF7A6A60), fontSize: 11)),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        text: 'Settled Value: ',
                        style: const TextStyle(color: Color(0xFF7A6A60), fontSize: 11, fontWeight: FontWeight.w600),
                        children: [
                          TextSpan(text: settledValue, style: const TextStyle(color: Color(0xFF1F1612), fontWeight: FontWeight.w900, fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onReorder,
                  icon: const Icon(Icons.refresh, size: 14),
                  label: const Text('+ Reorder', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF1F1612),
                    side: const BorderSide(color: Color(0xFFDCC8BB)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: onViewDetails,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF9C3C18),
                    side: const BorderSide(color: Color(0xFF9C3C18)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('View Status / Details', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward, size: 13),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEFE2D8))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(Icons.home_outlined, 'Home', false, widget.onOpenHome),
          _buildNavItem(Icons.explore_outlined, 'Discover', false, widget.onOpenDiscover),
          _buildNavItem(Icons.assignment_outlined, 'Requirement', false, widget.onOpenRequirements),
          _buildNavItem(Icons.local_shipping, 'Order', true, () {}),
          _buildNavItem(Icons.person_outline, 'Profile', false, widget.onOpenProfile),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected, VoidCallback? onTap) {
    const Color primaryRust = Color(0xFF9C3C18);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isSelected ? primaryRust : const Color(0xFF7A6A60), size: 22),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? primaryRust : const Color(0xFF7A6A60),
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
