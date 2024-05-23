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
    style: FilledButton.styleFrom(
      backgroundColor: AppColor.azul,
      foregroundColor: AppColor.branco,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),

  /*
ElevatedButton
 */
  elevatedButtonTheme: ElevatedButtonThemeData(
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
  /*
TextTheme
 */
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 64,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(fontSize: 22, fontStyle: FontStyle.italic),
    bodyMedium: TextStyle(fontSize: 18),
    displaySmall: TextStyle(fontSize: 16),
  ),
);
