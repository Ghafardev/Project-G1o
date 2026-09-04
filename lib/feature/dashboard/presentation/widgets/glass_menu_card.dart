import 'dart:ui';
import 'package:flutter/material.dart';

class GlassMenuCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Color> colors;
  final bool isAction;
  final VoidCallback? onTap;

  const GlassMenuCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.colors,
    this.isAction = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary( // Optimasi GPU untuk efek blur
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colors.first.withValues(alpha: 0.15),
                    colors.last.withValues(alpha: 0.25),
                  ],
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    title, 
                    style: const TextStyle(
                      color: Colors.white, 
                      fontSize: 14, 
                      fontWeight: FontWeight.bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        color: Colors.white70, 
                        fontSize: 10
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  if (isAction) ...[
                    const SizedBox(height: 8),
                    const Icon(
                      Icons.arrow_forward_ios, 
                      color: Colors.white70, 
                      size: 12
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}