import 'package:flutter/material.dart';
import 'package:trackit_flutter/pages/Habits/index.dart';
import 'package:trackit_flutter/pages/Historic/index.dart';
import 'package:trackit_flutter/pages/Today/index.dart';
import 'package:trackit_flutter/pages/Login/index.dart';
import 'package:trackit_flutter/pages/Signup/index.dart';

class RouterApp {
  BuildContext context;
  var routes = [
    {
      'path': '/',
      'name': 'Opening',
      'page': const LoginPage(),
    },
    {
      'path': '/login',
      'name': 'Login',
      'page': const LoginPage(),
    },
    {
      'path': '/signup',
      'name': 'Signup',
      'page': const SignupPage(),
    },
    {
      'path': '/habits',
      'name': 'Habits',
      'page': const HabitsPage(),
    },
    {
      'path': '/today',
      'name': 'Today',
      'page': TodayPage(),
    },
    {
      'path': '/historic',
      'name': 'Historic',
      'page': const HistoricPage(),
    }
  ];

  RouterApp(this.context);

  Map<String, Widget Function(BuildContext)> getRoutes() {
    Map<String, Widget Function(BuildContext)> routesToReturn = {};

    for (var route in routes) {
      routesToReturn[route['path'] as String] = (BuildContext context) => route['page'] as Widget;
    }

    return routesToReturn;
  }

  void goTo(String name) {
    var route = routes.firstWhere((r) => r['name'] == name,
        orElse: () => routes[0]);

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => route['page'] as Widget),
        (route) => false);
  }
}
