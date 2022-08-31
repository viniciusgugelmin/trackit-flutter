import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Logged/index.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoggedLayout(
      page: 'Habits',
      body: const Center(
        child: Text('Habits'),
      ),
    );
  }
}