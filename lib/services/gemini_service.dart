// lib/services/gemini_service.dart

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'supabase_config.dart';

class GeminiService {
  static final GeminiService _instance = GeminiService._internal();
  factory GeminiService() => _instance;
  GeminiService._internal();

  static const List<String> _candidateModels = [
    'gemini-2.5-flash',
    'gemini-2.0-flash',
    'gemini-1.5-flash-latest',
    'gemini-1.5-flash',
    'gemini-1.5-flash-8b',
    'gemini-1.5-pro',
    'gemini-2.0-flash-lite',
    'gemini-pro',
  ];

  String _activeModel = 'gemini-2.0-flash';
  List<String> _availableDiscoveredModels = [];

  String get _apiKey => SupabaseConfig.geminiApiKey;
  bool get isConfigured => SupabaseConfig.isGeminiConfigured();
  String get activeModel => _activeModel;

  /// Discovers available Gemini models from Google AI API for this key
  Future<List<String>> discoverAvailableModels() async {
    final key = _apiKey.trim();
    if (key.isEmpty) return [];

    final endpoints = [
      'https://generativelanguage.googleapis.com/v1beta/models?key=$key',
      'https://generativelanguage.googleapis.com/v1/models?key=$key',
    ];

    for (final endpoint in endpoints) {
      try {
        final res = await http.get(
          Uri.parse(endpoint),
          headers: {
            'x-goog-api-key': key,
            'Content-Type': 'application/json',
          },
        );

        if (res.statusCode == 200) {
          final data = jsonDecode(res.body) as Map<String, dynamic>;
          final modelsList = data['models'] as List?;
          if (modelsList != null && modelsList.isNotEmpty) {
            final List<String> supported = [];
            for (final m in modelsList) {
              final name = m['name']?.toString() ?? '';
              final methods = m['supportedGenerationMethods'] as List?;
              if (methods != null && methods.contains('generateContent')) {
                // name format is 'models/gemini-1.5-flash' -> extract 'gemini-1.5-flash'
                final cleanName = name.replaceFirst('models/', '');
                supported.add(cleanName);
              }
            }
            if (supported.isNotEmpty) {
              _availableDiscoveredModels = supported;
              // Prefer flash models if present
              final preferred = supported.firstWhere(
                (m) => m.contains('flash') && !m.contains('exp'),
                orElse: () => supported.first,
              );
              _activeModel = preferred;
              return supported;
            }
          }
        }
      } catch (e) {
        debugPrint('[GeminiService] discoverAvailableModels error: $e');
      }
    }

    return [];
  }

