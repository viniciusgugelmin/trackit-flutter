import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Entry/index.dart';
import 'package:trackit_flutter/router.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RouterApp router = RouterApp(context);

    return Scaffold(
      body: EntryLayout(
        buttonText: 'Signup',
        buttonCallback: () {
          router.goTo("Login");
        },
        infoText: 'Already have an account? Login',
      ),
    );
  }
}