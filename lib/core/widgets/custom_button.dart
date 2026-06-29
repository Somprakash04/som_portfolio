import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

/// Button variants available in the design system.
enum BtnVariant { primary, secondary, ghost, outline }

/// ─────────────────────────────────────────────────────────────
/// CustomButton — hover-aware button with multiple variants.
/// ─────────────────────────────────────────────────────────────
class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.trailingIcon,
    this.variant = BtnVariant.primary,
    this.fullWidth = false,
    this.isLoading = false,
    this.small = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final IconData? trailingIcon;
  final BtnVariant variant;
  final bool fullWidth;
  final bool isLoading;
  final bool small;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final vPad = widget.small ? 9.0 : 13.0;
    final hPad = widget.small ? 16.0 : 24.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: widget.fullWidth ? double.infinity : null,
          padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
          decoration: _decoration(isDark),
          child: Row(
            mainAxisSize:
                widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.isLoading)
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: _fgColor(isDark),
                  ),
                )
              else ...[
                if (widget.icon != null) ...[
                  Icon(widget.icon, size: 15, color: _fgColor(isDark)),
                  const SizedBox(width: 7),
                ],
                Text(
                  widget.label,
                  style: AppTypography.button.copyWith(
                    fontSize: widget.small ? 12 : 14,
                    color: _fgColor(isDark),
                  ),
                ),
                if (widget.trailingIcon != null) ...[
                  const SizedBox(width: 7),
                  AnimatedSlide(
                    duration: const Duration(milliseconds: 180),
                    offset: _hovered
                        ? const Offset(0.25, 0)
                        : Offset.zero,
                    child: Icon(widget.trailingIcon,
                        size: 15, color: _fgColor(isDark)),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _decoration(bool isDark) {
    switch (widget.variant) {
      case BtnVariant.primary:
        return BoxDecoration(
          gradient: LinearGradient(
            colors: _hovered
                ? [AppColors.violetDark, AppColors.violet]
                : [AppColors.violet, AppColors.violetDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          boxShadow: [
            BoxShadow(
              color: AppColors.violet
                  .withOpacity(_hovered ? 0.45 : 0.22),
              blurRadius: _hovered ? 22 : 12,
              offset: const Offset(0, 4),
            ),
          ],
        );

      case BtnVariant.secondary:
        return BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(_hovered ? 0.12 : 0.07)
              : Colors.black.withOpacity(_hovered ? 0.09 : 0.05),
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.12)
                : Colors.black.withOpacity(0.1),
          ),
        );

      case BtnVariant.ghost:
        return BoxDecoration(
          color: _hovered
              ? (isDark
                  ? Colors.white.withOpacity(0.07)
                  : Colors.black.withOpacity(0.04))
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        );

      case BtnVariant.outline:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          border: Border.all(
            color: _hovered
                ? AppColors.violet
                : (isDark
                    ? AppColors.darkBorder
                    : AppColors.lightBorder),
            width: 1.5,
          ),
        );
    }
  }

  Color _fgColor(bool isDark) {
    switch (widget.variant) {
      case BtnVariant.primary:
        return Colors.white;
      case BtnVariant.secondary:
      case BtnVariant.ghost:
      case BtnVariant.outline:
        return isDark
            ? AppColors.darkTextPrimary
            : AppColors.lightTextPrimary;
    }
  }
}
