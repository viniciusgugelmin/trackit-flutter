import 'package:flutter/material.dart';
import 'package:trackit_flutter/pages/Login/index.dart';
import 'package:trackit_flutter/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RouterApp router = RouterApp(context);

    return MaterialApp(
      title: "Trackit",
      routes: router.getRoutes(),
      theme: ThemeData(backgroundColor: Colors.blue),
      home: const Login(),
    );
  }
}
