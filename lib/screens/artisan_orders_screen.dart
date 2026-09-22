// lib/screens/artisan_orders_screen.dart

import 'package:flutter/material.dart';
import '../services/order_service.dart';
import '../models/order_model.dart';
import '../add_product/widgets/artisan_bottom_navigation.dart';

/// Screen o1: Artisan Orders - First Page
/// Exactly reproduces 'o1- order first page.png'
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
  final List<String> _filters = ['All Orders (3)', 'In Production (2)', 'Payment Due (1)'];

  static const Color _primaryRust = Color(0xFF9C3C18);
  static const Color _bgCanvas = Color(0xFFFDFBF9);
  static const Color _textDark = Color(0xFF1F1612);
  static const Color _textMuted = Color(0xFF6B5A51);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgCanvas,
      appBar: _buildTopAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title & Live Hub
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Artisan Orders',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: _textDark,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        'Production management for ${widget.artisanName}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: _textMuted,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: Color(0xFF2E7D32),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        const Text(
                          'Live Hub',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14.0),

              // 2x2 Metric Cards
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Total Active',
                      value: '₹1,42,000',
                      subtext: '₹56,800 Escrow Advance',
                      icon: Icons.account_balance_wallet_outlined,
                      isGreenLock: true,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'Bulk Orders',
                      value: '3 Active POs',
                      subtext: '2 Producing • 1 Sample',
                      icon: Icons.receipt_long_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      title: 'March Capacity',
                      value: '92% Utilized',
                      subtext: '230 / 250 pcs booked',
                      icon: Icons.pie_chart_outline,
                      showProgressBar: true,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: _buildMetricCard(
                      title: 'SLA Health',
                      value: '0 Delayed',
                      subtext: '100% On-Time Record',
                      icon: Icons.verified_outlined,
                      valueColor: const Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Cluster Capacity Alert Banner
              Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDF4EE),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFF5D6C6)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFCE4D6),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: const Icon(Icons.warning_amber_rounded, color: _primaryRust, size: 20),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Cluster Capacity Alert',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF7A3015),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFBA4B20),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: const Text(
                                      'New B2B Lead',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4.0),
                              const Text(
                                'New FabIndia Inquiry (400 pcs) exceeds your single capacity of 250 pcs. Team up with 2 cluster artisans to accept this order!',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: Color(0xFF5A463E),
                                  height: 1.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: widget.onCollaborateTap,
                        icon: const Icon(Icons.people_outline, size: 16),
                        label: const Text(
                          'Collaborate to Accept (Screen 22)',
                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryRust,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 11.0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Filter Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(_filters.length, (index) {
                    final isSelected = _selectedFilterIndex == index;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                        onTap: () => setState(() => _selectedFilterIndex = index),
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
                          decoration: BoxDecoration(
                            color: isSelected ? _primaryRust : Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: isSelected ? _primaryRust : const Color(0xFFE5D5CB),
                            ),
                          ),
                          child: Text(
                            _filters[index],
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: isSelected ? Colors.white : _textDark,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16.0),

              // Order Card 1: FabIndia Retail Ltd.
              _buildOrderCard1(),
              const SizedBox(height: 14.0),

              // Order Card 2: The Bombay Store
              _buildOrderCard2(),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ArtisanBottomNavigation(
        currentIndex: 2,
        onTap: (idx) => widget.onNavigateTab?.call(idx),
      ),
    );
  }

  PreferredSizeWidget _buildTopAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: _textDark),
        onPressed: () {},
      ),
      title: Row(
        children: [
          const Text(
            'HunarSangam',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w900,
              color: Color(0xFF8D3412),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(width: 6.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF3ECE6),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'Artisan',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Color(0xFF8D3412),
              ),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.hearing, color: Color(0xFF5D4037), size: 20),
          onPressed: () {},
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12.0),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: const Color(0xFFE5D5CB)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('English', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _textDark)),
              Icon(Icons.arrow_drop_down, size: 14, color: _textDark),
            ],
          ),
        ),
        const SizedBox(width: 10.0),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(20.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 6.0),
          child: Row(
            children: const [
              Icon(Icons.location_on_outlined, size: 13, color: Color(0xFF8D3412)),
              SizedBox(width: 3.0),
              Text(
                'Assam Cane & Bamboo',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF8D3412)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtext,
    required IconData icon,
    bool isGreenLock = false,
    bool showProgressBar = false,
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: const Color(0xFFEFE8E2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _textMuted),
              ),
              Icon(icon, size: 16, color: const Color(0xFFBA4B20)),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: valueColor ?? _textDark,
            ),
          ),
          if (showProgressBar) ...[
            const SizedBox(height: 6.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: const LinearProgressIndicator(
                value: 0.92,
                backgroundColor: Color(0xFFEFE8E2),
                valueColor: AlwaysStoppedAnimation<Color>(_primaryRust),
                minHeight: 5,
              ),
            ),
          ],
          const SizedBox(height: 4.0),
          Row(
            children: [
              if (isGreenLock) ...[
                const Icon(Icons.lock, size: 10, color: Color(0xFF2E7D32)),
                const SizedBox(width: 3.0),
              ],
              Expanded(
                child: Text(
                  subtext,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: isGreenLock ? FontWeight.w700 : FontWeight.w500,
                    color: isGreenLock ? const Color(0xFF2E7D32) : _textMuted,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard1() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFEFE8E2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Buyer info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.verified, size: 15, color: Color(0xFF2E7D32)),
                  SizedBox(width: 5.0),
                  Text(
                    'FabIndia Retail Ltd.',
                    style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: _textDark),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  'In Production',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF2E7D32)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2.0),
          const Text(
            'New Delhi • Verified Corporate Buyer',
            style: TextStyle(fontSize: 11, color: _textMuted),
          ),
          const SizedBox(height: 12.0),

          // PO line & amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('#PO-FAB-8821', style: TextStyle(fontSize: 10.5, color: _textMuted, fontWeight: FontWeight.w600)),
                  SizedBox(height: 2.0),
                  Text(
                    '120 × Woven Bamboo Fruit\nBasket',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: _textDark, height: 1.25),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text('₹33,600', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: _textDark)),
                  SizedBox(height: 2.0),
                  Text(
                    '40% Advance (₹13,440) in\nBank',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 10, color: Color(0xFF2E7D32), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // Production Status Box
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFDFBF9),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: const Color(0xFFEFE8E2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Production Status', style: TextStyle(fontSize: 11, color: _textMuted, fontWeight: FontWeight.w600)),
                    Text('75 / 120 pcs done (62%)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: _primaryRust)),
                  ],
                ),
                const SizedBox(height: 6.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: const LinearProgressIndicator(
                    value: 0.62,
                    backgroundColor: Color(0xFFEFE8E2),
                    valueColor: AlwaysStoppedAnimation<Color>(_primaryRust),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 6.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('⏱️ Next: QC & Packaging', style: TextStyle(fontSize: 10.5, color: _textMuted)),
                    Text('Due in 4 days (28 Mar)', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, color: Color(0xFFC2410C))),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),

          // Actions
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onOrderTap?.call('PO-FAB-8821', 'FabIndia Retail Ltd.', 120, 75);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryRust,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: const Text('Update Progress', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800)),
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Dispatch handover scheduled with logistics partner')),
                      );
                    },
                    icon: const Icon(Icons.local_shipping_outlined, size: 15, color: _textDark),
                    label: const Text('Dispatch Delivery', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: _textDark)),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE5D5CB)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard2() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFEFE8E2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.verified, size: 15, color: Color(0xFF2E7D32)),
                  SizedBox(width: 5.0),
                  Text(
                    'The Bombay Store',
                    style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w800, color: _textDark),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  'New order',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFFE65100)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2.0),
          const Text(
            'Mumbai • Retail Chain Buyer',
            style: TextStyle(fontSize: 11, color: _textMuted),
          ),
          const SizedBox(height: 12.0),

          // PO line & amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('#PO-TBS-4419', style: TextStyle(fontSize: 10.5, color: _textMuted, fontWeight: FontWeight.w600)),
                  SizedBox(height: 2.0),
                  Text(
                    '50 × Golden Cane Planter\nBasket',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: _textDark, height: 1.25),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text('₹21,000', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: _textDark)),
                  SizedBox(height: 2.0),
                  Text(
                    'Advance Escrow\nSecured',
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 10, color: Color(0xFF2E7D32), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12.0),

          // Material box
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFDFBF9),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: const Color(0xFFEFE8E2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('📦 Assam Cane #Grade-A Procured', style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: _textDark)),
                Text('Due: 05 April (16 days)', style: TextStyle(fontSize: 10.5, color: _textMuted)),
              ],
            ),
          ),
          const SizedBox(height: 12.0),

          // Actions
          Row(
            children: [
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Downloading purchase order & technical specs PDF')),
                  );
                },
                child: Row(
                  children: const [
                    Icon(Icons.description_outlined, size: 14, color: _primaryRust),
                    SizedBox(width: 4.0),
                    Text(
                      'View PO & Specs',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: _primaryRust),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 36,
                child: ElevatedButton(
                  onPressed: widget.onOrderRequestTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8D3412),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  ),
                  child: const Text('View Details', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800)),
                ),
              ),
              const SizedBox(width: 8.0),
              SizedBox(
                height: 36,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Order #PO-TBS-4419 accepted! Escrow advance released.')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryRust,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  ),
                  child: const Text('Accept order', style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
