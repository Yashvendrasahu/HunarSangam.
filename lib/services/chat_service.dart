// lib/services/chat_service.dart

import 'dart:async';
import '../models/chat_models.dart';
import 'gemini_service.dart';

class ChatService {
  static final ChatService _instance = ChatService._internal();
  factory ChatService() => _instance;
  ChatService._internal();

  final GeminiService _gemini = GeminiService();
  final _unreadController = StreamController<int>.broadcast();
  Stream<int> get unreadCountStream => _unreadController.stream;

  final Map<String, StreamController<List<ChatMessage>>> _streamControllers = {};

  final Map<String, List<ChatMessage>> _conversationMessages = {
    'default': [
      ChatMessage(
        id: '1',
        senderId: 'fabindia',
        senderName: 'FabIndia Retail Ltd.',
        senderType: 'buyer',
        content: 'Namaste! We reviewed your bamboo fruit basket catalog and would like to place an initial bulk order.',
        translatedContent: 'नमस्ते! हमने आपकी बांस की टोकरी कैटलॉग की समीक्षा की है और प्रारंभिक थोक ऑर्डर देना चाहते हैं।',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isMe: false,
      ),
      ChatMessage(
        id: '2',
        senderId: 'artisan_1',
        senderName: 'Ramu Kumar',
        senderType: 'artisan',
        content: 'Namaste! Thank you. We can produce 120 units within 2 weeks with verified quality checks.',
        translatedContent: 'Thank you! We can produce 120 units within 2 weeks with verified quality checks.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isMe: true,
      ),
    ],
  };

  Stream<List<ChatMessage>> getMessagesStream(String conversationId) {
    if (!_streamControllers.containsKey(conversationId)) {
      _streamControllers[conversationId] = StreamController<List<ChatMessage>>.broadcast();
    }
    return _streamControllers[conversationId]!.stream;
  }

  Future<List<ChatMessage>> fetchMessages(String conversationId, {String userRole = 'artisan'}) async {
    final list = _conversationMessages[conversationId] ?? _conversationMessages['default'] ?? [];
    return List.unmodifiable(list);
  }

  List<ChatMessage> getMessages(String conversationId) {
    return _conversationMessages[conversationId] ?? _conversationMessages['default'] ?? [];
  }

  Future<void> sendMessage({
    required String conversationId,
    required String senderType,
    required String senderName,
    required String senderId,
    required String content,
    String? orderId,
    bool isAudio = false,
    String? audioDuration,
  }) async {
    String translated = '';
    try {
      final targetLang = senderType == 'buyer' ? 'Hindi' : 'English';
      translated = await _gemini.translateText(text: content, targetLanguage: targetLang);
    } catch (_) {
      translated = 'AI Translated: $content';
    }

    final msg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: senderId,
      senderName: senderName,
      senderType: senderType,
      content: content,
      translatedContent: translated.isNotEmpty ? translated : content,
      timestamp: DateTime.now(),
      isMe: senderType == 'artisan',
      isAudio: isAudio,
      audioDuration: audioDuration,
    );

    if (!_conversationMessages.containsKey(conversationId)) {
      _conversationMessages[conversationId] = [];
    }
    _conversationMessages[conversationId]!.add(msg);

    if (_streamControllers.containsKey(conversationId)) {
      _streamControllers[conversationId]!.add(List.unmodifiable(_conversationMessages[conversationId]!));
    }
  }
}
