import 'package:flutter/material.dart';
import 'package:trackit_flutter/pages/Home/index.dart';
import 'package:trackit_flutter/pages/Login/index.dart';
import 'package:trackit_flutter/pages/Signup/index.dart';

class RouterApp {
  BuildContext context;
  var routes = [
    {
      'path': '/',
      'name': 'Opening',
    },
    {
      'path': '/login',
      'name': 'Login',
    },
    {
      'path': '/signup',
      'name': 'Signup',
    },
    {
      'path': '/home',
      'name': 'Home',
    }
  ];

  RouterApp(this.context);

  Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      '/': (context) => const LoginPage(),
      '/login': (context) => const LoginPage(),
      '/signup': (context) => const SignupPage(),
      '/home': (context) => const Home(),
    };
  }

  void goTo(String name) {
    var route = routes.firstWhere((r) => r['name'] == name,
        orElse: () => {'path': '/'});

    Navigator.pushNamed(context, route['path'] as String);
  }
}
