// lib/models/order_model.dart

class OrderItemModel {
  final String id;
  final String orderId;
  final String productId;
  final String productName;
  final int quantity;
  final double price;

  const OrderItemModel({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });
}

class OrderModel {
  final String id;
  final String orderNumber;
  final String buyerId;
  final String buyerName;
  final String artisanId;
  final String productTitle;
  final int quantity;
  final int unitsTotal;
  final int unitsCompleted;
  final double totalAmount;
  final double escrowAmount;
  final String status; // 'pending', 'accepted', 'in_production', 'shipped', 'delivered', 'cancelled'
  final DateTime? dispatchDate;
  final List<OrderItemModel> items;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String expectedDelivery;
  final String? paymentStatus;

  const OrderModel({
    required this.id,
    this.orderNumber = 'PO-2026-8891',
    this.buyerId = 'buyer-1',
    this.buyerName = 'Retail Buyer',
    this.artisanId = 'art_1',
    this.productTitle = 'Handmade Woven Bamboo Basket',
    this.quantity = 50,
    this.unitsTotal = 50,
    this.unitsCompleted = 0,
    required this.totalAmount,
    this.escrowAmount = 0.0,
    this.status = 'in_production',
    this.dispatchDate,
    this.items = const [],
    this.createdAt,
    this.updatedAt,
    this.expectedDelivery = '2026-04-05',
    this.paymentStatus = 'Escrow Locked',
  });

  OrderModel copyWith({
    String? id,
    String? orderNumber,
    String? buyerId,
    String? buyerName,
    String? artisanId,
    String? productTitle,
    int? quantity,
    int? unitsTotal,
    int? unitsCompleted,
    double? totalAmount,
    double? escrowAmount,
    String? status,
    DateTime? dispatchDate,
    List<OrderItemModel>? items,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? expectedDelivery,
    String? paymentStatus,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      buyerId: buyerId ?? this.buyerId,
      buyerName: buyerName ?? this.buyerName,
      artisanId: artisanId ?? this.artisanId,
      productTitle: productTitle ?? this.productTitle,
      quantity: quantity ?? this.quantity,
      unitsTotal: unitsTotal ?? this.unitsTotal,
      unitsCompleted: unitsCompleted ?? this.unitsCompleted,
      totalAmount: totalAmount ?? this.totalAmount,
      escrowAmount: escrowAmount ?? this.escrowAmount,
      status: status ?? this.status,
      dispatchDate: dispatchDate ?? this.dispatchDate,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      expectedDelivery: expectedDelivery ?? this.expectedDelivery,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }
}

class OrderRequestModel {
  final String id;
  final String? artisanId;
  final String? buyerId;
  final String buyerName;
  final String buyerLocation;
  final String? productId;
  final String? productName;
  final String title;
  final int quantity;
  final double unitPrice;
  final double totalAmount;
  final double budget;
  final String deliveryDate;
  final String? message;
  final String specialRequirements;
  final String status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const OrderRequestModel({
    required this.id,
    this.artisanId = '22222222-2222-2222-2222-222222222222',
    this.buyerId,
    required this.buyerName,
    this.buyerLocation = 'New Delhi',
    this.productId,
    this.productName,
    String? title,
    required this.quantity,
    this.unitPrice = 280.0,
    double? totalAmount,
    double? budget,
    this.deliveryDate = '2026-04-15',
    this.message,
    this.specialRequirements = 'Need custom brand engraving',
    this.status = 'pending',
    this.createdAt,
    this.updatedAt,
  })  : title = title ?? productName ?? 'Bulk Order Request',
        budget = budget ?? totalAmount ?? (quantity * (unitPrice > 0 ? unitPrice : 280.0)),
        totalAmount = totalAmount ?? budget ?? (quantity * (unitPrice > 0 ? unitPrice : 280.0));
}
