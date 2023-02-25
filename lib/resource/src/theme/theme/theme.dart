import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uber_eats/resource/resources.dart';
import 'package:uber_eats/resource/src/colors/colors.dart';

import 'text_theme.dart';

abstract class AppTheme {
  static ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF6200EE),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFF2E9FF),
    onSecondary: Color(0xFF000000),
    error: Color(0xFFFF5367),
    onError: Color(0xFFFFFFFF),
    background: Color(0xFFFFFFFF),
    onBackground: Color(0xFF05132E),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF6200EE),
    surfaceVariant: Color(0xFF97A8BE),
    onSurfaceVariant: Color(0xFF2D3748),
    outline: Color(0xFFEBF0FF),
    tertiary: Color(0xFF454F5A),
  );

  static ColorScheme darkColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF6200EE),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFF2E9FF),
    onSecondary: Color(0xFF000000),
    error: Color(0xFFFF5367),
    onError: Color(0xFFFFFFFF),
    background: Color(0xFFFFFFFF),
    onBackground: Color(0xFF05132E),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF6200EE),
    surfaceVariant: Color(0xFF97A8BE),
    onSurfaceVariant: Color(0xFF2D3748),
    outline: Color(0xFFEBF0FF),
    tertiary: Color(0xFF454F5A),

    /*brightness: Brightness.dark,
    primary: Color(0xFF7F39FB),
    onPrimary: Color(0xFF000000),
    secondary: Color(0xFF000000),
    onSecondary: Color(0xFFFFFFFF),
    error: Color(0xFFFF5367),
    onError: Color(0xFF000000),
    background: Color(0xFF000000),
    onBackground: Color(0xFF6200EE),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF7F39FB),
    surfaceVariant: Color(0xFFE5E5E5),
    onSurfaceVariant: Color(0xFFFFFFFF),
    outline: Color(0xFF6200EE),*/
  );

  static ThemeData getTheme(ColorScheme colorScheme) {
    return ThemeData(
      primaryColor: colorScheme.primary,
      primaryColorDark: colorScheme.primary,
      primaryColorLight: colorScheme.primary,
      colorScheme: colorScheme,
      useMaterial3: true,
      fontFamily: kFontFamily,
      scaffoldBackgroundColor: colorScheme.background,
      pageTransitionsTheme: const PageTransitionsTheme(builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      }),
      inputDecorationTheme: _getInputDecorationTheme(colorScheme),
      typography: AppTextTheme.getTypography(lightColorScheme: lightColorScheme, darkColorScheme: darkColorScheme),
      bottomAppBarTheme: getBottomAppBarTheme(colorScheme),
      popupMenuTheme: _getPopupMenuButtonTheme(colorScheme),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
          primary: colorScheme.primary,
          textStyle:
              const TextStyle(fontWeight: FontWeight.w700, fontFamily: kFontFamily, fontSize: 14, letterSpacing: 0),
          side: BorderSide(color: colorScheme.primary, width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      elevatedButtonTheme: _getElevatedButtonTheme(colorScheme),
      dividerTheme: dividerTheme(colorScheme),
      appBarTheme: getAppBarTheme(colorScheme),
      chipTheme: getChipTheme(colorScheme),
      tabBarTheme: getTabBarTheme(colorScheme),
      iconTheme: getIconTheme(colorScheme),
      // textButtonTheme: TextButtonThemeData(style: textButtonStyle),
      cardTheme: getCardTheme(colorScheme),
      dialogTheme: getDialogTheme(colorScheme),
      radioTheme: getRadioTheme(colorScheme),
      checkboxTheme: getCheckboxTheme(colorScheme),
      // dividerColor: AppColor.beige,
      listTileTheme: getListTileTheme(colorScheme),
      bottomSheetTheme: _getBottomSheetTheme(colorScheme),
    );
  }

  static BottomSheetThemeData _getBottomSheetTheme(ColorScheme colorScheme) {
    return BottomSheetThemeData(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      backgroundColor: colorScheme.background,
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      modalElevation: 8,
      modalBackgroundColor: colorScheme.background,
    );
  }

  static PopupMenuThemeData _getPopupMenuButtonTheme(ColorScheme colorScheme) {
    return PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 8,
        color: colorScheme.surface);
  }

  static InputDecorationTheme _getInputDecorationTheme(ColorScheme colorScheme) {
    final primaryBorder = BorderSide(color: colorScheme.primary);
    final errorBorder = BorderSide(color: colorScheme.error);
    final inactiveBorder = BorderSide(color: colorScheme.surfaceVariant);
    final border =
        OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(12)), borderSide: inactiveBorder);
    return InputDecorationTheme(
      hintStyle: TextStyle(
          color: colorScheme.onSurfaceVariant, fontSize: 14, fontFamily: kFontFamily, fontWeight: FontWeight.w400),
      fillColor: colorScheme.surface,
      filled: true,
      contentPadding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      errorStyle: const TextStyle(fontSize: 12, fontFamily: kFontFamily, fontWeight: FontWeight.w500),
      border: border,
      disabledBorder: border,
      enabledBorder: border,
      errorBorder: border.copyWith(borderSide: errorBorder),
      focusedBorder: border.copyWith(borderSide: primaryBorder),
      focusedErrorBorder: border.copyWith(borderSide: errorBorder),
    );
  }

  // Light Theme
  static ThemeData get lightTheme {
    return getTheme(lightColorScheme);
  }

  static AppBarTheme getAppBarTheme(ColorScheme colorScheme) {
    var inverseBrightness = colorScheme.brightness == Brightness.light ? Brightness.dark : Brightness.light;
    return AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: colorScheme.brightness,
        statusBarIconBrightness: inverseBrightness,
      ),
      centerTitle: false,
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.background,
      surfaceTintColor: colorScheme.background,
      elevation: 0,
      titleSpacing: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontFamily: kFontFamily,
        fontWeight: FontWeight.w600,
        color: colorScheme.background,
      ),
      shadowColor: Colors.transparent,
    );
  }

  static ElevatedButtonThemeData _getElevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle:
            const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, fontFamily: kFontFamily, letterSpacing: 0),
        shadowColor: colorScheme.primary.withOpacity(0.15),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: const Size.fromHeight(40),
      ).copyWith(
        backgroundColor: AppButtonBackgroundColor(colorScheme.primary),
        foregroundColor: AppButtonBackgroundColor(colorScheme.onPrimary),
      ),
    );
  }

  static ButtonStyle secondaryButtonStyle(ColorScheme colorScheme) {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: kFontFamily),
      shadowColor: AppColor.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ).copyWith(
      backgroundColor: AppButtonBackgroundColor(colorScheme.primaryContainer),
      foregroundColor: MaterialStateProperty.all(colorScheme.onPrimaryContainer),
    );
  }

  static ButtonStyle getErrorButtonStyle(ColorScheme colorScheme) {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: kFontFamily),
      shadowColor: AppColor.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ).copyWith(
      backgroundColor: AppButtonBackgroundColor(colorScheme.errorContainer),
      foregroundColor: MaterialStateProperty.all(colorScheme.onErrorContainer),
    );
  }

  static ButtonStyle getTertiaryButtonStyle(ColorScheme colorScheme) {
    return ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: kFontFamily),
      shadowColor: AppColor.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ).copyWith(
      backgroundColor: AppButtonBackgroundColor(Colors.transparent),
      foregroundColor: MaterialStateProperty.all(colorScheme.primary),
    );
  }

  static ButtonStyle getTextButtonStyle(ColorScheme colorScheme) {
    return TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: kFontFamily),
      shadowColor: AppColor.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  static IconThemeData getIconTheme(ColorScheme colorScheme) {
    return IconThemeData(color: colorScheme.primary);
  }

  static ChipThemeData getChipTheme(ColorScheme colorScheme) {
    return ChipThemeData(
      elevation: 0,
      pressElevation: 4,
      selectedColor: colorScheme.primary,
      backgroundColor: Colors.transparent,
      disabledColor: AppColor.transparent,
      secondarySelectedColor: colorScheme.primary,
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        fontFamily: kFontFamily,
        color: colorScheme.onTertiary,
      ),
      secondaryLabelStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        fontFamily: kFontFamily,
        color: colorScheme.onPrimary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: colorScheme.surfaceVariant, width: 1.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  static TabBarTheme getTabBarTheme(ColorScheme colorScheme) {
    return TabBarTheme(
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: kFontFamily),
      unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: kFontFamily),
      labelColor: colorScheme.onPrimary,
      unselectedLabelColor: colorScheme.onBackground,
      indicator: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: const [BoxShadow(color: AppColor.textPrimaryLight, offset: Offset(0, 1))],
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  static DialogTheme getDialogTheme(ColorScheme colorScheme) {
    return DialogTheme(
      backgroundColor: colorScheme.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: colorScheme.onBackground,
        fontFamily: kFontFamily,
      ),
      contentTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: colorScheme.surfaceVariant,
        fontFamily: kFontFamily,
      ),
    );
  }

  static CardTheme getCardTheme(ColorScheme colorScheme) {
    return CardTheme(
      color: colorScheme.background,
      elevation: 4,
      shadowColor: AppColor.textPrimaryLight.withAlpha(50),
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: AppColor.textPrimaryLight),
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
    );
  }

  static DividerThemeData dividerTheme(ColorScheme colorScheme) {
    return DividerThemeData(color: colorScheme.outline, thickness: 1, space: 1);
  }

  static RadioThemeData getRadioTheme(ColorScheme colorScheme) {
    return RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return colorScheme.primary;
        }
        return colorScheme.onSurfaceVariant;
      }),
    );
  }

  static CheckboxThemeData getCheckboxTheme(ColorScheme colorScheme) {
    return CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return colorScheme.primary;
        }
        return colorScheme.surfaceVariant;
      }),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }

  static BottomAppBarTheme getBottomAppBarTheme(ColorScheme colorScheme) =>
      const BottomAppBarTheme(color: AppColor.transparent, elevation: 0);

  // Dark Theme
  static ThemeData get darkTheme {
    return getTheme(darkColorScheme);
  }

  static ListTileThemeData getListTileTheme(ColorScheme colorScheme) => ListTileThemeData(
      selectedColor: colorScheme.primary, selectedTileColor: colorScheme.primary, textColor: colorScheme.onBackground);
}

class AppButtonBackgroundColor extends MaterialStateProperty<Color> {
  final Color primary;

  AppButtonBackgroundColor(this.primary);

  @override
  Color resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return AppColor.textPrimaryLight;
    }
    return primary;
  }
}
