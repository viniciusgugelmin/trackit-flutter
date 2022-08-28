import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Entry/index.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Entry(
        buttonText: 'Login',
        buttonCallback: () {
          Navigator.pushNamed(context, '/login');
        },
        infoText: 'Don\'t have an account? Sign up',
      ),
    );
  }
}
