import 'package:flutter/material.dart';

Color appBackgroundColor = Colors.white;

ThemeData buildDarkThemeData() {
  return ThemeData(
      scaffoldBackgroundColor: appBackgroundColor,
      brightness: Brightness.dark,
      appBarTheme: buildAppBarThemeData(),
      inputDecorationTheme: buildInputDecorationThemeData(),
      elevatedButtonTheme: BuildElevatedButtonThemeData(),
      floatingActionButtonTheme: buildFloatingActionButtonThemeData(),
      iconTheme: buildIconThemeData(),
      listTileTheme: buildListTileThemeData(),
      dialogBackgroundColor: Colors.deepPurple.shade100,
      dialogTheme: buildDialogThemeData(),
      textButtonTheme: buildTextButtonThemeData());
}

TextButtonThemeData buildTextButtonThemeData() {
  return TextButtonThemeData(
        style: TextButton.styleFrom(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ));
}

ThemeData buildLightThemeData() {
  return ThemeData(
      scaffoldBackgroundColor: appBackgroundColor,
      brightness: Brightness.light,
      appBarTheme: buildAppBarThemeData(),
      inputDecorationTheme: buildInputDecorationThemeData(),
      elevatedButtonTheme: BuildElevatedButtonThemeData(),
      floatingActionButtonTheme: buildFloatingActionButtonThemeData(),
      iconTheme: buildIconThemeData(),
      listTileTheme: buildListTileThemeData(),
      dialogBackgroundColor: Colors.deepPurple.shade100,
      dialogTheme: buildDialogThemeData(),
      textButtonTheme: buildTextButtonThemeData());
}

ListTileThemeData buildListTileThemeData() {
  return ListTileThemeData(
    tileColor: Colors.deepPurple.shade100,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.deepPurple,
    ),
    subtitleTextStyle: TextStyle(
      color: Colors.deepPurple,
      fontWeight: FontWeight.w500,
    ),
  );
}

IconThemeData buildIconThemeData() {
  return IconThemeData(size: 30);
}

FloatingActionButtonThemeData buildFloatingActionButtonThemeData() {
  return FloatingActionButtonThemeData(
    backgroundColor: Colors.deepPurple,
    foregroundColor: Colors.white,
    iconSize: 40,
  );
}

ElevatedButtonThemeData BuildElevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.deepPurple,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      fixedSize: Size.fromWidth(double.maxFinite),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );
}

InputDecorationTheme buildInputDecorationThemeData() {
  return InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.deepPurple,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.deepPurple,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

AppBarTheme buildAppBarThemeData() {
  return AppBarTheme(
    backgroundColor: Colors.deepPurple,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
    ),
    centerTitle: true,
    iconTheme: IconThemeData(
      color: Colors.white,
      size: 35,
    ),
  );
}

DialogTheme buildDialogThemeData() {
  return DialogTheme(
    titleTextStyle: TextStyle(
      color: Colors.deepPurple,
      fontWeight: FontWeight.bold,
      fontSize: 25,
    ),
    contentTextStyle: TextStyle(
      color: Colors.deepPurple,
      fontWeight: FontWeight.bold,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  );
}
