import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Logged/index.dart';

class Habits extends StatelessWidget {
  const Habits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoggedLayout(
      page: 'Habits',
      body: Center(
        child: Text('Habits'),
      ),
    );
  }
}