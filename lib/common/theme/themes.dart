import 'package:flutter/material.dart';

import 'app_palatte.dart';

class AppTheme {
  static _border({Color color = AppPalette.borderColor}) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        width: 0.85,
        color: color,
      ));

  static BoxDecoration borderDecoration = BoxDecoration(
      color: AppPalette.fillColor,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: AppPalette.borderColor,
        width: 0.85,
      ));
  static final theme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: AppPalette.appColor),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppPalette.fillColor,
      enabledBorder: _border(),
      focusedBorder: _border(color: AppPalette.appColor),
      errorBorder: _border(color: AppPalette.errorColor),
      focusedErrorBorder: _border(color: AppPalette.errorColor),
    ),
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'Poppins',
        ),
  );
}
