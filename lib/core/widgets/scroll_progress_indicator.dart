import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Thin gradient bar at the very top of the screen showing scroll progress.
class ScrollProgressBar extends StatelessWidget {
  const ScrollProgressBar({super.key, required this.progress});

  /// 0.0 – 1.0
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: FractionallySizedBox(
        widthFactor: progress.clamp(0.0, 1.0),
        alignment: Alignment.centerLeft,
        child: Container(
          height: 2.5,
          decoration: const BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
        ),
      ),
    );
  }
}
