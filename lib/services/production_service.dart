// lib/services/production_service.dart

import 'dart:async';
import '../models/production_model.dart';
import 'order_service.dart';

class ProductionService {
  static final ProductionService _instance = ProductionService._internal();
  factory ProductionService() => _instance;
  ProductionService._internal() {
    _initDemoUpdates();
  }

  final List<ProductionUpdateModel> _updates = [];
  final _updatesStreamController = StreamController<List<ProductionUpdateModel>>.broadcast();
  Stream<List<ProductionUpdateModel>> get updatesStream => _updatesStreamController.stream;

  void _initDemoUpdates() {
    if (_updates.isNotEmpty) return;

    _updates.addAll([
      ProductionUpdateModel(
        id: 'update-1',
        orderId: '44444444-4444-4444-4444-444444444441',
        milestone: 'Order Confirmed & Bamboo Seasoning',
        description: 'Selected Grade-A green bamboo and completed anti-fungal organic water bath treatment.',
        photoUrl: 'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?auto=format&fit=crop&w=400&q=80',
        status: 'completed',
        unitsMilestone: 50,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      ProductionUpdateModel(
        id: 'update-2',
        orderId: '44444444-4444-4444-4444-444444444441',
        milestone: 'Lattice Weaving In Progress',
        description: 'Completed base ring weaving for 30 out of 50 units with master cluster artisans.',
        photoUrl: 'https://images.unsplash.com/photo-1584589167171-541ce45f1eea?auto=format&fit=crop&w=400&q=80',
        status: 'completed',
        unitsMilestone: 30,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
    ]);
  }

  /// Get production timeline updates for an order
  Future<List<ProductionUpdateModel>> getUpdatesForOrder(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 150));
    return _updates.where((u) => u.orderId == orderId).toList();
  }

  /// Add milestone update with photo
  Future<ProductionUpdateModel> logMilestone({
    required String orderId,
    required String milestone,
    String description = '',
    String? photoUrl,
    int unitsMilestone = 0,
    String status = 'completed',
  }) async {
    await Future.delayed(const Duration(milliseconds: 250));

    final newUpdate = ProductionUpdateModel(
      id: 'upd_${DateTime.now().millisecondsSinceEpoch}',
      orderId: orderId,
      milestone: milestone,
      description: description,
      photoUrl: photoUrl ??
          'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?auto=format&fit=crop&w=400&q=80',
      status: status,
      unitsMilestone: unitsMilestone,
      createdAt: DateTime.now(),
    );

    _updates.insert(0, newUpdate);
    _updatesStreamController.add(List.unmodifiable(_updates));

    // Update order progress units if unitsMilestone provided
    if (unitsMilestone > 0) {
      try {
        await OrderService().updateOrderStatus(
          orderId,
          unitsMilestone >= 50 ? 'ready' : 'in_production',
          unitsCompleted: unitsMilestone,
        );
      } catch (_) {}
    }

    return newUpdate;
  }
}
