import 'package:flutter/material.dart';
import 'package:folheando/providers/theme_provider.dart';
import 'package:folheando/screens/home_screen/home_screen.dart';
import 'package:folheando/core/themes/app_themes.dart';
import 'package:provider/provider.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'App_Folheando',
          debugShowCheckedModeBanner: false,          
          themeMode: themeProvider.themeMode,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          
          home: const HomeScreen(),
        );
      },
    );
  }
}