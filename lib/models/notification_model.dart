// lib/models/notification_model.dart

class NotificationModel {
  final String id;
  final String? artisanId;
  final String title;
  final String message;
  final String? body;
  final String type; // 'order', 'message', 'collaboration', 'system', 'payment'
  final bool isRead;
  final DateTime? createdAt;
  final String? actionRoute;

  const NotificationModel({
    required this.id,
    this.artisanId,
    required this.title,
    required this.message,
    this.body,
    this.type = 'order',
    this.isRead = false,
    this.createdAt,
    this.actionRoute,
  });

  NotificationModel copyWith({
    String? id,
    String? artisanId,
    String? title,
    String? message,
    String? body,
    String? type,
    bool? isRead,
    DateTime? createdAt,
    String? actionRoute,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      artisanId: artisanId ?? this.artisanId,
      title: title ?? this.title,
      message: message ?? this.message,
      body: body ?? this.body,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      actionRoute: actionRoute ?? this.actionRoute,
    );
  }
}
