import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: Colors.grey[50],
    
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.purple,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.white70),
      titleTextStyle: TextStyle(
        color: Colors.white70,
        fontSize: 26,
        fontWeight: FontWeight.bold,
        fontFamily: 'Merriweather',
      ),
    ),
    
 
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white70,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: const TextStyle(color: Colors.deepPurple),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.purple,
    scaffoldBackgroundColor: const Color(0xFF1A1A1A),
    
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: const Color(0xFF2D1B3D),
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.purple[100]),
      titleTextStyle: TextStyle(
        color: Colors.purple[100],
        fontSize: 26,
        fontWeight: FontWeight.bold,
        fontFamily: 'Merriweather',
      ),
    ),
    
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF2C2C2C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: TextStyle(color: Colors.deepPurple),
    ),
    
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.grey[300]),
      bodyMedium: TextStyle(color: Colors.grey[300]),
      titleLarge: const TextStyle(color: Colors.deepPurple),
      titleMedium: const TextStyle(color: Colors.deepPurple),
    ),
    
    iconTheme: IconThemeData(
      color: Colors.purple[200],
    ),
    
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF2C2C2C),
      modalBackgroundColor: Color(0xFF2C2C2C),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF2C2C2C),
    ),
  );
}