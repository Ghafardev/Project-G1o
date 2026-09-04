import 'package:flutter/material.dart';
import '../../core/routes.dart';

class BottomNavBar extends StatefulWidget {
  final String currentRoute;
  
  const BottomNavBar({
    super.key,
    required this.currentRoute,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _getCurrentIndex() {
    switch (widget.currentRoute) {
      case AppRoutes.dashboard:
        return 0;
      case AppRoutes.chat:
        return 1;
      case AppRoutes.guide:
        return 2;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index, BuildContext context) {
    String route;
    switch (index) {
      case 0:
        route = AppRoutes.dashboard;
        break;
      case 1:
        route = AppRoutes.chat;
        break;
      case 2:
        route = AppRoutes.guide;
        break;
      default:
        route = AppRoutes.dashboard;
    }
    
    if (route != widget.currentRoute) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.8),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _getCurrentIndex(),
        onTap: (index) => _onItemTapped(index, context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF667EEA),
        unselectedItemColor: Colors.white54,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            activeIcon: Icon(Icons.chat),
            label: 'RagaBhumi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_outlined),
            activeIcon: Icon(Icons.medical_services),
            label: 'P3K',
          ),
        ],
      ),
    );
  }
}
