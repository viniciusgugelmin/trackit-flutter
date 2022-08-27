import 'package:flutter/material.dart';
import 'package:trackit_flutter/pages/Login/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Trackit",
      theme: ThemeData(backgroundColor: Colors.blue),
      home: const Scaffold(
        body: Login(),
      ),
    );
  }
}
