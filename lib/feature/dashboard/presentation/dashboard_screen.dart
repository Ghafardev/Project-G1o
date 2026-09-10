import 'package:flutter/material.dart';
import '../../../core/routes.dart';
import '../../../core/widgets/bottom_nav.dart';
import '../../../data/Services/disaster_service.dart';
import '../../../data/models/earthquake_model.dart';
import 'widgets/glass_menu_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DisasterService _disasterService = DisasterService();
  EarthquakeModel? _latestEarthquake;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEarthquake();
  }

  Future<void> _fetchEarthquake() async {
    final earthquake = await _disasterService.fetchLatestEarthquake();
    if (mounted) {
      setState(() {
        _latestEarthquake = earthquake;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      // ... (keep the same menuItems)
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
              
              // Earthquake Info Card
              _buildEarthquakeCard(),
              
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

  Widget _buildEarthquakeCard() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_latestEarthquake == null) {
      return const Text("Gagal memuat data gempa", style: TextStyle(color: Colors.white70));
    }
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Gempa Terkini: ${_latestEarthquake!.magnitude} SR", style: const TextStyle(color: Colors.orange, fontSize: 18, fontWeight: FontWeight.bold)),
          Text(_latestEarthquake!.region, style: const TextStyle(color: Colors.white, fontSize: 14)),
          Text("${_latestEarthquake!.date} ${_latestEarthquake!.time}", style: const TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }
}
