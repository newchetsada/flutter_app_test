import 'package:flutter/material.dart';
import 'package:flutter_app_test/currency.dart';
import 'package:flutter_app_test/fibonacci.dart';
import 'package:flutter_app_test/home.dart';
import 'package:flutter_app_test/validate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
