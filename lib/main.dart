import 'package:flutter/material.dart';
import 'package:rent_tracker/presentation/auth_screen/auth_screen.dart';

void main() {
  runApp(const RentTrackerApp());
}

class RentTrackerApp extends StatelessWidget {
  const RentTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rent Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AuthScreen(),
    );
  }
}
