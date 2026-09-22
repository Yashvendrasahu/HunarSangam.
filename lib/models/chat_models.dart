// lib/models/chat_models.dart

class ChatMessage {
  final String id;
  final String senderId;
  final String senderName;
  final String senderType; // 'buyer' or 'artisan'
  final String content;
  final String? translatedContent;
  final String? originalLanguage;
  final String? targetLanguage;
  final String time;
  final DateTime timestamp;
  final bool isMe;
  final bool isAudio;
  final String? audioDuration;

  bool get isBuyer => senderType == 'buyer' || isMe;

  ChatMessage({
    required this.id,
    this.senderId = '',
    this.senderName = '',
    this.senderType = 'buyer',
    required this.content,
    this.translatedContent,
    this.originalLanguage,
    this.targetLanguage,
    String? time,
    DateTime? timestamp,
    this.isMe = false,
    this.isAudio = false,
    this.audioDuration,
  })  : timestamp = timestamp ?? DateTime.now(),
        time = time ?? '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}';
}

class ChatConversation {
  final String id;
  final String participantName;
  final String participantRole;
  final String lastMessage;
  final String lastMessageTime;
  final int unreadCount;
  final String avatarUrl;

  const ChatConversation({
    required this.id,
    required this.participantName,
    required this.participantRole,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.avatarUrl = '',
  });
}
