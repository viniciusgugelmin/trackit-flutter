import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Entry/index.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Entry(
        buttonText: 'Signup',
        buttonCallback: () {
          Navigator.pushNamed(context, '/login');
        },
        infoText: 'Already have an account? Login',
      ),
    );
  }
}