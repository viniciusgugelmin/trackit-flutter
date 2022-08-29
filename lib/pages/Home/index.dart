import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Logged/index.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoggedLayout(
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}