import 'dart:ui';
import 'package:flutter/material.dart';

class GlassMenuCard extends StatefulWidget {
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
  State<GlassMenuCard> createState() => _GlassMenuCardState();
}

class _GlassMenuCardState extends State<GlassMenuCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  static final ImageFilter _blurFilter = ImageFilter.blur(sigmaX: 15, sigmaY: 15);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    _animationController.reverse();
    widget.onTap?.call();
  }

  void _handleTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Semantics(
              button: true,
              label: '${widget.title} - ${widget.subtitle ?? ""}',
              hint: widget.isAction ? 'Tap to navigate' : 'Tap to select',
              child: GestureDetector(
                onTapDown: _handleTapDown,
                onTapUp: _handleTapUp,
                onTapCancel: _handleTapCancel,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: _blurFilter,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          widget.colors.first.withValues(alpha: 0.15),
                          widget.colors.last.withValues(alpha:0.25),
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
                        if (widget.icon != null) ...[
                          Icon(
                            widget.icon,
                            color: Colors.white,
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                        ],
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (widget.subtitle != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            widget.subtitle!,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        if (widget.isAction) ...[
                          const SizedBox(height: 8),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white70,
                            size: 12,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}