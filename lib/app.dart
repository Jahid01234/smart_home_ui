import 'package:flutter/material.dart';
import 'package:smart_home_ui/ui/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Ui',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[300],
      ),
      home: const HomeScreen(),
    );
  }
}