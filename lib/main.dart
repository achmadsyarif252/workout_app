import 'package:flutter/material.dart';
import '../screens/OnBoarding_screen.dart';

void main() {
  runApp(
    new MaterialApp(
      home: OnboardingScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: Color(0xFF192A56),
        ),
      ),
      
    ),
  );
}
