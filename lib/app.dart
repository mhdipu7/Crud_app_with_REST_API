import 'package:flutter/material.dart';
import 'product_view_screen.dart';
import 'style.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductViewScreen(),
      debugShowCheckedModeBanner: false,
      theme: buildLightThemeData(),
      darkTheme: buildDarkThemeData(),
      themeMode: ThemeMode.system,
    );
  }
}
