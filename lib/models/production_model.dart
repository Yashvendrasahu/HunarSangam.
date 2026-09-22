// lib/models/production_model.dart

class ProductionUpdateModel {
  final String id;
  final String orderId;
  final String milestone;
  final String description;
  final String? photoUrl;
  final String status; // pending, in_progress, completed
  final int unitsMilestone;
  final DateTime createdAt;

  const ProductionUpdateModel({
    required this.id,
    required this.orderId,
    required this.milestone,
    this.description = '',
    this.photoUrl,
    this.status = 'completed',
    this.unitsMilestone = 0,
    required this.createdAt,
  });

  factory ProductionUpdateModel.fromJson(Map<String, dynamic> json) {
    return ProductionUpdateModel(
      id: json['id'] as String? ?? '',
      orderId: json['order_id'] as String? ?? '',
      milestone: json['milestone'] as String? ?? 'Production Progress',
      description: json['description'] as String? ?? '',
      photoUrl: json['photo_url'] as String?,
      status: json['status'] as String? ?? 'completed',
      unitsMilestone: json['units_milestone'] as int? ?? 0,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'milestone': milestone,
      'description': description,
      'photo_url': photoUrl,
      'status': status,
      'units_milestone': unitsMilestone,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
