import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: const Color(0xffF7EBE1),
    primary: const Color.fromARGB(209, 65, 64, 64),
    secondary: Colors.grey.shade100,
    tertiary: const Color.fromARGB(255, 3, 3, 3),
    inversePrimary: Colors.grey[800],
  )
);