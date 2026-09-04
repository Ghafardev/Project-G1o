// ignore: file_names
import 'package:flutter/material.dart';
import '../data/chat_message.dart';
import '../data/ai_service.dart';
import 'package:emergency_mvp_app/data/Services/chat_service.dart';

class ChatProvider extends ChangeNotifier {
  final AiService _aiService;
  final ChatService _chatService;

  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  ChatProvider({
    required AiService aiService,
    required ChatService chatService,
  })  : _aiService = aiService,
        _chatService = chatService;

  List<ChatMessage> get messages => _messages;
  bool get isLoading => _isLoading;

  /// Load messages from the database
  Future<void> loadMessages() async {
    final messages = await _chatService.getAllMessages();
    _messages.clear();
    _messages.addAll(messages.reversed.toList()); // Reverse to match ListView(reverse: true)
    notifyListeners();
  }

  /// Send a message to the AI and handle the streaming response
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    // 1. Add User Message
    final userMsg = ChatMessage()
      ..content = text
      ..isUser = true
      ..timestamp = DateTime.now();
    
    _messages.insert(0, userMsg);
    await _chatService.saveMessage(userMsg);
    notifyListeners();

    // 2. Prepare AI Message placeholder
    final aiMsg = ChatMessage()
      ..content = ""
      ..isUser = false
      ..timestamp = DateTime.now();
    
    _messages.insert(0, aiMsg);
    _isLoading = true;
    notifyListeners();

    try {
      // 3. Listen to AI Stream
      final stream = _aiService.getResponseStream(text);
      
      await for (final chunk in stream) {
        aiMsg.content = chunk;
        // Update the message in the list and notify UI
        // Since it's the first element in the reversed list (or last in original)
        // we find it by reference or index.
        notifyListeners();
      }

      // 4. Save final AI message
      await _chatService.saveMessage(aiMsg);
    } catch (e) {
      debugPrint("Error in ChatProvider: $e");
      aiMsg.content = "Maaf, terjadi kesalahan saat memproses permintaan Anda.";
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}