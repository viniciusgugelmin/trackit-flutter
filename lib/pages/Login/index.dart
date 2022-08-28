import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Entry/index.dart';
import 'package:trackit_flutter/router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RouterApp router = RouterApp(context);

    return Scaffold(
      body: EntryLayout(
        buttonText: 'Log in',
        buttonCallback: () {
          router.goTo("Signup");
        },
        infoCallback: () {
          router.goTo("Signup");
        },
        infoText: 'Don\'t have an account? Sign up!',
      ),
    );
  }
}
