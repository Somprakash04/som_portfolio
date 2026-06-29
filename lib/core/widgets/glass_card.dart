import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

/// ─────────────────────────────────────────────────────────────
/// GlassCard — frosted-glass card with optional hover lift.
/// ─────────────────────────────────────────────────────────────
class GlassCard extends StatefulWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.onTap,
    this.width,
    this.height,
    this.blur = 12.0,
    this.bgOpacity = 0.05,
    this.enableHover = true,
    this.accentColor,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final double blur;
  final double bgOpacity;
  final bool enableHover;
  final Color? accentColor;

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = widget.borderRadius ??
        BorderRadius.circular(AppSpacing.radiusLg);
    final accent = widget.accentColor ?? AppColors.violet;

    return MouseRegion(
      onEnter: (_) {
        if (widget.enableHover) setState(() => _hovered = true);
      },
      onExit: (_) {
        if (widget.enableHover) setState(() => _hovered = false);
      },
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : MouseCursor.defer,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: widget.width,
          height: widget.height,
          transform: _hovered
              ? (Matrix4.identity()..translate(0.0, -3.0))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: _hovered
                  ? accent.withValues(alpha: 0.3)
                  : (isDark
                      ? Colors.white.withValues(alpha: .08)
                      : Colors.black.withValues(alpha: .07)),
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: accent.withValues(alpha: 0.12),
                      blurRadius: 28,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: ClipRRect(
            borderRadius: radius,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: widget.blur, sigmaY: widget.blur),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: widget.padding ??
                    const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white
                          .withValues(alpha: _hovered ? 0.07 : widget.bgOpacity)
                      : Colors.white
                          .withValues(alpha: _hovered ? 0.95 : 0.88),
                  borderRadius: radius,
                ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
