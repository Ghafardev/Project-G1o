import 'package:flutter/material.dart';
import '../core/widgets/coming_soon_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComingSoonWidget(
      title: 'Peta Jalur Evakuasi',
      icon: Icons.map_outlined,
      message: 'Fitur peta evakuasi sedang dalam pengembangan',
    );
  }
}

class LogsScreen extends StatelessWidget {
  const LogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComingSoonWidget(
      title: 'Log Kejadian',
      icon: Icons.history,
      message: 'Fitur pencatatan kejadian akan segera tersedia',
    );
  }
}

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComingSoonWidget(
      title: 'Kontak Darurat',
      icon: Icons.contacts,
      message: 'Manajemen kontak darurat sedang dalam pengembangan',
    );
  }
}

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComingSoonWidget(
      title: 'Info Cuaca',
      icon: Icons.cloud,
      message: 'Fitur informasi cuaca akan segera tersedia',
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComingSoonWidget(
      title: 'Pengaturan',
      icon: Icons.settings,
      message: 'Pengaturan aplikasi sedang dalam pengembangan',
    );
  }
}
