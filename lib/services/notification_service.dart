// lib/services/notification_service.dart

import 'dart:async';
import '../models/notification_model.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal() {
    _initDemoNotifications();
  }

  final List<NotificationModel> _notifications = [];
  final _notificationsStreamController = StreamController<List<NotificationModel>>.broadcast();
  Stream<List<NotificationModel>> get notificationsStream => _notificationsStreamController.stream;

  void _initDemoNotifications() {
    if (_notifications.isNotEmpty) return;

    _notifications.addAll([
      NotificationModel(
        id: 'notif-1',
        artisanId: '22222222-2222-2222-2222-222222222222',
        title: 'New Bulk Order Request Received',
        message: 'FabIndia submitted a PO request for 400 pcs of Woven Bamboo Fruit Basket (₹1,12,000).',
        type: 'order',
        isRead: false,
        createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
      ),
      NotificationModel(
        id: 'notif-2',
        artisanId: '22222222-2222-2222-2222-222222222222',
        title: 'Escrow Advance Deposited',
        message: 'Heritage Handcrafts released ₹5,600 advance for PO-2026-8891.',
        type: 'payment',
        isRead: false,
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
      NotificationModel(
        id: 'notif-3',
        artisanId: '22222222-2222-2222-2222-222222222222',
        title: 'ONDC Sync Active',
        message: '3 crafts are now live and discoverable on ONDC buyer networks.',
        type: 'system',
        isRead: true,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ]);
  }

  /// Get notifications
  Future<List<NotificationModel>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.unmodifiable(_notifications);
  }

  /// Get unread notifications count
  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  /// Mark single notification as read
  Future<void> markAsRead(String id) async {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
      _notificationsStreamController.add(List.unmodifiable(_notifications));
    }
  }

  /// Mark all as read
  Future<void> markAllAsRead() async {
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
    _notificationsStreamController.add(List.unmodifiable(_notifications));
  }

  /// Firebase Cloud Messaging (FCM) incoming push message receiver handler
  void handleFcmIncomingMessage({required String title, required String body, String type = 'order'}) {
    final newNotif = NotificationModel(
      id: 'fcm_${DateTime.now().millisecondsSinceEpoch}',
      artisanId: '22222222-2222-2222-2222-222222222222',
      title: title,
      message: body,
      type: type,
      isRead: false,
      createdAt: DateTime.now(),
    );
    _notifications.insert(0, newNotif);
    _notificationsStreamController.add(List.unmodifiable(_notifications));
  }
}
