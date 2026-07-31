import 'package:flutter/material.dart';
import 'package:ogrova_team/core/resource/constant/color_manager.dart';
import 'package:ogrova_team/core/resource/constant/font_manager.dart';
import 'package:ogrova_team/core/resource/constant/style_manager.dart';
import 'package:ogrova_team/core/resource/constant/values_manager.dart';


ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: false, // set true if using Material 3
    // ===== Main colors =====
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryLight,
    primaryColorDark: ColorManager.primaryDark,
    disabledColor: ColorManager.textSecondary,
    splashColor: ColorManager.primaryDark,
    scaffoldBackgroundColor: ColorManager.whiteColor,

    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: ColorManager.primaryDark,
      error: ColorManager.errorColor,
    ),

    // ===== Card Theme =====
    cardTheme: CardThemeData(
      color: ColorManager.whiteColor,
      shadowColor: ColorManager.subtitleText,
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: ColorManager.lightCardBorder),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),

    // ===== AppBar Theme =====
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: ColorManager.primary,
      elevation: AppSize.s4,
      iconTheme: IconThemeData(color: ColorManager.whiteColor),
      titleTextStyle: getSemiBoldStyle(
        color: ColorManager.whiteColor,
        fontSize: FontSize.s16,
      ),
    ),

    // ===== Button Theme =====
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.textSecondary,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.primaryDark,
    ),

    // ===== Elevated Button Theme =====
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        foregroundColor: ColorManager.whiteColor,
        textStyle: getRegularStyle(
          color: ColorManager.whiteColor,
          fontSize: FontSize.s16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p12,
        ),
      ),
    ),

    // ===== Text Theme =====
    textTheme: TextTheme(
      headlineLarge: getSemiBoldStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s20,
      ),
      titleMedium: getMediunStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s16,
      ),
      bodyMedium: getRegularStyle(
        color: ColorManager.blackColor,
        fontSize: FontSize.s14,
      ),
      bodySmall: getRegularStyle(
        color: ColorManager.subtitleText,
        fontSize: FontSize.s12,
      ),
      labelLarge: getSemiBoldStyle(
        color: ColorManager.primary,
        fontSize: FontSize.s14,
      ),
    ),

    // ===== Cursor & Selection Colors =====
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: ColorManager.primary,
      selectionColor: ColorManager.primary.withValues(alpha: 0.1),
      selectionHandleColor: ColorManager.primary,
    ),

    // ===== Input Field Theme =====
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorManager.whiteColor,
      hintStyle: getRegularStyle(color: ColorManager.textSecondary),
      labelStyle: getMediunStyle(color: ColorManager.blackColor),
      helperStyle: getRegularStyle(color: ColorManager.blackColor),
      errorStyle: getRegularStyle(color: ColorManager.errorColor),
      contentPadding: const EdgeInsets.all(AppPadding.p12),

      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.borderColor,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.borderColor1,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.errorColor,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ColorManager.errorColor,
          width: AppSize.s1_5,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),

    // ===== Icon Theme =====
    iconTheme: IconThemeData(color: ColorManager.primary, size: AppSize.s24),
  );
}

/// Dark palette used by every Material widget in the application.
ThemeData getDarkApplicationTheme() {
  const scheme = ColorScheme.dark(
    primary: ColorManager.primary,
    onPrimary: ColorManager.whiteColor,
    secondary: Color(0xFF6EE7B7),
    surface: Color(0xFF17211D),
    onSurface: Color(0xFFF1F5F9),
    error: ColorManager.errorColor,
    onError: ColorManager.whiteColor,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: scheme,
    scaffoldBackgroundColor: ColorManager.darkBackground,
    canvasColor: ColorManager.darkBackground,
    cardColor: scheme.surface,
    dividerColor: const Color(0xFF334155),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: Color(0xFFF1F5F9),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: scheme.surface,
      shadowColor: Colors.black54,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: ColorManager.darkCardBorder),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(color: Color(0xFFF1F5F9)),
      titleMedium: TextStyle(color: Color(0xFFF1F5F9)),
      bodyMedium: TextStyle(color: Color(0xFFF1F5F9)),
      bodySmall: TextStyle(color: Color(0xFFB6C4BD)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF1D2A25),
      hintStyle: const TextStyle(color: Color(0xFFB6C4BD)),
      labelStyle: const TextStyle(color: Color(0xFFF1F5F9)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF3A4B43)),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: ColorManager.primary),
        borderRadius: BorderRadius.circular(AppSize.s8),
      ),
    ),
    iconTheme: const IconThemeData(color: Color(0xFFF1F5F9)),
  );
}
