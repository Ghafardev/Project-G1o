import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/routes.dart';
import '../../emergency/presentation/emergency_modal.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      content: 'Halo! Saya RagaBhumi AI. Bagaimana saya bisa membantu Anda hari ini?',
      isUser: false,
      timestamp: DateTime.now(),
    ),
  ];

  final List<String> _faqChips = [
    'Apa yang harus dilakukan saat banjir?',
    'Panduan evakuasi gempa',
    'Pertolongan pertama luka bakar',
    'Lokasi rumah sakit terdekat',
  ];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        content: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _controller.clear();

      // Simulated AI response
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _messages.add(ChatMessage(
            content: _getSimulatedResponse(text),
            isUser: false,
            timestamp: DateTime.now(),
          ));
        });
        _scrollToBottom();
      });
    });

    _scrollToBottom();
  }

  String _getSimulatedResponse(String query) {
    if (query.toLowerCase().contains('banjir')) {
      return 'Saat banjir, segera pindahkan barang-barang penting ke tempat yang lebih tinggi. Matikan listrik dari meteran utama untuk menghindari bahaya listrik. Siapkan tas siaga bencana dan pantau informasi evakuasi.';
    } else if (query.toLowerCase().contains('gempa')) {
      return 'Saat gempa, berlindunglah di bawah meja yang kokoh atau berdiri di bawah pintu. Jauhi jendela dan benda yang mudah jatuh. Setelah guncangan berhenti, segera keluar gedung menuju area terbuka.';
    } else if (query.toLowerCase().contains('bakar')) {
      return 'Untuk luka bakar ringan, siram dengan air mengalir selama 10-15 menit. Jangan olesi mentega atau minyak. Tutup luka dengan kain steril bersih. Segera hubungi dokter jika luka parah.';
    } else if (query.toLowerCase().contains('rumah sakit') || query.toLowerCase().contains('rs')) {
      return 'Rumah sakit terdekat dari lokasi Anda adalah RS Siaga (2.4 km) dan Posko Darurat A (1.2 km). Apakah Anda ingin saya berikan rute navigasi?';
    }
    return 'Saya mengerti. Berdasarkan situasi darurat yang Anda sebutkan, saya sarankan untuk tetap tenang dan mengikuti protokol keselamatan standar. Apakah ada informasi spesifik yang Anda butuhkan?';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF141829),
        elevation: 0,
        title: Text(
          'RagaBhumi AI',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildChatBubble(message);
              },
            ),
          ),
          _buildFaqChips(),
          _buildInputArea(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.red.withValues(alpha: 0.6),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 0),
            ),
            BoxShadow(
              color: Colors.red.withValues(alpha:0.3),
              blurRadius: 40,
              spreadRadius: 4,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.red,
          elevation: 0,
          child: const Text(
            "SOS", 
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
              letterSpacing: 1.2,
            )
          ),
          onPressed: () {
            EmergencyModal.show(context);
          },
        ),
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: message.isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.purple.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.smart_toy, color: Colors.purple, size: 20),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser 
                    ? const Color(0xFF667EEA) 
                    : const Color(0xFF1E3A8A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message.content,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.person, color: Colors.blue, size: 20),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFaqChips() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _faqChips.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ActionChip(
              label: Text(
                _faqChips[index],
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              backgroundColor: const Color(0xFF2C3E50),
              onPressed: () {
                _controller.text = _faqChips[index];
                _sendMessage();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF141829),
        border: Border(
          top: BorderSide(color: Color(0xFF2C3E50), width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2E),
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _controller,
                style: GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Ketik pesan...',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF667EEA),
              borderRadius: BorderRadius.circular(24),
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xFF1b2340),
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home_outlined, color: Colors.white),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.dashboard),
            ),
            IconButton(
              icon: const Icon(Icons.map_outlined, color: Colors.white),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.map),
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: const Icon(Icons.chat_bubble_outline, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person_outlined, color: Colors.white),
              onPressed: () => Navigator.pushNamed(context, AppRoutes.profile),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String content;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.content,
    required this.isUser,
    required this.timestamp,
  });
}
