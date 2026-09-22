// lib/screens/buyer_order_details_screen.dart
// Production-grade Flutter screen matching 'bulk order section 2 - deatiled.png'
// Order Details & Status with Live Batch Status, Milestone Journey, 3-Stage Trust Escrow, Quality Checklist & Updates Log

import 'package:flutter/material.dart';

class BuyerOrderDetailsScreen extends StatefulWidget {
  final String orderId;
  final VoidCallback? onBack;
  final VoidCallback? onMessageArtisan;
  final VoidCallback? onDownloadInvoice;
  final VoidCallback? onReleaseMilestone;
  final VoidCallback? onOpenHome;
  final VoidCallback? onOpenDiscover;
  final VoidCallback? onOpenRequirements;
  final VoidCallback? onOpenOrders;
  final VoidCallback? onOpenProfile;

  const BuyerOrderDetailsScreen({
    super.key,
    this.orderId = 'HS-BKT-892',
    this.onBack,
    this.onMessageArtisan,
    this.onDownloadInvoice,
    this.onReleaseMilestone,
    this.onOpenHome,
    this.onOpenDiscover,
    this.onOpenRequirements,
    this.onOpenOrders,
    this.onOpenProfile,
  });

  @override
  State<BuyerOrderDetailsScreen> createState() => _BuyerOrderDetailsScreenState();
}

