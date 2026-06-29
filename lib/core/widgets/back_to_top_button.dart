import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Floating back-to-top button (bottom-right) visible after scrolling.
class BackToTopButton extends StatelessWidget {
  const BackToTopButton({
    super.key,
    required this.onPressed,
    required this.visible,
  });

  final VoidCallback onPressed;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 280),
      child: AnimatedScale(
        scale: visible ? 1.0 : 0.75,
        duration: const Duration(milliseconds: 280),
        child: GestureDetector(
          onTap: onPressed,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(23),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.violet.withOpacity(0.45),
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.keyboard_arrow_up_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
