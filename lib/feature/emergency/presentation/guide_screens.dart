import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/widgets/detail_page_template.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  Future<List<dynamic>> _loadGuides() async {
    final String response = await rootBundle.loadString('lib/assets/data/emergency_guides.json');
    return json.decode(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Panduan Darurat", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: _loadGuides(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final guides = snapshot.data as List<dynamic>;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: guides.length,
            itemBuilder: (context, index) {
              final guide = guides[index];
              final icon = _getIconForCategory(guide['category']);
              final color = _getColorForCategory(guide['category']);
              return Card(
                color: Theme.of(context).cardColor,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: color),
                  ),
                  title: Text(guide['title'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  subtitle: Text(guide['category'], style: TextStyle(color: color)),
                  trailing: const Icon(Icons.chevron_right, color: Colors.white54),
                  onTap: () => _showDetail(context, guide),
                ),
              );
            },
          );
        },
      ),
    );
  }

  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'banjir':
        return Icons.waves_outlined;
      case 'gempa':
        return Icons.landscape_outlined;
      case 'kebakaran':
        return Icons.local_fire_department_outlined;
      case 'p3k':
        return Icons.medical_services_outlined;
      default:
        return Icons.info_outline;
    }
  }

  Color _getColorForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'banjir':
        return const Color(0xFF2196F3);
      case 'gempa':
        return const Color(0xFFFF9800);
      case 'kebakaran':
        return const Color(0xFFF44336);
      case 'p3k':
        return const Color(0xFFE91E63);
      default:
        return const Color(0xFF667EEA);
    }
  }

  void _showDetail(BuildContext context, dynamic guide) {
    final icon = _getIconForCategory(guide['category']);
    final color = _getColorForCategory(guide['category']);
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPageTemplate(
          title: guide['title'],
          subtitle: guide['category'],
          icon: icon,
          iconColor: color,
          content: [
            Text(
              guide['content'],
              style: const TextStyle(color: Colors.white70, fontSize: 16, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }
}