// lib/screens/artisan_home_screen.dart

import 'package:flutter/material.dart';
import '../models/onboarding_state.dart';
import '../models/notification_model.dart';
import '../models/product_model.dart';
import '../services/notification_service.dart';
import '../services/auth_service.dart';
import '../services/product_service.dart';
import '../services/order_service.dart';
import '../services/production_service.dart';
import '../services/collaboration_service.dart';
import '../add_product/add_product_flow.dart';
import '../widgets/brand_logo_card.dart';
import 'artisan_orders_screen.dart';
import 'collaboration_hub_screen.dart';
import 'digital_visiting_card_screen.dart';
import 'order_details_screen.dart';
import 'order_request_screen.dart';
import 'artisan_collective_screen.dart';
import 'suggested_collaborators_screen.dart';
import 'artisan_buyer_chat_screen.dart';
import 'artisan_chat_screen.dart';
import 'conversations_list_screen.dart';
import '../services/chat_service.dart';

/// Primary Artisan Home Dashboard matching 'Artisan Home section.png'
/// Provides real-time order tracking, AI voice assistant, product management,
/// artisan reliability scores, B2B opportunities, and 5-tab navigation.
class ArtisanHomeScreen extends StatefulWidget {
  final OnboardingState? state;
  final VoidCallback? onLogout;

  const ArtisanHomeScreen({
    super.key,
    this.state,
    this.onLogout,
  });

  @override
  State<ArtisanHomeScreen> createState() => _ArtisanHomeScreenState();
}

class _ArtisanHomeScreenState extends State<ArtisanHomeScreen> {
  int _currentNavIndex = 0;
  int _productsFlowInitialStep = 0;
  int _bambooBasketProgress = 30;
  final int _bambooBasketTotal = 50;
  String _selectedLanguage = 'English';
  Widget? _activeSubScreen;

  @override
  void initState() {
    super.initState();
    if (widget.state?.selectedLanguage.isNotEmpty ?? false) {
      _selectedLanguage = widget.state!.selectedLanguage.split(' ').first;
    }
  }

