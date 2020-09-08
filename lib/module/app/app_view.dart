import 'package:flutter/material.dart';
import '../module.dart';

class VongQuayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        cursorColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          helperStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.white),
          ),
          labelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      home: HomeView(),
    );
  }
}
