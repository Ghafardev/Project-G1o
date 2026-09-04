import 'package:flutter/material.dart';
import 'dart:ui';
import 'chat_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Gaia Connect", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    _buildGlassCard("Status Banjir", "100%", "Aman", [const Color(0xFF333D72), const Color(0xFF5E9AFB)]),
                    _buildGlassCard("Gempa Terkini", "4.5 SR", "Luar Kota", [const Color(0xFFE580A7), const Color(0xFFFB9A5E)]),
                    _buildGlassCard("Oksigen", "98%", "Normal", [const Color(0xFF43E97B), const Color(0xFF38F9D7)]),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatScreen())),
                      child: _buildGlassCard("RagaBhumi AI", "Tanya AI", "Mode Offline", [const Color(0xFF667EEA), const Color(0xFF764BA2)], isAction: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlassCard(String title, String value, String sub, List<Color> colors, {bool isAction = false}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors.map((c) => c.withAlpha(150)).toList()),
            border: Border.all(color: Colors.white.withAlpha(50)),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white70, fontSize: 10)),
                  if (isAction) const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 10),
                ],
              ),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              Text(sub, style: const TextStyle(color: Colors.white54, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }
}