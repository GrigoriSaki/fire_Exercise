import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: Colors.greenAccent.shade100,
        primary: Colors.greenAccent.shade200,
        secondary: Colors.greenAccent.shade400,
        inversePrimary: Colors.black),
    textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.black, displayColor: Colors.greenAccent.shade700));
