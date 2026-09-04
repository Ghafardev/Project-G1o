import 'package:flutter/material.dart';
import '../../../core/routes.dart';
import '../../emergency/presentation/emergency_modal.dart';
import 'widgets/glass_menu_card.dart'; // Pastikan file ini ada sesuai langkah refactor 1

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Data menu dengan desain 3x3 grid sesuai v0
    final List<Map<String, dynamic>> menuItems = [
      // BARIS 1
      {
        'icon': Icons.waves_outlined, // Banjir
        'title': 'Banjir',
        'subtitle': 'Info & Evakuasi',
        'color': Color(0xFF2196F3), // Warna biru bright
        'route': AppRoutes.guide,
      },
      {
        'icon': Icons.landscape_outlined, // Gempa
        'title': 'Gempa',
        'subtitle': 'Panduan Aman',
        'color': Color(0xFFFF9800), // Warna oranye bright
        'route': AppRoutes.guide,
      },
      {
        'icon': Icons.chat_bubble_outline, // RagaBhumi AI
        'title': 'RagaBhumi',
        'subtitle': 'Asisten AI',
        'color': Color(0xFF9C27B0), // Warna ungu bright
        'route': AppRoutes.chat,
      },

      // BARIS 2
      {
        'icon': Icons.map_outlined, // Peta
        'title': 'Peta',
        'subtitle': 'Lokasi Darurat',
        'color': Color(0xFF4CAF50), // Warna hijau bright
        'route': '/map',
      },
      {
        'icon': Icons.medical_services_outlined, // P3K
        'title': 'P3K',
        'subtitle': 'Pertolongan Pertama',
        'color': Color(0xFFE91E63), // Warna pink bright
        'route': AppRoutes.guide,
      },
      {
        'icon': Icons.local_fire_department_outlined, // Kebakaran
        'title': 'Kebakaran',
        'subtitle': 'Tindakan Darurat',
        'color': Color(0xFFF44336), // Warna merah bright
        'route': AppRoutes.guide,
      },

      // BARIS 3
      {
        'icon': Icons.person_2_outlined, // Kontak Darurat
        'title': 'Kontak Darurat',
        'subtitle': 'Hubungi Bantuan',
        'color': Color(0xFF673AB7), // Warna deep purple bright
        'route': AppRoutes.contacts,
      },
      {
        'icon': Icons.warning_amber_outlined, // Peringatan
        'title': 'Peringatan',
        'subtitle': 'Info Bencana',
        'color': Color(0xFFFFEB3B), // Warna kuning bright
        'route': '/logs',
      },
      {
        'icon': Icons.shield_outlined, // Keamanan
        'title': 'Keamanan',
        'subtitle': 'Konfigurasi',
        'color': Color(0xFF1c2541),
        'route': AppRoutes.settings,
      },
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Gaia Connect",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              // 2. Kartu Status Atas (Dikembalikan)
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.5,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF333D72), Color(0xFF5E9AFB)],
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Status Banjir", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        SizedBox(height: 8),
                        Text("100%", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        Text("Aman", style: TextStyle(color: Colors.white54, fontSize: 10)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF43E97B), Color(0xFF38F9D7)],
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("Oksigen", style: TextStyle(color: Colors.white70, fontSize: 12)),
                        SizedBox(height: 8),
                        Text("98%", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        Text("Normal", style: TextStyle(color: Colors.white54, fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const Text("Aksi Cepat", style: TextStyle(color: Colors.white70, fontSize: 16)),
              const SizedBox(height: 10),

              // 3. Grid View Menu Utama
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return GlassMenuCard(
                      title: item['title'],
                      subtitle: item['subtitle'],
                      icon: item['icon'],
                      colors: [item['color'], (item['color'] as Color).withValues(alpha: 0.6)],
                      isAction: true,
                      onTap: () {
                        // Logika navigasi
                        if (item.containsKey('route')) {
                          Navigator.pushNamed(context, item['route']);
                        } else if (item.containsKey('action')) {
                          if (item['action'] == 'sos') {
                            EmergencyModal.show(context);
                          } else if (item['action'] == 'flashlight') {
                            // Implementasi flashlight jika diperlukan
                          }
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
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
                onPressed: () {
                  // Already on home screen
                }
              ),
              IconButton(
                icon: const Icon(Icons.map_outlined, color: Colors.white), 
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.map);
                }
              ),
              const SizedBox(width: 40), // Spasi untuk tombol SOS
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, color: Colors.white), 
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.ai);
                }
              ),
              IconButton(
                icon: const Icon(Icons.person_outlined, color: Colors.white), 
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.profile);
                }
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFFF3B3B),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFF3B3B).withValues(alpha: 0.5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
            BoxShadow(
              color: const Color(0xFFFF3B3B).withValues(alpha: 0.8),
              blurRadius: 40,
              spreadRadius: -2,
            ),
          ],
        ),
        child: Material(
          shape: const CircleBorder(),
          color: Colors.transparent,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              EmergencyModal.show(context);
            },
            child: const Center(
              child: Text(
                "SOS",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}