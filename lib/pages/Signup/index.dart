import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Entry/index.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Entry(
        buttonText: 'Signup',
        buttonCallback: () {
          Navigator.pushNamed(context, '/signup');
        },
        infoText: 'Already have an account? Login',
      ),
    );
  }
}