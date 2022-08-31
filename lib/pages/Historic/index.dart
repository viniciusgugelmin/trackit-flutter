import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Logged/index.dart';

class HistoricPage extends StatelessWidget {
  const HistoricPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoggedLayout(
      page: 'Historic',
      body: const Center(
        child: Text('Historic'),
      ),
    );
  }
}