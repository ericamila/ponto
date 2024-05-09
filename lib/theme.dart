import 'package:flutter/material.dart';

import 'app_colors.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColor.azul),
  scaffoldBackgroundColor: AppColor.branco,
  useMaterial3: true,

/*
AppBar
 */
  appBarTheme: AppBarTheme(
    centerTitle: true,
    foregroundColor: AppColor.branco,
    backgroundColor: AppColor.azul,
  ),

  /*
TextButton
 */
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
        backgroundColor: AppColor.azul,
        foregroundColor: AppColor.branco,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        minimumSize: const Size(200, 100),
        maximumSize: const Size(200, 100),
        textStyle: const TextStyle(fontSize: 18)),
  ),
  /*
FilledButton
 */
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: AppColor.azul,
      foregroundColor: AppColor.branco,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);