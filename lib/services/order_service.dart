// lib/services/order_service.dart

import 'dart:async';
import '../models/order_model.dart';

class OrderService {
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal() {
    _initDemoOrders();
  }

  final List<OrderModel> _orders = [];
  final List<OrderRequestModel> _orderRequests = [];

  final _ordersStreamController = StreamController<List<OrderModel>>.broadcast();
  Stream<List<OrderModel>> get ordersStream => _ordersStreamController.stream;

  Stream<List<OrderModel>> getArtisanOrdersStream([String? artisanName]) async* {
    yield List.unmodifiable(_orders);
    yield* _ordersStreamController.stream;
  }

  final _requestsStreamController = StreamController<List<OrderRequestModel>>.broadcast();
  Stream<List<OrderRequestModel>> get requestsStream => _requestsStreamController.stream;

  void _initDemoOrders() {
    if (_orders.isNotEmpty) return;

    _orders.addAll([
      OrderModel(
        id: '44444444-4444-4444-4444-444444444441',
        orderNumber: 'PO-2026-8891',
        artisanId: '22222222-2222-2222-2222-222222222222',
        buyerName: 'Heritage Handcrafts Retail (Delhi)',
        totalAmount: 14000.0,
        status: 'in_production',
        escrowAmount: 5600.0,
        unitsTotal: 50,
        unitsCompleted: 30,
        dispatchDate: DateTime.now().add(const Duration(days: 5)),
        items: [
          const OrderItemModel(
            id: 'item-1',
            orderId: '44444444-4444-4444-4444-444444444441',
            productId: '33333333-3333-3333-3333-333333333331',
            productName: 'Handmade Woven Bamboo Fruit Basket',
            quantity: 50,
            price: 280.0,
          ),
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now(),
      ),
      OrderModel(
        id: '44444444-4444-4444-4444-444444444442',
        orderNumber: 'PO-2026-9042',
        artisanId: '22222222-2222-2222-2222-222222222222',
        buyerName: 'The Bombay Store (Mumbai)',
        totalAmount: 27000.0,
        status: 'accepted',
        escrowAmount: 10800.0,
        unitsTotal: 60,
        unitsCompleted: 0,
        dispatchDate: DateTime.now().add(const Duration(days: 12)),
        items: [
          const OrderItemModel(
            id: 'item-2',
            orderId: '44444444-4444-4444-4444-444444444442',
            productId: '33333333-3333-3333-3333-333333333332',
            productName: 'Assam Golden Cane Planter Basket',
            quantity: 60,
            price: 450.0,
          ),
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now(),
      ),
    ]);

    _orderRequests.addAll([
      OrderRequestModel(
        id: 'req-fabindia-400',
        artisanId: '22222222-2222-2222-2222-222222222222',
        buyerName: 'FabIndia Sourcing Hub',
        buyerLocation: 'New Delhi',
        productId: '33333333-3333-3333-3333-333333333331',
        productName: 'Handmade Woven Bamboo Fruit Basket',
        quantity: 400,
        unitPrice: 280.0,
        totalAmount: 112000.0,
        message:
            'Bulk requirement for nationwide Diwali festive collection. Escrow deposit backed with cluster delivery in 20 days.',
        status: 'pending',
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),
        updatedAt: DateTime.now(),
      ),
    ]);
  }

  /// Get list of orders
  Future<List<OrderModel>> getOrders({String? status}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (status == null || status.isEmpty || status == 'all') {
      return List.unmodifiable(_orders);
    }
    return _orders.where((o) => o.status == status).toList();
  }

  /// Get list of pending order requests
  Future<List<OrderRequestModel>> getOrderRequests({String? status}) async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (status == null || status.isEmpty) {
      return List.unmodifiable(_orderRequests);
    }
    return _orderRequests.where((r) => r.status == status).toList();
  }

  /// Accept an order request
  Future<OrderModel> acceptOrderRequest(String requestId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final reqIndex = _orderRequests.indexWhere((r) => r.id == requestId);
    if (reqIndex == -1) {
      throw Exception('Request $requestId not found');
    }

    final req = _orderRequests[reqIndex];
    final updatedReq = OrderRequestModel(
      id: req.id,
      artisanId: req.artisanId,
      buyerId: req.buyerId,
      buyerName: req.buyerName,
      buyerLocation: req.buyerLocation,
      productId: req.productId,
      productName: req.productName,
      quantity: req.quantity,
      unitPrice: req.unitPrice,
      totalAmount: req.totalAmount,
      message: req.message,
      status: 'accepted',
      createdAt: req.createdAt,
      updatedAt: DateTime.now(),
    );
    _orderRequests[reqIndex] = updatedReq;
    _requestsStreamController.add(List.unmodifiable(_orderRequests));

    // Convert into active order
    final newOrder = OrderModel(
      id: 'ord_${DateTime.now().millisecondsSinceEpoch}',
      orderNumber: 'PO-2026-${(1000 + _orders.length * 111)}',
      artisanId: req.artisanId ?? '22222222-2222-2222-2222-222222222222',
      buyerName: req.buyerName,
      totalAmount: req.totalAmount,
      status: 'accepted',
      escrowAmount: req.totalAmount * 0.4,
      unitsTotal: req.quantity,
      unitsCompleted: 0,
      dispatchDate: DateTime.now().add(const Duration(days: 20)),
      items: [
        OrderItemModel(
          id: 'item_${DateTime.now().millisecondsSinceEpoch}',
          orderId: 'ord_${DateTime.now().millisecondsSinceEpoch}',
          productId: req.productId ?? 'prod_1',
          productName: req.productName ?? req.title,
          quantity: req.quantity,
          price: req.unitPrice,
        ),
      ],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    _orders.insert(0, newOrder);
    _ordersStreamController.add(List.unmodifiable(_orders));
    return newOrder;
  }

  /// Reject an order request
  Future<bool> rejectOrderRequest(String requestId) async {
    await Future.delayed(const Duration(milliseconds: 250));
    final reqIndex = _orderRequests.indexWhere((r) => r.id == requestId);
    if (reqIndex != -1) {
      final req = _orderRequests[reqIndex];
      _orderRequests[reqIndex] = OrderRequestModel(
        id: req.id,
        artisanId: req.artisanId,
        buyerId: req.buyerId,
        buyerName: req.buyerName,
        buyerLocation: req.buyerLocation,
        productId: req.productId,
        productName: req.productName,
        quantity: req.quantity,
        unitPrice: req.unitPrice,
        totalAmount: req.totalAmount,
        message: req.message,
        status: 'rejected',
        createdAt: req.createdAt,
        updatedAt: DateTime.now(),
      );
      _requestsStreamController.add(List.unmodifiable(_orderRequests));
    }
    return true;
  }

  /// Update order status (e.g. in_production, ready, completed)
  Future<OrderModel> updateOrderStatus(String orderId, String status, {int? unitsCompleted}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _orders.indexWhere((o) => o.id == orderId || o.orderNumber == orderId);
    if (index == -1) {
      throw Exception('Order $orderId not found');
    }

    final existing = _orders[index];
    final updated = existing.copyWith(
      status: status,
      unitsCompleted: unitsCompleted ?? existing.unitsCompleted,
      updatedAt: DateTime.now(),
    );

    _orders[index] = updated;
    _ordersStreamController.add(List.unmodifiable(_orders));
    return updated;
  }
}
