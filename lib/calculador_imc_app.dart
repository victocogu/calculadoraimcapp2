import 'package:calculadoraimcapp2/pages/home_page.dart';
import 'package:flutter/material.dart';

class CalculadoraImcApp extends StatelessWidget {
  const CalculadoraImcApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}