class _BuyerOrderDetailsScreenState extends State<BuyerOrderDetailsScreen> {
  bool _milestone2Released = false;

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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Details & Status',
              style: TextStyle(
                color: primaryRust,
                fontWeight: FontWeight.w900,
                fontSize: 16,
              ),
            ),
            Text(
              'Order #${widget.orderId}',
              style: const TextStyle(
                color: textMuted,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.receipt_long_outlined, color: primaryRust),
            onPressed: widget.onDownloadInvoice ?? () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                // 1. Product Summary Card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFF0DFD3)),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x06000000),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=200&q=80',
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 4,
                                left: 4,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'GI Craft',
                                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: primaryRust),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '500 Handwoven Bamboo Bas...',
                                  style: TextStyle(
                                    color: textDark,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 14.5,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  '10–inch diameter, double-rim',
                                  style: TextStyle(color: textMuted, fontSize: 11),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: const [
                                    Icon(Icons.verified_outlined, size: 13, color: primaryRust),
                                    SizedBox(width: 3),
                                    Expanded(
                                      child: Text(
                                        'Ramesh Kumar (Master Craftsman)',
                                        style: TextStyle(
                                          color: primaryRust,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 11,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                const Text(
                                  '📅 Placed: 17 Sep 2026 • Req: 28 Oct',
                                  style: TextStyle(color: textMuted, fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(height: 1, color: Color(0xFFF3E7DC)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Bulk Value',
                                style: TextStyle(color: textMuted, fontSize: 10.5),
                              ),
                              RichText(
                                text: const TextSpan(
                                  text: '₹1,90,000 ',
                                  style: TextStyle(
                                    color: textDark,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '(₹380/pc)',
                                      style: TextStyle(
                                        color: textMuted,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD1FAE5),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFA7F3D0)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.shield_outlined, size: 13, color: Color(0xFF065F46)),
                                SizedBox(width: 4),
                                Text(
                                  'Escrow Protected',
                                  style: TextStyle(
                                    color: Color(0xFF065F46),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 2. Order Accepted & In Production Banner Card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7F2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFF7DEC9)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: primaryRust,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD1FAE5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.check_circle, size: 12, color: Color(0xFF065F46)),
                                    SizedBox(width: 3),
                                    Text(
                                      'Accepted & In Production',
                                      style: TextStyle(
                                        color: Color(0xFF065F46),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 10.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Updated today,\n4:30 PM',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: textMuted, fontSize: 10, height: 1.2),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Order Accepted & In Production',
                        style: TextStyle(
                          color: textDark,
                          fontWeight: FontWeight.w900,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'The craft maker accepted your order. Bamboo basket weaving is actively underway at the cluster workshop.',
                        style: TextStyle(
                          color: Color(0xFF5A483E),
                          fontSize: 11.5,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.camera_alt_outlined, size: 14),
                              label: const Text('Track Photos', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF1F1612),
                                side: const BorderSide(color: Color(0xFFDCC8BB)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: widget.onMessageArtisan ?? () {},
                              icon: const Icon(Icons.chat_bubble_outline, size: 14),
                              label: const Text('Message Craft Maker', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryRust,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 3. Live Batch Status & Craft Feed
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFF0DFD3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'LIVE BATCH STATUS',
                                style: TextStyle(
                                  color: primaryRust,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 10.5,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Production Progress\n(64%)',
                                style: TextStyle(
                                  color: textDark,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Text(
                                '320 / 500',
                                style: TextStyle(
                                  color: primaryRust,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'pcs',
                                style: TextStyle(color: textMuted, fontSize: 11),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: 0.64,
                          minHeight: 8,
                          backgroundColor: const Color(0xFFF0E5DC),
                          valueColor: const AlwaysStoppedAnimation<Color>(primaryRust),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Cluster Craft Feed',
                            style: TextStyle(
                              color: textDark,
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'View All (12) →',
                              style: TextStyle(
                                color: primaryRust,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: _buildFeedItem(
                              date: '18 Sep',
                              title: 'Raw Material Ready',
                              desc: 'Brahmaputra poles',
                              imageUrl: 'https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=300&q=80',
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildFeedItem(
                              date: '21 Sep',
                              title: 'Split & Seasoning',
                              desc: 'Pest smoke cure',
                              imageUrl: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?auto=format&fit=crop&w=300&q=80',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 4. Milestone Journey
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFF0DFD3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Milestone Journey',
                        style: TextStyle(
                          color: textDark,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 14),
                      _buildMilestoneItem(
                        isCompleted: true,
                        title: 'Requirement Created',
                        time: '17 Sep, 10:30 AM',
                        desc: 'Specifications and batch volume defined.',
                      ),
                      _buildMilestoneItem(
                        isCompleted: true,
                        title: 'Craft Maker Selected',
                        time: '17 Sep, 10:42 AM',
                        desc: 'Matched with Barpeta Cane Cluster.',
                      ),
                      _buildMilestoneItem(
                        isCompleted: true,
                        title: 'Order Request Sent',
                        time: '17 Sep, 10:45 AM',
                        desc: 'Lock applied with initial escrow hold.',
                      ),
                      _buildMilestoneItem(
                        isCompleted: true,
                        title: 'Craft Maker Confirmation',
                        time: '17 Sep, 2:15 PM',
                        desc: 'Confirmed 500 pcs @ ₹380 / unit tier.',
                      ),
                      _buildMilestoneActiveCard(
                        title: 'Production (Active)',
                        badge: '64% Done',
                        desc: '320/500 units handwoven and trimmed.',
                      ),
                      _buildMilestoneItem(
                        isUpcoming: true,
                        title: 'Quality Check',
                        time: 'Sched. 24 Oct',
                        desc: 'Structural durability & pest inspection.',
                      ),
                      _buildMilestoneItem(
                        isUpcoming: true,
                        isLast: true,
                        title: 'Dispatch & Completed',
                        time: 'Sched. 28 Oct',
                        desc: 'Direct transport from Barpeta Cluster.',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 5. 3-Stage Trust Escrow
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFF0DFD3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            '3-Stage Trust Escrow',
                            style: TextStyle(
                              color: textDark,
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                          Icon(Icons.shield_outlined, color: Color(0xFF065F46), size: 20),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Protected Vault: ₹1,90,000',
                        style: TextStyle(color: textMuted, fontSize: 11),
                      ),
                      const SizedBox(height: 12),

                      // Milestone 1 (Released)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4FAF6),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFD1E7DD)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  '✓ Milestone 1 (40%) • Released',
                                  style: TextStyle(color: Color(0xFF065F46), fontWeight: FontWeight.w800, fontSize: 11),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '₹76,000 — Raw Material Advance',
                                  style: TextStyle(color: textDark, fontWeight: FontWeight.w800, fontSize: 12),
                                ),
                              ],
                            ),
                            const Text(
                              '18 Sep',
                              style: TextStyle(color: textMuted, fontSize: 10.5, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Milestone 2 (Verification Met / Active)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF9F5),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFF3DEC8), width: 1.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  '📋 Milestone 2 (40%) • Verification Met',
                                  style: TextStyle(color: primaryRust, fontWeight: FontWeight.w800, fontSize: 11),
                                ),
                                Text(
                                  '₹76,000',
                                  style: TextStyle(color: textDark, fontWeight: FontWeight.w900, fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              '320/500 units reached. Ready for buyer confirmation release.',
                              style: TextStyle(color: Color(0xFF5A483E), fontSize: 11),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() => _milestone2Released = !_milestone2Released);
                                  widget.onReleaseMilestone?.call();
                                },
                                icon: Icon(_milestone2Released ? Icons.check : Icons.lock_open, size: 14),
                                label: Text(
                                  _milestone2Released ? 'Milestone 2 Released' : '🔒 Approve & Release ₹76,000',
                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _milestone2Released ? const Color(0xFF065F46) : primaryRust,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Milestone 3 (In Vault)
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F6F3),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFEADBCE)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  '🔒 Milestone 3 (20%) • In Vault',
                                  style: TextStyle(color: textMuted, fontWeight: FontWeight.w800, fontSize: 11),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '₹38,000 — Final QC & Dispatch',
                                  style: TextStyle(color: textDark, fontWeight: FontWeight.w800, fontSize: 12),
                                ),
                              ],
                            ),
                            const Text(
                              'Held',
                              style: TextStyle(color: textMuted, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Center(
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'View Full Escrow Audit Trail →',
                            style: TextStyle(
                              color: primaryRust,
                              fontWeight: FontWeight.bold,
                              fontSize: 11.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 6. Cluster Quality Assurance
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFF0DFD3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Cluster Quality\nAssurance',
                            style: TextStyle(
                              color: textDark,
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              height: 1.2,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5EBE1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'Pre–QC\nReview',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: primaryRust, fontSize: 9.5, fontWeight: FontWeight.bold, height: 1.1),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildChecklistRow(true, 'Smoke cure pest-free certified by cluster lead'),
                      const SizedBox(height: 8),
                      _buildChecklistRow(true, 'Double-rim structural tension check (320 units)'),
                      const SizedBox(height: 8),
                      _buildChecklistRow(false, 'Final dimensional caliper check (10–inch diameter)'),
                      const SizedBox(height: 12),
                      const Divider(height: 1, color: Color(0xFFF3E7DC)),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Review Quality Guidelines', style: TextStyle(color: primaryRust, fontWeight: FontWeight.bold, fontSize: 11)),
                          Text('GI Assured #AS-4921', style: TextStyle(color: textMuted, fontWeight: FontWeight.w600, fontSize: 10.5)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 7. Artisan Contact Card
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFF0DFD3)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(
                              'https://images.unsplash.com/photo-1544717305-2782549b5136?auto=format&fit=crop&w=120&q=80',
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Ramesh Kumar',
                                  style: TextStyle(color: textDark, fontWeight: FontWeight.w900, fontSize: 14.5),
                                ),
                                SizedBox(height: 1),
                                Text(
                                  'Master Craftsman • 24 yrs exp',
                                  style: TextStyle(color: primaryRust, fontWeight: FontWeight.bold, fontSize: 11),
                                ),
                                Text(
                                  'Barpeta Cane & Bamboo Co-op (32 Weavers)',
                                  style: TextStyle(color: textMuted, fontSize: 10),
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
                              onPressed: () {},
                              icon: const Icon(Icons.person_outline, size: 14),
                              label: const Text('View Profile', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF1F1612),
                                side: const BorderSide(color: Color(0xFFDCC8BB)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: widget.onMessageArtisan ?? () {},
                              icon: const Icon(Icons.chat_bubble_outline, size: 14),
                              label: const Text('Message', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF1F1612),
                                side: const BorderSide(color: Color(0xFFDCC8BB)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),

                // 8. Order Updates Log
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFF0DFD3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order Updates Log',
                        style: TextStyle(
                          color: textDark,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildLogRow('17 Sep, 4:30 PM', 'Production started at Barpeta cluster loom after material seasoning check.'),
                      _buildLogRow('17 Sep, 2:15 PM', 'Craft Maker Ramesh Kumar accepted the bulk order agreement.'),
                      _buildLogRow('17 Sep, 11:20 AM', 'Cluster craft maker confirmed bamboo stock readiness and dimension specs.'),
                      _buildLogRow('17 Sep, 10:45 AM', 'Bulk order created with ₹76,000 Milestone 1 locked in escrow vault.'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Bottom Action Buttons (Download Invoice & Message Artisan)
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: widget.onDownloadInvoice ?? () {},
                        icon: const Icon(Icons.download_outlined, size: 15),
                        label: const Text('Download Invoice', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF1F1612),
                          side: const BorderSide(color: Color(0xFFDCC8BB)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: widget.onMessageArtisan ?? () {},
                        icon: const Icon(Icons.chat_bubble_outline, size: 15),
                        label: const Text('Message Craft Maker', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryRust,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
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

  Widget _buildFeedItem({
    required String date,
    required String title,
    required String desc,
    required String imageUrl,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFAF2EB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEFE0D5)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(imageUrl, height: 75, width: double.infinity, fit: BoxFit.cover),
              Positioned(
                top: 4,
                left: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(date, style: const TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10.5, color: Color(0xFF1F1612))),
                Text(desc, style: const TextStyle(fontSize: 9.5, color: Color(0xFF7A6A60))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneItem({
    bool isCompleted = false,
    bool isUpcoming = false,
    bool isLast = false,
    required String title,
    required String time,
    required String desc,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: isCompleted ? const Color(0xFF065F46) : const Color(0xFFFAF2EB),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCompleted ? const Color(0xFF065F46) : const Color(0xFFDCC8BB),
                  ),
                ),
                child: isCompleted
                    ? const Icon(Icons.check, size: 11, color: Colors.white)
                    : (isUpcoming ? const Center(child: Text('•', style: TextStyle(fontSize: 12, color: Color(0xFF7A6A60)))) : null),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: const Color(0xFFE5D5C8),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 11.5, color: Color(0xFF1F1612))),
                      Text(time, style: const TextStyle(fontSize: 10, color: Color(0xFF7A6A60), fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(desc, style: const TextStyle(fontSize: 10.5, color: Color(0xFF6B5A4E))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneActiveCard({
    required String title,
    required String badge,
    required String desc,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: Color(0xFF9C3C18),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text('•', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: const Color(0xFFE5D5C8),
                  margin: const EdgeInsets.symmetric(vertical: 2),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7F2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFF7DEC9)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11.5, color: Color(0xFF9C3C18))),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFCE9DB),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(badge, style: const TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: Color(0xFF9C3C18))),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(desc, style: const TextStyle(fontSize: 10.5, color: Color(0xFF5A483E))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChecklistRow(bool isChecked, String label) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isChecked ? Icons.check_circle_outline : Icons.radio_button_unchecked,
          size: 15,
          color: isChecked ? const Color(0xFF065F46) : const Color(0xFF7A6A60),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isChecked ? const Color(0xFF1F1612) : const Color(0xFF7A6A60),
              fontWeight: isChecked ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogRow(String time, String message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(time, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Color(0xFF7A6A60))),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(message, style: const TextStyle(fontSize: 10.5, color: Color(0xFF3B2A22), height: 1.3)),
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
          _buildNavItem(Icons.local_shipping, 'Order', true, widget.onOpenOrders),
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
