/// ─────────────────────────────────────────────────────────────
/// AppSpacing — 8-pt grid system used throughout the portfolio.
/// ─────────────────────────────────────────────────────────────
abstract class AppSpacing {
  // ── Base scale ─────────────────────────────────────────────
  static const double xs    = 4;
  static const double sm    = 8;
  static const double md    = 16;
  static const double lg    = 24;
  static const double xl    = 32;
  static const double xxl   = 48;
  static const double xxxl  = 64;
  static const double xxxxl = 96;

  // ── Section vertical padding ───────────────────────────────
  static const double sectionV    = 100.0;
  static const double sectionVMd  = 80.0;
  static const double sectionVSm  = 56.0;

  // ── Max content width ──────────────────────────────────────
  static const double maxContentWidth = 1200.0;
  static const double maxNavWidth     = 1300.0;

  // ── Navigation ─────────────────────────────────────────────
  static const double navHeight       = 72.0;
  static const double navHeightMobile = 60.0;

  // ── Border radii ───────────────────────────────────────────
  static const double radiusSm   = 8.0;
  static const double radiusMd   = 12.0;
  static const double radiusLg   = 16.0;
  static const double radiusXl   = 20.0;
  static const double radiusXxl  = 28.0;
  static const double radiusFull = 999.0;
}
