// lib/models/collaboration_model.dart

class CollaborationRequest {
  final String id;
  final String title;
  final String craftCategory;
  final String requesterName;
  final String clusterLocation;
  final String escrowAmount;
  final String deadline;
  final String status;
  final int unitsNeeded;
  final String compensationPerUnit;

  const CollaborationRequest({
    required this.id,
    required this.title,
    required this.craftCategory,
    required this.requesterName,
    required this.clusterLocation,
    required this.escrowAmount,
    required this.deadline,
    this.status = 'Open',
    this.unitsNeeded = 20,
    this.compensationPerUnit = '₹450',
  });
}

class CollaborationModel {
  final String id;
  final String artisanId;
  final String? buyerId;
  final String title;
  final String description;
  final String clusterName;
  final String partnerArtisanName;
  final int allocatedUnits;
  final String status; // open, active, completed, declined
  final DateTime createdAt;
  final DateTime updatedAt;

  const CollaborationModel({
    required this.id,
    required this.artisanId,
    this.buyerId,
    required this.title,
    this.description = '',
    this.clusterName = 'Barabanki Bamboo Guild',
    this.partnerArtisanName = 'Sunita Devi & Biren Kalita',
    this.allocatedUnits = 250,
    this.status = 'open',
    required this.createdAt,
    required this.updatedAt,
  });

  factory CollaborationModel.fromJson(Map<String, dynamic> json) {
    return CollaborationModel(
      id: json['id'] as String? ?? '',
      artisanId: json['artisan_id'] as String? ?? '22222222-2222-2222-2222-222222222222',
      buyerId: json['buyer_id'] as String?,
      title: json['title'] as String? ?? 'Cluster Splitting Guild',
      description: json['description'] as String? ?? '',
      clusterName: json['cluster_name'] as String? ?? 'Barabanki Bamboo Guild',
      partnerArtisanName: json['partner_artisan_name'] as String? ?? 'Cluster Artisans',
      allocatedUnits: json['allocated_units'] as int? ?? 0,
      status: json['status'] as String? ?? 'open',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now()
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'] as String) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'artisan_id': artisanId,
      'buyer_id': buyerId,
      'title': title,
      'description': description,
      'cluster_name': clusterName,
      'partner_artisan_name': partnerArtisanName,
      'allocated_units': allocatedUnits,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
