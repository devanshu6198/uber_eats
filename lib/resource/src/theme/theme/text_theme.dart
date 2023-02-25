import 'package:flutter/material.dart';
import 'package:uber_eats/resource/resources.dart';

abstract class AppTextTheme {
  static const TextStyle _displayLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    fontFamily: kFontFamily,
    letterSpacing: 0,
  );
  static const TextStyle _displayMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    fontFamily: kFontFamily,
    letterSpacing: 0,
  );
  static const TextStyle _displaySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    fontFamily: kFontFamily,
  );

  static const TextStyle _headlineLarge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontFamily: kFontFamily,
  );
  static const TextStyle _headlineMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: kFontFamily,
  );
  static const TextStyle _headlineSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    fontFamily: kFontFamily,
  );

  static const TextStyle _titleLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: kFontFamily,
  );
  static const TextStyle _titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    fontFamily: kFontFamily,
  );
  static const TextStyle _titleSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    fontFamily: kFontFamily,
  );

  static const TextStyle _labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: kFontFamily,
    letterSpacing: 0,
  );
  static const TextStyle _labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    fontFamily: kFontFamily,
  );
  static const TextStyle _labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    fontFamily: kFontFamily,
  );

  static const TextStyle _bodyLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    fontFamily: kFontFamily,
  );
  static const TextStyle _bodyMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: kFontFamily,
  );
  static const TextStyle _bodySmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    fontFamily: kFontFamily,
  );

  static TextTheme getTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: AppTextTheme._displayLarge.copyWith(color: colorScheme.onBackground),
      displayMedium: AppTextTheme._displayMedium.copyWith(color: colorScheme.onBackground),
      displaySmall: AppTextTheme._displaySmall.copyWith(color: colorScheme.onBackground),
      headlineLarge: AppTextTheme._headlineLarge.copyWith(color: colorScheme.onBackground),
      headlineMedium: AppTextTheme._headlineMedium.copyWith(color: colorScheme.onBackground),
      headlineSmall: AppTextTheme._headlineSmall.copyWith(color: colorScheme.onSurface),
      titleLarge: AppTextTheme._titleLarge.copyWith(color: colorScheme.onSurfaceVariant),
      titleMedium: AppTextTheme._titleMedium.copyWith(color: colorScheme.onBackground),
      titleSmall: AppTextTheme._titleSmall.copyWith(color: colorScheme.onBackground),
      labelLarge: AppTextTheme._labelLarge.copyWith(color: colorScheme.onBackground),
      labelMedium: AppTextTheme._labelMedium.copyWith(color: colorScheme.onBackground),
      labelSmall: AppTextTheme._labelSmall.copyWith(color: colorScheme.onSurfaceVariant),
      bodyLarge: AppTextTheme._bodyLarge.copyWith(color: colorScheme.onSurfaceVariant),
      bodyMedium: AppTextTheme._bodyMedium.copyWith(color: colorScheme.onSurfaceVariant),
      bodySmall: AppTextTheme._bodySmall.copyWith(color: colorScheme.onSurfaceVariant),
    );
  }

  static Typography getTypography({required ColorScheme lightColorScheme, required ColorScheme darkColorScheme}) {
    return Typography(
      black: getTextTheme(lightColorScheme),
      white: getTextTheme(darkColorScheme),
    );
  }
}
