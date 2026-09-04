import 'package:flutter/material.dart';
import '../../../core/routes.dart';
import '../../../core/widgets/bottom_nav.dart';
import 'widgets/glass_menu_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.waves_outlined,
        'title': 'Banjir',
        'subtitle': 'Info & Evakuasi',
        'color': Color(0xFF2196F3),
        'route': AppRoutes.guide,
      },
      {
        'icon': Icons.landscape_outlined,
        'title': 'Gempa',
        'subtitle': 'Panduan Aman',
        'color': Color(0xFFFF9800),
        'route': AppRoutes.guide,
      },
      {
        'icon': Icons.chat_bubble_outline,
        'title': 'RagaBhumi',
        'subtitle': 'Asisten AI',
        'color': Color(0xFF9C27B0),
        'route': AppRoutes.chat,
      },
      {
        'icon': Icons.map_outlined,
        'title': 'Peta',
        'subtitle': 'Lokasi Darurat',
        'color': Color(0xFF4CAF50),
        'route': AppRoutes.map,
      },
      {
        'icon': Icons.medical_services_outlined,
        'title': 'P3K',
        'subtitle': 'Pertolongan Pertama',
        'color': Color(0xFFE91E63),
        'route': AppRoutes.guide,
      },
      {
        'icon': Icons.local_fire_department_outlined,
        'title': 'Kebakaran',
        'subtitle': 'Tindakan Darurat',
        'color': Color(0xFFF44336),
        'route': AppRoutes.guide,
      },
      {
        'icon': Icons.person_2_outlined,
        'title': 'Kontak Darurat',
        'subtitle': 'Hubungi Bantuan',
        'color': Color(0xFF673AB7),
        'route': AppRoutes.contacts,
      },
      {
        'icon': Icons.warning_amber_outlined,
        'title': 'Peringatan',
        'subtitle': 'Info Bencana',
        'color': Color(0xFFFFEB3B),
        'route': AppRoutes.logs,
      },
      {
        'icon': Icons.shield_outlined,
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
                        if (item.containsKey('route')) {
                          Navigator.pushNamed(context, item['route']);
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
      bottomNavigationBar: const MainBottomNav(currentRoute: AppRoutes.dashboard),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const SosFloatingButton(),
    );
  }
}