  void _showUpdateProgressDialog() {
    int tempProgress = _bambooBasketProgress;
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFFFFFDFB),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: const Text(
            'Update Craft Progress',
            style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF2D2421), fontSize: 18.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Completed: $tempProgress / $_bambooBasketTotal units',
                style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFFA84318)),
              ),
              const SizedBox(height: 12.0),
              Slider(
                value: tempProgress.toDouble(),
                min: 0,
                max: _bambooBasketTotal.toDouble(),
                divisions: _bambooBasketTotal,
                activeColor: const Color(0xFFA84318),
                inactiveColor: const Color(0xFFEADFD6),
                onChanged: (val) {
                  setDialogState(() {
                    tempProgress = val.toInt();
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Color(0xFF7A685F))),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA84318),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
              ),
              onPressed: () {
                setState(() {
                  _bambooBasketProgress = tempProgress;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Order progress updated to $_bambooBasketProgress/$_bambooBasketTotal!'),
                    backgroundColor: const Color(0xFF2E7D32),
                  ),
                );
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationsSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => FutureBuilder<List<NotificationModel>>(
        future: NotificationService().getNotifications(),
        builder: (context, snapshot) {
          final notifs = snapshot.data ?? [];
          return Container(
            height: MediaQuery.of(context).size.height * 0.65,
            decoration: const BoxDecoration(
              color: Color(0xFFFFFDFB),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5D5CB),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Notifications & Alerts',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF2D2421),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        NotificationService().markAllAsRead();
                        Navigator.pop(context);
                      },
                      child: const Text('Mark all read', style: TextStyle(color: Color(0xFFA84318), fontSize: 13.0)),
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Expanded(
                  child: ListView.separated(
                    itemCount: notifs.length,
                    separatorBuilder: (_, __) => const Divider(height: 16.0, color: Color(0xFFF3E7DF)),
                    itemBuilder: (context, i) {
                      final item = notifs[i];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: item.type == 'order'
                              ? const Color(0xFFFFF2EC)
                              : item.type == 'payment'
                                  ? const Color(0xFFE8F5E9)
                                  : const Color(0xFFEDE7F6),
                          child: Icon(
                            item.type == 'order'
                                ? Icons.shopping_bag_outlined
                                : item.type == 'payment'
                                    ? Icons.account_balance_wallet_outlined
                                    : Icons.info_outline_rounded,
                            color: item.type == 'order'
                                ? const Color(0xFFA84318)
                                : item.type == 'payment'
                                    ? const Color(0xFF2E7D32)
                                    : const Color(0xFF512DA8),
                            size: 20.0,
                          ),
                        ),
                        title: Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: item.isRead ? FontWeight.w600 : FontWeight.w800,
                            color: const Color(0xFF2D2421),
                          ),
                        ),
                        subtitle: Text(
                          item.message,
                          style: const TextStyle(fontSize: 12.5, color: Color(0xFF7A685F)),
                        ),
                        trailing: !item.isRead
                            ? Container(
                                width: 8.0,
                                height: 8.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFC53030),
                                  shape: BoxShape.circle,
                                ),
                              )
                            : null,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showVoiceAssistantModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: const BoxDecoration(
          color: Color(0xFFFFFDFB),
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.0)),
        ),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              width: 44.0,
              height: 4.5,
              decoration: BoxDecoration(
                color: const Color(0xFFE5D5CB),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFFFAF0E8),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE8D4C5), width: 2.0),
              ),
              child: const Icon(Icons.mic_rounded, size: 36, color: Color(0xFF8C3A16)),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Hunar Voice Assistant',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2D2421),
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Speak in your native language (Hindi, Assamese, Bengali, Tamil...) to create catalog, check orders or find collaborators.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.0, color: Color(0xFF7A685F), height: 1.4),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('🎙️ Listening... Speak now'),
                      backgroundColor: Color(0xFF8C3A16),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.mic, color: Colors.white),
                label: const Text(
                  'Tap to Speak Now',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8C3A16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_activeSubScreen != null) {
      return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            setState(() => _activeSubScreen = null);
          }
        },
        child: _activeSubScreen!,
      );
    }

    if (_currentNavIndex == 1) {
      return AddProductFlow(
        initialStep: _productsFlowInitialStep,
        currentLanguage: _selectedLanguage,
        onNavigateTab: (index) {
          setState(() {
            _currentNavIndex = index;
            _productsFlowInitialStep = 0;
          });
        },
        onFlowComplete: () {
          setState(() {
            _currentNavIndex = 0;
            _productsFlowInitialStep = 0;
          });
        },
      );
    }

    if (_currentNavIndex == 2) {
      return ArtisanOrdersScreen(
        artisanName: widget.state?.artisanName.isNotEmpty ?? false ? widget.state!.artisanName : 'Ramu Kumar',
        onNavigateTab: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
        onOrderTap: (orderId, buyerName, totalQty, completed) {
          setState(() {
            _activeSubScreen = OrderDetailsScreen(
              orderId: orderId,
              buyerName: buyerName,
              totalQuantity: totalQty,
              initialCompleted: completed,
              onBack: () => setState(() => _activeSubScreen = null),
              onChatWithBuyer: () => setState(() {
                _activeSubScreen = ArtisanBuyerChatScreen(
                  conversationId: 'conv_$orderId',
                  buyerName: buyerName,
                  orderId: orderId,
                  orderTitle: 'Handcrafted Bamboo Fruit Baskets ($totalQty pcs)',
                  onBack: () => setState(() => _activeSubScreen = null),
                );
              }),
              onNavigateTab: (idx) => setState(() {
                _activeSubScreen = null;
                _currentNavIndex = idx;
              }),
              onFindArtisan: () => setState(() {
                _activeSubScreen = CollaborationHubScreen(
                  state: widget.state,
                  onBack: () => setState(() => _activeSubScreen = null),
                  onNavigateTab: (idx) => setState(() {
                    _activeSubScreen = null;
                    _currentNavIndex = idx;
                  }),
                  onOpenFormCollective: () => setState(() {
                    _activeSubScreen = ArtisanCollectiveScreen(
                      onBack: () => setState(() => _activeSubScreen = null),
                      onNavigateTab: (idx) => setState(() {
                        _activeSubScreen = null;
                        _currentNavIndex = idx;
                      }),
                    );
                  }),
                  onOpenSuggestedArtisans: () => setState(() {
                    _activeSubScreen = SuggestedCollaboratorsScreen(
                      onBack: () => setState(() => _activeSubScreen = null),
                      onNavigateTab: (idx) => setState(() {
                        _activeSubScreen = null;
                        _currentNavIndex = idx;
                      }),
                    );
                  }),
                );
              }),
            );
          });
        },
        onOrderRequestTap: () {
          setState(() {
            _activeSubScreen = OrderRequestScreen(
              buyerName: 'Heritage Handcrafts Pvt. Ltd.',
              productName: 'Bamboo Handwoven Basket',
              totalQuantity: 50,
              unitPrice: 450,
              myCapacity: 30,
              onBack: () => setState(() => _activeSubScreen = null),
              onChatWithBuyer: () => setState(() {
                _activeSubScreen = ArtisanBuyerChatScreen(
                  conversationId: 'conv_heritage_handcrafts',
                  buyerName: 'Heritage Handcrafts Pvt. Ltd.',
                  orderId: 'REQ_50_BAMBOO',
                  orderTitle: 'Bamboo Handwoven Basket (50 pcs)',
                  onBack: () => setState(() => _activeSubScreen = null),
                );
              }),
              onNavigateTab: (idx) => setState(() {
                _activeSubScreen = null;
                _currentNavIndex = idx;
              }),
              onAccept: () {
                setState(() => _activeSubScreen = null);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Order Accepted! Secured in Escrow.'),
                    backgroundColor: Color(0xFF2E7D32),
                  ),
                );
              },
            );
          });
        },
        onCollaborateTap: () {
          setState(() {
            _currentNavIndex = 3;
          });
        },
        onChatWithBuyer: (buyerName, orderTitle) {
          setState(() {
            _activeSubScreen = ArtisanBuyerChatScreen(
              conversationId: 'conv_${buyerName.replaceAll(" ", "_").toLowerCase()}',
              buyerName: buyerName,
              orderTitle: orderTitle,
              onBack: () => setState(() => _activeSubScreen = null),
            );
          });
        },
      );
    }

    if (_currentNavIndex == 3) {
      return CollaborationHubScreen(
        state: widget.state,
        onBack: () => setState(() => _currentNavIndex = 0),
        onNavigateTab: (index) => setState(() => _currentNavIndex = index),
        onOpenFormCollective: () => setState(() {
          _activeSubScreen = ArtisanCollectiveScreen(
            onBack: () => setState(() => _activeSubScreen = null),
            onNavigateTab: (idx) => setState(() {
              _activeSubScreen = null;
              _currentNavIndex = idx;
            }),
          );
        }),
        onOpenSuggestedArtisans: () => setState(() {
          _activeSubScreen = SuggestedCollaboratorsScreen(
            onBack: () => setState(() => _activeSubScreen = null),
            onNavigateTab: (idx) => setState(() {
              _activeSubScreen = null;
              _currentNavIndex = idx;
            }),
          );
        }),
        onChatWithArtisan: (artisanName, orderTitle) => setState(() {
          _activeSubScreen = ArtisanChatScreen(
            state: widget.state,
            onBack: () => setState(() => _activeSubScreen = null),
          );
        }),
        onChatWithBuyer: (buyerName, title) => setState(() {
          _activeSubScreen = ArtisanBuyerChatScreen(
            conversationId: 'conv_${buyerName.replaceAll(" ", "_").toLowerCase()}',
            buyerName: buyerName,
            orderTitle: title,
            onBack: () => setState(() => _activeSubScreen = null),
          );
        }),
      );
    }

    if (_currentNavIndex == 4) {
      return DigitalVisitingCardScreen(
        onBack: () => setState(() => _currentNavIndex = 0),
        onBottomNavTapped: (index) => setState(() => _currentNavIndex = index),
      );
    }

    final String artisanName = widget.state?.artisanName.isNotEmpty ?? false
        ? widget.state!.artisanName
        : 'Ramu';

    return Scaffold(
      backgroundColor: const Color(0xFFFDFBF9),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Top Header Bar
                _buildTopAppBar(),

                // Scrollable Dashboard Body
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Good morning greeting
                        _buildGreetingHeader(artisanName),

                        const SizedBox(height: 14.0),

                        // Voice Search / Command Bar
                        _buildVoiceSearchBar(),

                        const SizedBox(height: 16.0),

                        // 3 Key Metrics Cards
                        _buildMetricsCardsRow(),

                        const SizedBox(height: 18.0),

                        // Needs Attention Active Order Card
                        _buildActiveOrderCard(),

                        const SizedBox(height: 22.0),

                        // My Products Section
                        _buildMyProductsSection(),

                        const SizedBox(height: 20.0),

                        // Artisan Score & Reliability Card
                        _buildArtisanScoreCard(),

                        const SizedBox(height: 22.0),

                        // Opportunities for you Section
                        _buildOpportunitiesSection(),

                        const SizedBox(height: 80.0), // Padding for floating mic & nav bar
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Floating Mic Button at bottom right
            Positioned(
              right: 18.0,
              bottom: 74.0,
              child: FloatingActionButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('🎙️ Listening to your craft command or query...'),
                      backgroundColor: Color(0xFF8C3A16),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                backgroundColor: const Color(0xFF8C3A16),
                foregroundColor: Colors.white,
                elevation: 4,
                child: const Icon(Icons.mic_rounded, size: 28.0),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // 1. Top App Bar
  Widget _buildTopAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo + HunarSangam
          const HunarSangamLogoBadge(
            size: 34.0,
            showText: true,
          ),

          // Right Icons: Language, Notification Bell, Avatar
          Row(
            children: [
              // Quick-Switch Language Toggle (EN | हिं)
              Container(
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3E7DF),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: const Color(0xFFE5D5CB)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedLanguage = 'English';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('🌐 Switched language to English'),
                            duration: Duration(seconds: 1),
                            backgroundColor: Color(0xFF8C3A16),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          color: _selectedLanguage != 'हिंदी' && _selectedLanguage != 'Hindi'
                              ? const Color(0xFF8C3A16)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Text(
                          'EN',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w800,
                            color: _selectedLanguage != 'हिंदी' && _selectedLanguage != 'Hindi'
                                ? Colors.white
                                : const Color(0xFF6B584E),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedLanguage = 'हिंदी';
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('🌐 भाषा बदलकर हिंदी कर दी गई'),
                            duration: Duration(seconds: 1),
                            backgroundColor: Color(0xFF8C3A16),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                        decoration: BoxDecoration(
                          color: _selectedLanguage == 'हिंदी' || _selectedLanguage == 'Hindi'
                              ? const Color(0xFF8C3A16)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Text(
                          'हिं',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w800,
                            color: _selectedLanguage == 'हिंदी' || _selectedLanguage == 'Hindi'
                                ? Colors.white
                                : const Color(0xFF6B584E),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),

              // Notification bell with red dot
              InkWell(
                onTap: _showNotificationsSheet,
                borderRadius: BorderRadius.circular(20.0),
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAF2EC),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFE5D5CB)),
                      ),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        size: 20.0,
                        color: Color(0xFF4A372D),
                      ),
                    ),
                    Positioned(
                      top: 5.0,
                      right: 6.0,
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFFC53030),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8.0),

              // Chat Hub / Conversations with Unread Indicator
              InkWell(
                onTap: () {
                  setState(() {
                    _activeSubScreen = ConversationsListScreen(
                      userRole: 'artisan',
                      currentUserName: widget.state?.artisanName ?? 'Ramu Kumar',
                      onBack: () => setState(() => _activeSubScreen = null),
                      onOpenConversation: (conv) {
                        setState(() {
                          _activeSubScreen = ArtisanBuyerChatScreen(
                            conversationId: conv.id,
                            buyerName: conv.buyerName,
                            orderId: conv.orderNumber,
                            orderTitle: conv.orderTitle,
                            escrowAmount: conv.escrowAmount,
                            deliveryDate: conv.deliveryDate,
                            onBack: () => setState(() => _activeSubScreen = null),
                            onEscrowTap: () {
                              setState(() {
                                _activeSubScreen = OrderDetailsScreen(
                                  orderId: conv.orderNumber,
                                  onBack: () => setState(() => _activeSubScreen = null),
                                );
                              });
                            },
                          );
                        });
                      },
                    );
                  });
                },
                borderRadius: BorderRadius.circular(20.0),
                child: StreamBuilder<int>(
                  stream: ChatService().unreadCountStream,
                  builder: (context, snap) {
                    final unread = snap.data ?? 0;
                    return Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(7.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAF2EC),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFE5D5CB)),
                          ),
                          child: const Icon(
                            Icons.chat_bubble_outline_rounded,
                            size: 19.0,
                            color: Color(0xFF8C3A16),
                          ),
                        ),
                        if (unread > 0)
                          Positioned(
                            top: 4.0,
                            right: 4.0,
                            child: Container(
                              padding: const EdgeInsets.all(2.5),
                              decoration: const BoxDecoration(
                                color: Color(0xFF8C3A16),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '$unread',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(width: 8.0),

              // User Avatar with green dot
              GestureDetector(
                onTap: () => setState(() => _currentNavIndex = 4),
                child: Stack(
                  children: [
                    Container(
                      width: 36.0,
                      height: 36.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFEADFD6),
                        border: Border.all(color: const Color(0xFFD5C4B8), width: 1.5),
                      ),
                      child: const Center(
                        child: Icon(Icons.person, color: Color(0xFF7C3F24), size: 22.0),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2E7D32),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 2. Greeting Header
  Widget _buildGreetingHeader(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Good morning, $name',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFF221C19),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(width: 6.0),
            const Text('👋', style: TextStyle(fontSize: 22.0)),
          ],
        ),
        const SizedBox(height: 2.0),
        const Text(
          'Ready to create something beautiful today?',
          style: TextStyle(
            fontSize: 14.0,
            color: Color(0xFF6B584E),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // 3. AI Voice Search Bar
  Widget _buildVoiceSearchBar() {
    return GestureDetector(
      onTap: _showVoiceAssistantModal,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFFFFBF8),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: const Color(0xFFEADFD6)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF7C3F24).withValues(alpha: 0.04),
              offset: const Offset(0, 3),
              blurRadius: 8.0,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        child: Row(
          children: [
            const Icon(Icons.graphic_eq_rounded, color: Color(0xFFA84318), size: 22.0),
            const SizedBox(width: 10.0),
            const Expanded(
              child: Text(
                'Tap to speak or ask Hunar Assistant...',
                style: TextStyle(
                  fontSize: 13.5,
                  color: Color(0xFF7A685F),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                color: Color(0xFF8C3A16),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.mic_rounded, color: Colors.white, size: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  // 4. Metrics Cards Row
  Widget _buildMetricsCardsRow() {
    return StreamBuilder<List<dynamic>>(
      stream: OrderService().ordersStream,
      builder: (context, snapshot) {
        final orders = snapshot.data ?? [];
        final inProgress = orders.where((o) => o.status == 'in_progress' || o.status == 'production').length;
        final completed = orders.where((o) => o.status == 'delivered' || o.status == 'completed').length;
        final pending = orders.where((o) => o.status == 'escrow_locked' || o.status == 'pending').length;

        return Row(
          children: [
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(16.0),
                onTap: () {
                  setState(() {
                    _activeSubScreen = OrderRequestScreen(
                      onBack: () => setState(() => _activeSubScreen = null),
                      onNavigateTab: (idx) => setState(() {
                        _activeSubScreen = null;
                        _currentNavIndex = idx;
                      }),
                      onAccept: () {
                        setState(() => _activeSubScreen = null);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('✅ Order Accepted! Secured in Escrow.'),
                            backgroundColor: Color(0xFF2E7D32),
                          ),
                        );
                      },
                    );
                  });
                },
                child: _buildMetricCard(
                  title: 'New\nOrders',
                  count: pending > 0 ? '$pending' : '2',
                  hasBadgeDot: true,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(16.0),
                onTap: () => setState(() => _currentNavIndex = 2),
                child: _buildMetricCard(
                  title: 'In Progress',
                  count: inProgress > 0 ? '$inProgress' : '1',
                  hasBadgeDot: false,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(16.0),
                onTap: () => setState(() => _currentNavIndex = 2),
                child: _buildMetricCard(
                  title: 'Completed',
                  count: completed > 0 ? '$completed' : '28',
                  hasBadgeDot: false,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String count,
    required bool hasBadgeDot,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF4EE),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A372D),
                  height: 1.2,
                ),
              ),
              if (hasBadgeDot)
                Container(
                  width: 6.5,
                  height: 6.5,
                  decoration: const BoxDecoration(
                    color: Color(0xFFC53030),
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            count,
            style: const TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.w800,
              color: Color(0xFF221C19),
            ),
          ),
        ],
      ),
    );
  }

  // 5. Active Needs Attention Order Card
  Widget _buildActiveOrderCard() {
    final double percentage = _bambooBasketProgress / _bambooBasketTotal;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDFB),
        borderRadius: BorderRadius.circular(22.0),
        border: Border.all(color: const Color(0xFFEADFD6), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3F24).withValues(alpha: 0.05),
            offset: const Offset(0, 4),
            blurRadius: 12.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tag pills row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDECE8),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(color: const Color(0xFFF5C6BC)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.warning_amber_rounded, size: 14.0, color: Color(0xFFC53030)),
                    SizedBox(width: 4.0),
                    Text(
                      'Needs Attention • Due in 6 days',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFC53030),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'B2B Bulk',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF6B584E),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12.0),

          // Title & Buyer
          const Text(
            '50 Handmade Bamboo Baskets',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              color: Color(0xFF221C19),
            ),
          ),
          const SizedBox(height: 4.0),
          Row(
            children: const [
              Icon(Icons.business_outlined, size: 15.0, color: Color(0xFF6B584E)),
              SizedBox(width: 5.0),
              Text(
                'FabIndia Sourcing Hub (Bulk Buyer)',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B584E),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14.0),

          // Progress Container
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFFBF4EE),
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Craft Production Progress',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A372D),
                      ),
                    ),
                    Text(
                      '$_bambooBasketProgress / $_bambooBasketTotal completed (${(percentage * 100).toInt()}%)',
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFA84318),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: LinearProgressIndicator(
                    value: percentage,
                    minHeight: 8.0,
                    backgroundColor: const Color(0xFFE5D5CB),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8C3A16)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14.0),

          // Action buttons: Update Progress & View Order
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _showUpdateProgressDialog,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    side: const BorderSide(color: const Color(0xFFE5D5CB)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.refresh_rounded, size: 16.0, color: Color(0xFF4A372D)),
                      SizedBox(width: 6.0),
                      Text(
                        'Update Progress',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF4A372D),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _activeSubScreen = OrderDetailsScreen(
                        orderId: 'HS1048',
                        buyerName: 'FabIndia Sourcing Hub',
                        totalQuantity: _bambooBasketTotal,
                        initialCompleted: _bambooBasketProgress,
                        onBack: () => setState(() => _activeSubScreen = null),
                        onChatWithBuyer: () {
                          setState(() {
                            _activeSubScreen = ArtisanBuyerChatScreen(
                              conversationId: 'conv-heritage-ramu-1048',
                              buyerName: 'FabIndia Sourcing Hub',
                              orderId: 'HS1048',
                              orderTitle: '50 pcs Bamboo Baskets',
                              escrowAmount: '₹22,500',
                              deliveryDate: '28 Oct 2026',
                              onBack: () => setState(() => _activeSubScreen = null),
                            );
                          });
                        },
                        onNavigateTab: (idx) => setState(() {
                          _activeSubScreen = null;
                          _currentNavIndex = idx;
                        }),
                        onFindArtisan: () => setState(() {
                          _activeSubScreen = CollaborationHubScreen(
                            state: widget.state,
                            onBack: () => setState(() => _activeSubScreen = null),
                            onNavigateTab: (idx) => setState(() {
                              _activeSubScreen = null;
                              _currentNavIndex = idx;
                            }),
                          );
                        }),
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8C3A16),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'View Order',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 4.0),
                      Icon(Icons.arrow_forward_rounded, size: 16.0),
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

  // 6. My Products Section
  Widget _buildMyProductsSection() {
    return StreamBuilder<List<ProductModel>>(
      stream: ProductService().productsStream,
      builder: (context, snapshot) {
        final products = snapshot.data ?? [];
        final count = products.length;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'My Products',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF221C19),
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      '($count)',
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7A685F),
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _productsFlowInitialStep = 1;
                      _currentNavIndex = 1;
                    });
                  },
                  icon: const Icon(Icons.add, size: 16.0, color: Color(0xFFA84318)),
                  label: const Text(
                    'Add Product',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFA84318),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8.0),

            if (products.isEmpty)
              Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFDFB),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFEADFD6)),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const Icon(Icons.inventory_2_outlined, size: 36.0, color: Color(0xFFB85324)),
                      const SizedBox(height: 8.0),
                      const Text(
                        'No products listed yet',
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0, color: Color(0xFF2D2421)),
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        'Tap "Add Product" above or use the AI Voice Assistant to list your first craft.',
                        style: TextStyle(fontSize: 12.0, color: Color(0xFF7A685F)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  childAspectRatio: 0.76,
                ),
                itemBuilder: (context, index) {
                  final p = products[index];
                  return InkWell(
                    onTap: () => _showProductOptionsModal(p),
                    borderRadius: BorderRadius.circular(18.0),
                    child: _buildProductCard(
                      title: p.name,
                      price: '₹${p.price.toInt()}',
                      orders: '${p.stock} In Stock',
                      moq: '10',
                      imageUrl: p.primaryImageUrl,
                      iconData: _getProductIcon(p.craftType),
                    ),
                  );
                },
              ),
          ],
        );
      },
    );
  }

  IconData _getProductIcon(String craftType) {
    if (craftType.toLowerCase().contains('bamboo') || craftType.toLowerCase().contains('basket')) {
      return Icons.shopping_basket_outlined;
    } else if (craftType.toLowerCase().contains('pottery') || craftType.toLowerCase().contains('ceramic')) {
      return Icons.soup_kitchen_outlined;
    } else if (craftType.toLowerCase().contains('saree') || craftType.toLowerCase().contains('weave') || craftType.toLowerCase().contains('textile')) {
      return Icons.dry_cleaning_outlined;
    }
    return Icons.yard_outlined;
  }

  void _showProductOptionsModal(ProductModel product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFFDFB),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5D5CB),
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFFDECE8),
                  child: Icon(_getProductIcon(product.craftType), color: const Color(0xFFA84318)),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16.0, color: Color(0xFF2D2421)),
                      ),
                      Text(
                        '₹${product.price.toInt()} • Stock: ${product.stock} units',
                        style: const TextStyle(fontSize: 12.5, color: Color(0xFF7A685F)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18.0),
            ListTile(
              leading: const Icon(Icons.edit_outlined, color: Color(0xFF4A372D)),
              title: const Text('Update Price & Stock', style: TextStyle(fontWeight: FontWeight.w700)),
              onTap: () {
                Navigator.pop(context);
                _showEditProductPriceDialog(product);
              },
            ),
            ListTile(
              leading: const Icon(Icons.sync_alt_rounded, color: Color(0xFF2E7D32)),
              title: const Text('Sync with ONDC National Network', style: TextStyle(fontWeight: FontWeight.w700)),
              trailing: const Text('Active', style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.w800, fontSize: 12.0)),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('⚡ Product catalog synchronized with ONDC Network.'),
                    backgroundColor: Color(0xFF2E7D32),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline_rounded, color: Color(0xFFC62828)),
              title: const Text('Remove Product', style: TextStyle(color: Color(0xFFC62828), fontWeight: FontWeight.w700)),
              onTap: () async {
                final messenger = ScaffoldMessenger.of(context);
                Navigator.pop(context);
                await ProductService().deleteProduct(product.id);
                messenger.showSnackBar(
                  SnackBar(
                    content: Text('🗑️ Removed "${product.name}" from catalog.'),
                    backgroundColor: const Color(0xFF2D2421),
                  ),
                );
              },
            ),
            const SizedBox(height: 12.0),
          ],
        ),
      ),
    );
  }

  void _showEditProductPriceDialog(ProductModel product) {
    final priceCtrl = TextEditingController(text: product.price.toInt().toString());
    final stockCtrl = TextEditingController(text: product.stock.toString());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFFFFDFB),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text('Edit ${product.name}', style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17.0)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: priceCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price per piece (₹)', prefixText: '₹ '),
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: stockCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Available Inventory Count'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFA84318),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final newPrice = double.tryParse(priceCtrl.text) ?? product.price;
              final newStock = int.tryParse(stockCtrl.text) ?? product.stock;
              final messenger = ScaffoldMessenger.of(context);
              final nav = Navigator.of(ctx);

              await ProductService().updateProduct(
                product.id,
                price: newPrice,
                stock: newStock,
              );
              nav.pop();
              messenger.showSnackBar(
                const SnackBar(content: Text('✅ Product details updated successfully!'), backgroundColor: Color(0xFF2E7D32)),
              );
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard({
    required String title,
    required String price,
    required String orders,
    required String moq,
    required String imageUrl,
    required IconData iconData,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDFB),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C3F24).withValues(alpha: 0.03),
            offset: const Offset(0, 3),
            blurRadius: 8.0,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image / Placeholder Container with "Published" badge
          Stack(
            children: [
              Container(
                height: 110.0,
                width: double.infinity,
                color: const Color(0xFFF5EBE1),
                child: Center(
                  child: Icon(iconData, size: 44.0, color: const Color(0xFFB85324)),
                ),
              ),
              Positioned(
                top: 8.0,
                left: 8.0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: const Color(0xFFC8E6C9)),
                  ),
                  child: const Text(
                    'Published',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF221C19),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 3.0),
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFA84318),
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '• $orders',
                      style: const TextStyle(
                        fontSize: 11.0,
                        color: Color(0xFF7A685F),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBF4EE),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    'Wholesale MOQ: $moq',
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF6B584E),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 7. Artisan Score & Reliability Card
  Widget _buildArtisanScoreCard() {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF6F0),
        borderRadius: BorderRadius.circular(18.0),
        border: Border.all(color: const Color(0xFFEADFD6)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.verified_user_rounded, size: 18.0, color: Color(0xFF2E7D32)),
                  SizedBox(width: 6.0),
                  Text(
                    'Craft Maker Score & Reliability',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF221C19),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAE3DC),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Text(
                  'Top Tier',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF5D483E),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12.0),

          Row(
            children: [
              Expanded(
                child: Column(
                  children: const [
                    Text(
                      '96%',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF221C19),
                      ),
                    ),
                    Text(
                      'On-Time Delivery',
                      style: TextStyle(fontSize: 11.0, color: Color(0xFF7A685F)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(width: 1.0, height: 28.0, color: const Color(0xFFE5D5CB)),
              Expanded(
                child: Column(
                  children: const [
                    Text(
                      '★ 4.9',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF221C19),
                      ),
                    ),
                    Text(
                      '34 reviews',
                      style: TextStyle(fontSize: 11.0, color: Color(0xFF7A685F)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(width: 1.0, height: 28.0, color: const Color(0xFFE5D5CB)),
              Expanded(
                child: Column(
                  children: const [
                    Text(
                      'Craft Maker',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFA84318),
                      ),
                    ),
                    Text(
                      'Barabanki Cluster',
                      style: TextStyle(fontSize: 11.0, color: Color(0xFF7A685F)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 8. Opportunities for You Section
  Widget _buildOpportunitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Text(
                  '🔥 Opportunities for you',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF221C19),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _activeSubScreen = CollaborationHubScreen(
                    onBack: () => setState(() => _activeSubScreen = null),
                    onNavigateTab: (idx) => setState(() {
                      _activeSubScreen = null;
                      _currentNavIndex = idx;
                    }),
                  );
                });
              },
              child: const Text(
                'View All (12)>',
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF8C3A16),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 8.0),

        // Opportunity 1: Bulk B2B Order
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDFB),
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(color: const Color(0xFFEADFD6)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C3F24).withValues(alpha: 0.03),
                offset: const Offset(0, 3),
                blurRadius: 8.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E0),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: const Color(0xFFFFE0B2)),
                    ),
                    child: const Text(
                      'Bulk B2B Order',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE65100),
                      ),
                    ),
                  ),
                  const Text(
                    '₹45,000',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF221C19),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Bulk Order: 100 Terracotta Planters',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF221C19),
                ),
              ),
              const SizedBox(height: 4.0),
              Row(
                children: const [
                  Icon(Icons.storefront_outlined, size: 14.0, color: Color(0xFF7A685F)),
                  SizedBox(width: 4.0),
                  Text(
                    'FabIndia Curated Home',
                    style: TextStyle(fontSize: 12.5, color: Color(0xFF7A685F)),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.calendar_today_outlined, size: 13.0, color: Color(0xFF7A685F)),
                      SizedBox(width: 4.0),
                      Text(
                        'Estimated: 10–14 days',
                        style: TextStyle(fontSize: 11.5, color: Color(0xFF7A685F)),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _activeSubScreen = OrderRequestScreen(
                          buyerName: 'FabIndia Curated Home',
                          productName: '100 Terracotta Planters',
                          totalQuantity: 100,
                          unitPrice: 380,
                          myCapacity: 80,
                          onBack: () => setState(() => _activeSubScreen = null),
                          onNavigateTab: (idx) => setState(() {
                            _activeSubScreen = null;
                            _currentNavIndex = idx;
                          }),
                          onAccept: () {
                            setState(() => _activeSubScreen = null);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('✅ Opportunity Accepted! Escrow locked.'),
                                backgroundColor: Color(0xFF2E7D32),
                              ),
                            );
                          },
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8C3A16),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: const Text(
                      'View Opportunity',
                      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 12.0),

        // Opportunity 2: Guild Collaboration
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFDFB),
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(color: const Color(0xFFEADFD6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.group_outlined, size: 12.0, color: Color(0xFF2E7D32)),
                        SizedBox(width: 3.0),
                        Text(
                          'Guild Collaboration',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Deadline: 20 Oct',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFC53030),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Collaboration Request:\nHandcrafted Brass & Clay Lamps',
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF221C19),
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 6.0),
              Row(
                children: const [
                  Icon(Icons.person_pin_circle_outlined, size: 14.0, color: Color(0xFF8C3A16)),
                  SizedBox(width: 4.0),
                  Expanded(
                    child: Text(
                      'Looking for 1 Potter partner by Kishore Potter Guild',
                      style: TextStyle(fontSize: 12.0, color: Color(0xFF6B584E)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Shared Payout • 50/50',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A372D),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _activeSubScreen = CollaborationHubScreen(
                          onBack: () => setState(() => _activeSubScreen = null),
                          onNavigateTab: (idx) => setState(() {
                            _activeSubScreen = null;
                            _currentNavIndex = idx;
                          }),
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF3E7DF),
                      foregroundColor: const Color(0xFF8C3A16),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: const Text(
                      'Join Collaboration',
                      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 9. Bottom Navigation Bar (5 tabs)
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFFFDFB),
        border: Border(top: BorderSide(color: Color(0xFFEADFD6), width: 1.0)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.storefront_rounded, 'Home'),
          _buildNavItem(1, Icons.palette_outlined, 'Products'),
          _buildNavItem(2, Icons.receipt_long_outlined, 'Orders'),
          _buildNavItem(3, Icons.groups_outlined, 'Collaborate'),
          _buildNavItem(4, Icons.person_outline_rounded, 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = _currentNavIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentNavIndex = index;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF8E5D8) : Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20.0,
              color: isSelected ? const Color(0xFF8C3A16) : const Color(0xFF7A685F),
            ),
            const SizedBox(height: 2.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                color: isSelected ? const Color(0xFF8C3A16) : const Color(0xFF7A685F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