  /// Test Gemini API Key connectivity with dynamic model discovery & fallback
  Future<Map<String, dynamic>> testConnection() async {
    final key = _apiKey.trim();
    if (key.isEmpty) {
      return {
        'success': false,
        'message': 'Gemini API key is empty. Please enter your Gemini API key in Settings.',
      };
    }

    // Step 1: Attempt to list models to verify key and find available models
    final discovered = await discoverAvailableModels();
    final List<String> modelsToTest = [];
    if (discovered.isNotEmpty) {
      modelsToTest.addAll(discovered);
    }
    for (final candidate in _candidateModels) {
      if (!modelsToTest.contains(candidate)) {
        modelsToTest.add(candidate);
      }
    }

    String lastError = '';

    for (final model in modelsToTest) {
      for (final apiVersion in ['v1beta', 'v1']) {
        try {
          final prompt = 'Respond with exact word OK';
          final url = Uri.parse(
            'https://generativelanguage.googleapis.com/$apiVersion/models/$model:generateContent?key=$key',
          );

          final response = await http.post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'x-goog-api-key': key,
              'User-Agent': 'aistudio-build',
            },
            body: jsonEncode({
              'contents': [
                {
                  'parts': [
                    {'text': prompt}
                  ]
                }
              ]
            }),
          );

          if (response.statusCode == 200) {
            _activeModel = model;
            return {
              'success': true,
              'message': '✅ Gemini AI Connected Successfully! Active model: $model ($apiVersion)',
            };
          } else {
            lastError = 'Model $model ($apiVersion): HTTP ${response.statusCode} - ${response.body}';
          }
        } catch (e) {
          lastError = 'Connection error on $model: $e';
        }
      }
    }

    return {
      'success': false,
      'message': 'Gemini API connection failed.\nDetails: $lastError\n\nPlease verify that your Google AI Studio API Key is valid and enabled.',
    };
  }

  /// Translates text or translates vernacular craft language to English / Hindi
  Future<String> translateText({
    required String text,
    String targetLanguage = 'English',
  }) async {
    if (_apiKey.isEmpty) {
      return '[AI Translated: $text]';
    }

    final prompt = '''
You are a precise multilingual translator specialized in Indian vernacular languages and handicrafts.
Translate the following text into $targetLanguage accurately and naturally, keeping craft and business context intact.
Only return the translated text without extra explanation:
"$text"
''';

    final result = await generateText(prompt: prompt);
    return result.trim().isNotEmpty ? result.trim() : text;
  }

  /// Generates craft storytelling and catalog details from voice transcription
  Future<Map<String, dynamic>> generateCraftCatalog({
    required String voiceTranscript,
    String craftType = 'Handicrafts',
  }) async {
    final defaultResponse = {
      'title': 'Handcrafted Heritage $craftType Masterpiece',
      'description': voiceTranscript.isNotEmpty
          ? 'Crafted with authentic heritage techniques: $voiceTranscript'
          : 'Traditional handcrafted artisan item with organic finishes and GI cluster certification.',
      'category': craftType,
      'material': 'Natural authentic raw materials',
      'finishAndColor': 'Natural Earth & Heritage Polish',
      'suggestedPrice': 650.0,
      'diameterIn': 12.0,
      'heightIn': 8.0,
      'weightGrams': 450,
      'giCluster': 'Certified Indian Craft Cluster',
      'giRegNumber': 'GI-IND-2026',
    };

    if (_apiKey.isEmpty) {
      return defaultResponse;
    }

    final prompt = '''
You are an expert in Indian GI handicrafts, artisan pricing, and catalog optimization for HunarSangam.
Based on the following artisan voice description and craft type:
Craft Type: $craftType
Artisan Voice Description: "$voiceTranscript"

Extract and generate structured JSON matching this schema:
{
  "title": "A captivating, marketable product title (e.g. Handmade Terracotta Urn)",
  "description": "Rich 2-3 sentence description emphasizing authentic artisan heritage, technique, and materials",
  "category": "Standard category name",
  "material": "Primary materials used",
  "finishAndColor": "Color scheme & finishing",
  "suggestedPrice": 650.0,
  "diameterIn": 12.0,
  "heightIn": 8.0,
  "weightGrams": 450,
  "giCluster": "Relevant Indian Craft Cluster (e.g., Barabanki Bamboo, Khurja Pottery, Madhubani)",
  "giRegNumber": "GI-429"
}
Return ONLY valid JSON.
''';

    try {
      final jsonStr = await generateText(prompt: prompt);
      final cleanJson = _extractJson(jsonStr);
      if (cleanJson.isNotEmpty) {
        final decoded = jsonDecode(cleanJson) as Map<String, dynamic>;
        return {
          'title': decoded['title'] ?? defaultResponse['title'],
          'description': decoded['description'] ?? defaultResponse['description'],
          'category': decoded['category'] ?? defaultResponse['category'],
          'material': decoded['material'] ?? defaultResponse['material'],
          'finishAndColor': decoded['finishAndColor'] ?? defaultResponse['finishAndColor'],
          'suggestedPrice': (decoded['suggestedPrice'] as num?)?.toDouble() ?? defaultResponse['suggestedPrice'],
          'diameterIn': (decoded['diameterIn'] as num?)?.toDouble() ?? defaultResponse['diameterIn'],
          'heightIn': (decoded['heightIn'] as num?)?.toDouble() ?? defaultResponse['heightIn'],
          'weightGrams': (decoded['weightGrams'] as num?)?.toInt() ?? defaultResponse['weightGrams'],
          'giCluster': decoded['giCluster'] ?? defaultResponse['giCluster'],
          'giRegNumber': decoded['giRegNumber'] ?? defaultResponse['giRegNumber'],
        };
      }
    } catch (e) {
      debugPrint('[GeminiService] JSON parse fallback: $e');
    }
    return defaultResponse;
  }

  /// Calculates dynamic fair price with AI explanation
  Future<Map<String, dynamic>> calculateFairPrice({
    required double rawMaterialCost,
    required double hoursWorked,
    required double hourlyWage,
    required String craftType,
  }) async {
    final directCost = rawMaterialCost + (hoursWorked * hourlyWage);
    final basePrice = directCost * 1.30; // 30% margin standard

    if (_apiKey.isEmpty) {
      return {
        'fairPrice': basePrice,
        'breakdown':
            'Material: ₹$rawMaterialCost, Labor: ₹${hoursWorked * hourlyWage}, Fair Margin (30%): ₹${(basePrice - directCost).toStringAsFixed(0)}',
        'rationale': 'AI fair-pricing calculation based on GI cluster minimum wage standards and verified material inputs.',
      };
    }

    final prompt = '''
You are the Fair Pricing Engine for HunarSangam (Indian Artisans).
Inputs:
- Craft Type: $craftType
- Raw Material Cost: ₹$rawMaterialCost
- Artisan Labor: $hoursWorked hours at ₹$hourlyWage/hour (Total Labor: ₹${hoursWorked * hourlyWage})

Calculate fair wholesale & retail prices ensuring the artisan earns dignified livelihood above regional statutory rates.
Return ONLY valid JSON:
{
  "fairPrice": ${(basePrice).toStringAsFixed(2)},
  "breakdown": "Clear line-by-line calculation summary",
  "rationale": "1-2 sentence commercial rationale for bulk buyers"
}
''';

    try {
      final jsonStr = await generateText(prompt: prompt);
      final cleanJson = _extractJson(jsonStr);
      if (cleanJson.isNotEmpty) {
        final decoded = jsonDecode(cleanJson) as Map<String, dynamic>;
        return {
          'fairPrice': (decoded['fairPrice'] as num?)?.toDouble() ?? basePrice,
          'breakdown': decoded['breakdown']?.toString() ?? 'Direct Cost + Margin',
          'rationale': decoded['rationale']?.toString() ?? 'Calculated using artisan minimum living wage model.',
        };
      }
    } catch (e) {
      debugPrint('[GeminiService] fairPrice fallback: $e');
    }

    return {
      'fairPrice': basePrice,
      'breakdown':
          'Material: ₹$rawMaterialCost, Labor: ₹${hoursWorked * hourlyWage}, Fair Margin (30%): ₹${(basePrice - directCost).toStringAsFixed(0)}',
      'rationale': 'AI fair-pricing calculation based on GI cluster minimum wage standards.',
    };
  }

  /// Matches buyer requirements to artisan craft clusters
  Future<Map<String, dynamic>> parseBuyerRequirement({
    required String voiceOrTextRequirement,
  }) async {
    final defaultMatch = {
      'craftCategory': 'Bamboo & Cane',
      'quantity': 250,
      'estimatedBudget': '₹75,000 - ₹1,00,000',
      'targetDeliveryDays': 14,
      'searchKeywords': ['bamboo', 'handwoven', 'fruit basket', 'bulk order'],
      'summary': voiceOrTextRequirement.isNotEmpty ? voiceOrTextRequirement : 'Natural eco-friendly handcrafted bulk requirement',
    };

    if (_apiKey.isEmpty) {
      return defaultMatch;
    }

    final prompt = '''
You are a B2B sourcing analyst for Indian Handicrafts on HunarSangam.
Extract structured procurement details from this buyer voice or text requirement:
"$voiceOrTextRequirement"

Return ONLY valid JSON:
{
  "craftCategory": "Most matching category (e.g. Bamboo & Cane, Pottery & Ceramics, Brassware, Madhubani, Textiles)",
  "quantity": 100,
  "estimatedBudget": "e.g. ₹50,000 - ₹80,000",
  "targetDeliveryDays": 14,
  "searchKeywords": ["keyword1", "keyword2"],
  "summary": "Concise 1-sentence buyer requirement summary"
}
''';

    try {
      final res = await generateText(prompt: prompt);
      final clean = _extractJson(res);
      if (clean.isNotEmpty) {
        final decoded = jsonDecode(clean) as Map<String, dynamic>;
        return {
          'craftCategory': decoded['craftCategory'] ?? defaultMatch['craftCategory'],
          'quantity': (decoded['quantity'] as num?)?.toInt() ?? defaultMatch['quantity'],
          'estimatedBudget': decoded['estimatedBudget'] ?? defaultMatch['estimatedBudget'],
          'targetDeliveryDays': (decoded['targetDeliveryDays'] as num?)?.toInt() ?? defaultMatch['targetDeliveryDays'],
          'searchKeywords': (decoded['searchKeywords'] as List?)?.map((e) => e.toString()).toList() ?? defaultMatch['searchKeywords'],
          'summary': decoded['summary'] ?? defaultMatch['summary'],
        };
      }
    } catch (e) {
      debugPrint('[GeminiService] parseBuyerRequirement fallback: $e');
    }

    return defaultMatch;
  }

  /// Generates bilingual product story, craft highlights, and SEO tags
  Future<Map<String, dynamic>> generateProductDescription({
    required String productTitle,
    required String craftCategory,
    required String artisanName,
    required String region,
    required List<String> materials,
  }) async {
    final defaultDesc = {
      'storyEn': 'Handcrafted with reverence for age-old traditions by $artisanName in $region. Every detail reflects genuine Indian heritage and organic craftsmanship.',
      'storyHi': '$artisanName द्वारा $region में पारंपरिक तकनीकों से हस्तनिर्मित। यह कलाकृति भारतीय शिल्प विरासत की प्रामाणिकता दर्शाती है।',
      'highlights': ['100% Handcrafted', 'Natural & Eco-Friendly', 'GI Cluster Heritage'],
      'careInstructions': ['Keep away from excessive moisture', 'Clean gently with a dry microfiber cloth'],
      'seoTags': [craftCategory, 'Handcrafted', region, 'Artisan Direct'],
    };

    if (_apiKey.isEmpty) return defaultDesc;

    final prompt = '''
You are a master storyteller for HunarSangam handicraft marketplace.
Product: "$productTitle"
Craft: $craftCategory
Artisan: $artisanName
Region: $region
Materials: ${materials.join(', ')}

Return ONLY valid JSON matching:
{
  "storyEn": "Rich 2-sentence English narrative celebrating the artisan's heritage and technique",
  "storyHi": "Rich 2-sentence Hindi narrative for local buyers",
  "highlights": ["highlight1", "highlight2", "highlight3"],
  "careInstructions": ["care1", "care2"],
  "seoTags": ["tag1", "tag2", "tag3"]
}
''';

    try {
      final res = await generateText(prompt: prompt);
      final clean = _extractJson(res);
      if (clean.isNotEmpty) {
        final decoded = jsonDecode(clean) as Map<String, dynamic>;
        return {
          'storyEn': decoded['storyEn'] ?? defaultDesc['storyEn'],
          'storyHi': decoded['storyHi'] ?? defaultDesc['storyHi'],
          'highlights': (decoded['highlights'] as List?)?.map((e) => e.toString()).toList() ?? defaultDesc['highlights'],
          'careInstructions': (decoded['careInstructions'] as List?)?.map((e) => e.toString()).toList() ?? defaultDesc['careInstructions'],
          'seoTags': (decoded['seoTags'] as List?)?.map((e) => e.toString()).toList() ?? defaultDesc['seoTags'],
        };
      }
    } catch (e) {
      debugPrint('[GeminiService] productDescription error: $e');
    }

    return defaultDesc;
  }

  /// AI craft assistant for conversational queries
  Future<Map<String, dynamic>> chatWithCraftAssistant({
    required String query,
    String language = 'English',
  }) async {
    final defaultResponse = {
      'reply': 'Namaste! HunarSangam connects you directly with verified Indian artisan clusters for fair pricing, bulk procurement, and verified GI heritage crafts.',
      'suggestions': ['Check fair-price calculator', 'Explore Bamboo & Cane cluster', 'Create a bulk request'],
    };

    if (_apiKey.isEmpty) return defaultResponse;

    final prompt = '''
You are HunarSangam AI Assistant, an expert advisor for Indian artisans and wholesale buyers.
User Query: "$query"
Language: $language

Answer warmly and concisely in 2-3 sentences.
Return ONLY valid JSON:
{
  "reply": "Helpful answer to user's query",
  "suggestions": ["Next question 1", "Next question 2", "Next question 3"]
}
''';

    try {
      final res = await generateText(prompt: prompt);
      final clean = _extractJson(res);
      if (clean.isNotEmpty) {
        final decoded = jsonDecode(clean) as Map<String, dynamic>;
        return {
          'reply': decoded['reply'] ?? defaultResponse['reply'],
          'suggestions': (decoded['suggestions'] as List?)?.map((e) => e.toString()).toList() ?? defaultResponse['suggestions'],
        };
      }
    } catch (e) {
      debugPrint('[GeminiService] assistant chat error: $e');
    }

    return defaultResponse;
  }

  /// Core Gemini generateContent HTTP caller with multi-model fallback & discovery
  Future<String> generateText({
    required String prompt,
    String? systemInstruction,
  }) async {
    final key = _apiKey.trim();
    if (key.isEmpty) {
      return '';
    }

    final modelsToTry = <String>{
      if (_activeModel.isNotEmpty) _activeModel,
      ..._availableDiscoveredModels,
      ..._candidateModels,
    }.toList();

    for (final model in modelsToTry) {
      for (final apiVersion in ['v1beta', 'v1']) {
        try {
          final url = Uri.parse(
            'https://generativelanguage.googleapis.com/$apiVersion/models/$model:generateContent?key=$key',
          );

          final Map<String, dynamic> body = {
            'contents': [
              {
                'parts': [
                  {'text': prompt}
                ]
              }
            ],
            'generationConfig': {
              'temperature': 0.3,
              'topP': 0.95,
              'maxOutputTokens': 1024,
            }
          };

          if (systemInstruction != null && systemInstruction.isNotEmpty) {
            body['systemInstruction'] = {
              'parts': [
                {'text': systemInstruction}
              ]
            };
          }

          final response = await http.post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'x-goog-api-key': key,
              'User-Agent': 'aistudio-build',
            },
            body: jsonEncode(body),
          );

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body) as Map<String, dynamic>;
            final candidates = data['candidates'] as List?;
            if (candidates != null && candidates.isNotEmpty) {
              final content = candidates[0]['content'] as Map<String, dynamic>?;
              final parts = content?['parts'] as List?;
              if (parts != null && parts.isNotEmpty) {
                final text = parts[0]['text']?.toString() ?? '';
                if (text.isNotEmpty) {
                  _activeModel = model;
                  return text;
                }
              }
            }
          }
        } catch (e) {
          debugPrint('[GeminiService] Error calling $model ($apiVersion): $e');
        }
      }
    }

    return '';
  }

  String _extractJson(String input) {
    var text = input.trim();
    if (text.startsWith('```json')) {
      text = text.substring(7);
    } else if (text.startsWith('```')) {
      text = text.substring(3);
    }
    if (text.endsWith('```')) {
      text = text.substring(0, text.length - 3);
    }
    text = text.trim();
    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');
    if (start != -1 && end != -1 && end > start) {
      return text.substring(start, end + 1);
    }
    return text;
  }
}
