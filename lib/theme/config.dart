import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    fontFamily: "GoogleSans",
    colorScheme: ColorScheme.light(
        background: Colors.grey.shade200,
        tertiary: Colors.grey.shade300,
        primary: const Color(0xFFFFB700),
        secondary: Colors.white,
        onPrimary: Color(0xFF18181B),
        onSecondary: Colors.grey.shade800,
        onTertiary: Colors.grey.shade700));

ThemeData darkMode = ThemeData(
    fontFamily: "GoogleSans",
    colorScheme: ColorScheme.light(
        background: Color.fromARGB(255, 21, 21, 22),
        primary: const Color(0xFFFFB700),
        tertiary: Colors.grey.shade800,
        secondary: Colors.grey.shade900,
        onPrimary: Colors.grey.shade200,
        onSecondary: Colors.grey.shade300,
        onTertiary: Colors.grey.shade400));
