// lib/add_product/models/product_draft.dart

class ProductDraft {
  final String title;
  final String description;
  final String category;
  final String material;
  final String finishAndColor;
  final double diameterIn;
  final double heightIn;
  final double estWeightGrams;
  final double basePrice;
  final int dailyCapacityPcs;
  final String leadTime;
  final String photoUrl;
  final String secondaryPhotoUrl;
  final String voiceClipTranscription;
  final String giCluster;
  final String giRegNumber;
  final bool isPublished;
  final bool isOndcSynced;

  const ProductDraft({
    this.title = 'Handcrafted Bamboo Fruit Basket',
    this.description = 'Artisanal woven bamboo basket made with authentic GI-certified cane techniques.',
    this.category = 'Bamboo & Cane Weaving',
    this.material = 'Assam Golden Bamboo',
    this.finishAndColor = 'Natural Polish (Honey Gold)',
    this.diameterIn = 12.4,
    this.heightIn = 6.2,
    this.estWeightGrams = 420.0,
    this.basePrice = 280.0,
    this.dailyCapacityPcs = 15,
    this.leadTime = '5-7 Days',
    this.photoUrl = 'https://images.unsplash.com/photo-1590736969955-71cc94801759?auto=format&fit=crop&w=600&q=80',
    this.secondaryPhotoUrl = '',
    this.voiceClipTranscription = '',
    this.giCluster = 'Assam Cane & Bamboo Cluster',
    this.giRegNumber = 'GI-429',
    this.isPublished = false,
    this.isOndcSynced = false,
  });

  ProductDraft copyWith({
    String? title,
    String? description,
    String? category,
    String? material,
    String? finishAndColor,
    double? diameterIn,
    double? heightIn,
    double? estWeightGrams,
    double? basePrice,
    int? dailyCapacityPcs,
    String? leadTime,
    String? photoUrl,
    String? secondaryPhotoUrl,
    String? voiceClipTranscription,
    String? giCluster,
    String? giRegNumber,
    bool? isPublished,
    bool? isOndcSynced,
  }) {
    return ProductDraft(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      material: material ?? this.material,
      finishAndColor: finishAndColor ?? this.finishAndColor,
      diameterIn: diameterIn ?? this.diameterIn,
      heightIn: heightIn ?? this.heightIn,
      estWeightGrams: estWeightGrams ?? this.estWeightGrams,
      basePrice: basePrice ?? this.basePrice,
      dailyCapacityPcs: dailyCapacityPcs ?? this.dailyCapacityPcs,
      leadTime: leadTime ?? this.leadTime,
      photoUrl: photoUrl ?? this.photoUrl,
      secondaryPhotoUrl: secondaryPhotoUrl ?? this.secondaryPhotoUrl,
      voiceClipTranscription: voiceClipTranscription ?? this.voiceClipTranscription,
      giCluster: giCluster ?? this.giCluster,
      giRegNumber: giRegNumber ?? this.giRegNumber,
      isPublished: isPublished ?? this.isPublished,
      isOndcSynced: isOndcSynced ?? this.isOndcSynced,
    );
  }
}
