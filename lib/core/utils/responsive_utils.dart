import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// ─────────────────────────────────────────────────────────────
/// R — responsive utility namespace.
/// Usage:  R.isMobile(context)  |  R.responsive(context, ...)
/// ─────────────────────────────────────────────────────────────
abstract class R {
  static bool isMobile(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isMobile;

  static bool isTablet(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isTablet;

  static bool isDesktop(BuildContext context) =>
      ResponsiveBreakpoints.of(context).isDesktop;

  static bool isWide(BuildContext context) =>
      ResponsiveBreakpoints.of(context).largerThan(DESKTOP);

  /// Returns the appropriate value for the current breakpoint.
  static T responsive<T>(
      BuildContext context, {
        required T mobile,
        T? tablet,
        T? desktop,
        T? wide,
      }) {
    if (isWide(context)) return wide ?? desktop ?? tablet ?? mobile;
    if (isDesktop(context)) return desktop ?? tablet ?? mobile;
    if (isTablet(context)) return tablet ?? mobile;
    return mobile;
  }

  /// Horizontal page padding that scales with screen width.
  static double hPad(BuildContext context) =>
      responsive(context, mobile: 20, tablet: 40, desktop: 80, wide: 120);

  /// Vertical section padding.
  static double vPad(BuildContext context) =>
      responsive(context, mobile: 64, tablet: 80, desktop: 100, wide: 120);

  /// Returns full section padding as EdgeInsets.
  static EdgeInsets sectionPadding(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: hPad(context), vertical: vPad(context));

  /// Centers and constrains content to [maxWidth].
  ///
  /// Uses [SizedBox.expand] on the inner axis so that nested Columns
  /// always receive TIGHT width constraints instead of loose ones.
  /// Without this, Center → ConstrainedBox passes minWidth=0 downward,
  /// which causes LayoutBuilder children to compute negative card widths.
  static Widget constrained(Widget child, {double maxWidth = 1200}) => Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth),
      // Force full available width so nested Columns can't collapse to 0.
      child: SizedBox(width: double.infinity, child: child),
    ),
  );

  /// Responsive font size helper.
  static double fontSize(
      BuildContext context, {
        required double mobile,
        double? tablet,
        double? desktop,
      }) =>
      responsive(
        context,
        mobile: mobile,
        tablet: tablet ?? mobile * 1.15,
        desktop: desktop ?? mobile * 1.3,
      );

  /// Number of grid columns for the current breakpoint.
  static int gridColumns(BuildContext context, {int mobile = 1, int tablet = 2, int desktop = 3}) =>
      responsive(context, mobile: mobile, tablet: tablet, desktop: desktop);
}