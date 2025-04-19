import 'package:flutter/material.dart';
import 'package:placementcafe/core/uis/Registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegistrationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
