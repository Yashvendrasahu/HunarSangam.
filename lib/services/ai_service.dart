// lib/services/ai_service.dart

import '../add_product/models/product_draft.dart';
import 'gemini_service.dart';

class AiCatalogResult {
  final String productName;
  final String category;
  final String description;
  final String material;
  final String finishAndColor;
  final double diameterIn;
  final double heightIn;
  final double estWeightGrams;
  final double suggestedPrice;
  final String giCluster;
  final String giRegNumber;

  const AiCatalogResult({
    required this.productName,
    required this.category,
    required this.description,
    required this.material,
    required this.finishAndColor,
    required this.diameterIn,
    required this.heightIn,
    required this.estWeightGrams,
    required this.suggestedPrice,
    required this.giCluster,
    required this.giRegNumber,
  });
}

class AiService {
  static final AiService _instance = AiService._internal();
  factory AiService() => _instance;
  AiService._internal();

  final GeminiService _gemini = GeminiService();

  Future<ProductDraft> generateProductDetailsFromVoice(String voiceTranscript, ProductDraft currentDraft) async {
    final aiResult = await _gemini.generateCraftCatalog(
      voiceTranscript: voiceTranscript,
      craftType: currentDraft.category.isNotEmpty ? currentDraft.category : 'Terracotta & Ceramics',
    );

    return currentDraft.copyWith(
      title: aiResult['title'] ?? 'Handcrafted Terracotta Decorative Urn',
      description: aiResult['description'] ?? 'Hand-thrown natural earthen clay vessel with artisan relief patterns.',
      category: aiResult['category'] ?? (currentDraft.category.isNotEmpty ? currentDraft.category : 'Pottery & Ceramics'),
      basePrice: (aiResult['suggestedPrice'] as num?)?.toDouble() ?? 850.0,
      material: aiResult['material'] ?? 'Terracotta Clay',
      finishAndColor: aiResult['finishAndColor'] ?? 'Natural Terracotta Red',
    );
  }

  Future<AiCatalogResult> generateCatalogDetails({
    required String voiceTranscription,
    required String craftType,
    required Map<String, dynamic> dimensions,
    required String photoUrl,
  }) async {
    final ai = await _gemini.generateCraftCatalog(
      voiceTranscript: voiceTranscription,
      craftType: craftType.isNotEmpty ? craftType : 'Bamboo & Cane Weaving',
    );

    return AiCatalogResult(
      productName: ai['title'] ?? 'Handmade Woven Bamboo Fruit Basket',
      category: ai['category'] ?? (craftType.isNotEmpty ? craftType : 'Bamboo & Cane Weaving'),
      description: ai['description'] ?? 'Handwoven natural bamboo storage basket crafted using traditional heritage weaving techniques.',
      material: ai['material'] ?? 'Natural Assam Golden Bamboo',
      finishAndColor: ai['finishAndColor'] ?? 'Honey Gold Polish',
      diameterIn: (ai['diameterIn'] as num?)?.toDouble() ?? ((dimensions['diameter'] as num?)?.toDouble() ?? 12.0),
      heightIn: (ai['heightIn'] as num?)?.toDouble() ?? ((dimensions['height'] as num?)?.toDouble() ?? 8.5),
      estWeightGrams: (ai['weightGrams'] as num?)?.toDouble() ?? 420.0,
      suggestedPrice: (ai['suggestedPrice'] as num?)?.toDouble() ?? 320.0,
      giCluster: ai['giCluster'] ?? 'Barabanki Bamboo Cluster (UP)',
      giRegNumber: ai['giRegNumber'] ?? 'GI-429',
    );
  }

  Future<double> estimateFairPrice({
    required double materialCost,
    required double laborHours,
    required double hourlyWage,
    double markupMargin = 0.25,
    String craftType = 'Handicrafts',
  }) async {
    final result = await _gemini.calculateFairPrice(
      rawMaterialCost: materialCost,
      hoursWorked: laborHours,
      hourlyWage: hourlyWage,
      craftType: craftType,
    );
    return (result['fairPrice'] as num?)?.toDouble() ?? ((materialCost + (laborHours * hourlyWage)) * (1 + markupMargin));
  }
}
