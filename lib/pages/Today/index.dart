import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Logged/index.dart';

class Today extends StatelessWidget {
  const Today({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoggedLayout(
      page: 'Today',
      body: Center(
        child: Text('Today'),
      ),
    );
  }
}