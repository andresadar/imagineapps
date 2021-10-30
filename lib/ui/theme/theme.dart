import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class MyTheme {
  static final themeLight = ThemeData(
    primarySwatch: Colors.grey,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.grey),
      systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
      backgroundColor: Colors.white,
      elevation: .5,
      toolbarHeight: kToolbarHeight * .85,
    ),
    inputDecorationTheme: const InputDecorationTheme(
        filled: true,
        fillColor: Colors.transparent,
        border: InputBorder.none,
        focusColor: Colors.grey),
  );
}
