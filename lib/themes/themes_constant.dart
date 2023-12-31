import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  primaryColor: Color.fromARGB(234, 235, 105, 45),
  primaryTextTheme: TextTheme(
      titleLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      bodyLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87.withOpacity(0.8)),
      bodyMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.black87.withOpacity(0.8)),
      bodySmall: TextStyle(
          fontSize: 10, fontWeight: FontWeight.w600, color: Colors.black54)),
  useMaterial3: true,
);
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  backgroundColor: Colors.black54,
  primaryColor: Color.fromARGB(234, 235, 105, 45),
  primaryTextTheme: TextTheme(
      titleLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white70.withOpacity(0.8)),
      bodyMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.white70.withOpacity(0.8)),
      bodySmall: TextStyle(
          fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white60)),
  useMaterial3: true,
);
