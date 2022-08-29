import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Logged/index.dart';

class Historic extends StatelessWidget {
  const Historic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoggedLayout(
      page: 'Historic',
      body: Center(
        child: Text('Historic'),
      ),
    );
  }
}