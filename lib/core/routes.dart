import 'package:flutter/material.dart';
import '../feature/dashboard/presentation/dashboard_screen.dart';
import '../feature/RagaBhumi_ai/presentation/chat_screen.dart';
import '../feature/map/presentation/map_page.dart';
import '../feature/profile/presentation/profile_page.dart';
import '../feature/emergency/presentation/guide_screens.dart';
import '../feature/placeholder_screens.dart';

class AppRoutes {
  static const String dashboard = '/';
  static const String chat = '/chat';
  static const String map = '/map';
  static const String profile = '/profile';
  static const String guide = '/guide';
  static const String logs = '/logs';
  static const String contacts = '/contacts';
  static const String weather = '/weather';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> get routes => {
        dashboard: (context) => const DashboardScreen(),
        chat: (context) => const ChatScreen(),
        map: (context) => const MapPage(),
        profile: (context) => const ProfilePage(),
        guide: (context) => const GuideScreen(),
        logs: (context) => const LogsScreen(),
        contacts: (context) => const ContactsScreen(),
        weather: (context) => const WeatherScreen(),
        settings: (context) => const SettingsScreen(),
      };
}