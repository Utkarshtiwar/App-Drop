import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AppDropRendererApp());
}

class AppDropRendererApp extends StatelessWidget {
  const AppDropRendererApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppDrop Renderer',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
