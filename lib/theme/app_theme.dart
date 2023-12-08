import 'package:contri/theme/pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData.light(useMaterial3: false).copyWith(
    inputDecorationTheme: const InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: Pallete.pinkLightColor)),
    colorScheme: const ColorScheme.light(primary: Pallete.pinkLightColor),
    scaffoldBackgroundColor: Pallete.greyBackgroundColor,

    // useMaterial3: false,
    appBarTheme: const AppBarTheme(
      // backgroundColor: Pallete.whiteColor,
      color: Pallete.pinkColor,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Pallete.pinkColor,
    ),
  );
}
