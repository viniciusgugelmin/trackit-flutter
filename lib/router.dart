import 'package:flutter/material.dart';
import 'package:trackit_flutter/pages/Login/index.dart';
import 'package:trackit_flutter/pages/Signup/index.dart';

class RouterApp {
  BuildContext context;

  RouterApp(this.context);

  getRoutes() {
    return {
      '/login': (context) => const Login(),
      '/signup': (context) => const Signup(),
    };
  }
}