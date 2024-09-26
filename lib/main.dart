import 'package:flutter/material.dart';
import 'package:inputdata/pages/mainNavigation.dart';
import 'package:inputdata/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple.shade400),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

