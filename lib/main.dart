import 'package:flutter/material.dart';
import 'package:ten_apps_challenge/calculator_app/calculator_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: CalculatorApp(),
    );
  }
}
