import 'package:flutter/material.dart';

/// Centralized color palette for the app.
/// Defines both light and dark theme colors.
class ColorManager {
  ColorManager._();

  // ===== Primary Colors =====
  static const Color primary = Color(0xFF00A86B);
  static const Color primaryLight = Color(0xFF334289);
  static const Color primaryDark = Color(0xFF008C5A);

  // ===== Background Colors =====
  static const Color background = Color(0xFFF5F5F5);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color scaffoldLight = Color(0xFFFFFFFF);
  static const Color scaffoldDark = Color(0xFF1E1E1E);
  static const Color darkSurface = Color(0xFF17211D);
  static const Color darkBackground = Color(0xFF101714);
  static const Color darkSurfaceVariant = Color(0xFF1D2A25);
  static const Color lightCardBorder = Color(0xFFE2E8F0);
  static const Color darkCardBorder = Color(0xFF3A4B43);

  static Color settingsCardBorder(Brightness brightness) =>
      brightness == Brightness.dark ? darkCardBorder : lightCardBorder;

  // ===== Text Colors =====
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color titleText = Color(0xFF2F3131);
  static const Color titleText1 = Color(0xFF535353);
  static const Color subtitleText = Color(0xFF686868);
  static const Color subtitleText1 = Color(0xFF60655C);
  static const Color mediumText = Color(0xFF363A33);

  // ===== Button & Label Colors =====
  static const Color buttonText = Color(0xFF334289);
  static const Color hintText = Color(0xFF5B5F5F);

  // ===== Neutral Colors =====
  static const Color blackColor = Color(0xFF000000);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color transparentColor = Colors.transparent;

  // ===== Border Colors =====
  static const Color borderColor = Color(0xFFDADADA);
  static const Color borderColor1 = Color(0xFF00136B);

  // ===== Container & Fill Colors =====
  static const Color containerColor = Color(0xFFEFEFEF);
  static const Color containerColor1 = Color(0xFFD9DDE2);
  static const Color fillColor = Color(0xFFFEF5F3);

  // ===== Feedback Colors =====
  static const Color errorColor = Color(0xFFE25839);
  static const Color successColor = Color(0xFF388E3C);
  static const Color warningColor = Color(0xFFFFA000);
  static const Color infoColor = Color(0xFF388E3C);

  // ===== Utility Colors =====
}
