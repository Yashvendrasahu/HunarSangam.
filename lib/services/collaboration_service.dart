// lib/services/collaboration_service.dart

import '../models/collaboration_model.dart';

class CollaborationService {
  static final CollaborationService _instance = CollaborationService._internal();
  factory CollaborationService() => _instance;
  CollaborationService._internal();

  List<CollaborationRequest> getRequests() {
    return [
      const CollaborationRequest(
        id: 'REQ-HH-8841',
        title: 'Bamboo Handwoven Basket (20 pcs share)',
        craftCategory: 'Bamboo & Cane',
        requesterName: 'Ramesh Kumar',
        clusterLocation: 'Varanasi Cluster',
        escrowAmount: '₹9,000',
        deadline: '28 Sep',
        status: 'Open',
        unitsNeeded: 20,
        compensationPerUnit: '₹450',
      ),
    ];
  }
}
