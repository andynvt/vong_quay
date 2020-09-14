import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import '../module.dart';

class VongQuayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics();

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
