import 'package:flutter/material.dart';
import '../../core/routes.dart';
import '../../feature/emergency/presentation/emergency_modal.dart';

class MainBottomNav extends StatelessWidget {
  final String currentRoute;

  const MainBottomNav({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
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
              icon: Icon(
                Icons.home_outlined,
                color: currentRoute == AppRoutes.dashboard ? const Color(0xFF667EEA) : Colors.white,
              ),
              onPressed: () {
                if (currentRoute != AppRoutes.dashboard) {
                  Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
                }
              },
            ),
            IconButton(
              icon: Icon(
                Icons.map_outlined,
                color: currentRoute == AppRoutes.map ? const Color(0xFF667EEA) : Colors.white,
              ),
              onPressed: () {
                if (currentRoute != AppRoutes.map) {
                  Navigator.pushReplacementNamed(context, AppRoutes.map);
                }
              },
            ),
            const SizedBox(width: 40),
            IconButton(
              icon: Icon(
                Icons.chat_bubble_outline,
                color: currentRoute == AppRoutes.chat ? const Color(0xFF667EEA) : Colors.white,
              ),
              onPressed: () {
                if (currentRoute != AppRoutes.chat) {
                  Navigator.pushReplacementNamed(context, AppRoutes.chat);
                }
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person_outlined,
                color: currentRoute == AppRoutes.profile ? const Color(0xFF667EEA) : Colors.white,
              ),
              onPressed: () {
                if (currentRoute != AppRoutes.profile) {
                  Navigator.pushReplacementNamed(context, AppRoutes.profile);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SosFloatingButton extends StatelessWidget {
  const SosFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          onTap: () => EmergencyModal.show(context),
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
    );
  }
}
