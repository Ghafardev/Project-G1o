import 'package:flutter/material.dart';
import '../../Data/Models/chat_message.dart';
import '../../Data/Services/chat_service.dart';
import '../../Data/Services/ai_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  final AIService _aiService = AIService();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<ChatMessage> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    final messages = await _chatService.getAllMessages();
    setState(() {
      _messages = messages;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    _controller.clear();
    final userMsg = ChatMessage()
      ..content = text
      ..isUser = true
      ..timestamp = DateTime.now();

    await _chatService.saveMessage(userMsg);
    _loadMessages();

    setState(() => _isLoading = true);
    await _generateAIResponse(text); // Mengirim teks prompt ke AI
  }

  Future<void> _generateAIResponse(String prompt) async {
    try {
      final response = await _aiService.generateResponse(prompt);
      final aiMsg = ChatMessage()
        ..content = response
        ..isUser = false
        ..timestamp = DateTime.now();

      await _chatService.saveMessage(aiMsg);
    } catch (e) {
      debugPrint("Error AI: $e");
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
        _loadMessages();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text("RagaBhumi AI", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) => _buildChatBubble(_messages[index]),
            ),
          ),
          if (_isLoading) const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(color: Color(0xFFE580A7)),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage message) {
    // Gunakan kode Glassmorphism yang kita buat sebelumnya di sini
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blueGrey : Colors.deepPurple,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(message.content, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Tanya sesuatu...",
                hintStyle: TextStyle(color: Colors.white54),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}