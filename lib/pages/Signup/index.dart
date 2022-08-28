import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Entry/index.dart';
import 'package:trackit_flutter/pages/Login/widgets/LoginForm/index.dart';
import 'package:trackit_flutter/pages/Signup/widgets/SignupForm/index.dart';
import 'package:trackit_flutter/router.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() {
    return SignupPageState();
  }
}

class SignupPageState extends State<SignupPage> {
  final _signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    RouterApp router = RouterApp(context);

    return Scaffold(
      body: EntryLayout(
          buttonText: 'Sign up',
          buttonCallback: onSubmit,
          infoCallback: () {
            router.goTo("Login");
          },
          infoText: 'Already have an account? Log in!',
          form: SignupForm(signupFormKey: _signupFormKey)),
    );
  }

  void onSubmit() {
    if (_signupFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Processing Data')));
    }
  }
}
