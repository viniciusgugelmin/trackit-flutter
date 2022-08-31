import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Logged/index.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoggedLayout(
      page: 'Today',
      body: const Center(
        child: Text('Today'),
      ),
    );
  }
}
