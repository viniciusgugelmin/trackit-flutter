import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Entry/index.dart';
import 'package:trackit_flutter/pages/Login/widgets/LoginForm/index.dart';
import 'package:trackit_flutter/router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    RouterApp router = RouterApp(context);

    return Scaffold(
      body: EntryLayout(
          buttonText: 'Log in',
          buttonCallback: () => onSubmit(context),
          infoCallback: () async {
            router.goTo("Signup");
          },
          infoText: 'Don\'t have an account? Sign up!',
          form: LoginForm(loginFormKey: _loginFormKey)),
    );
  }

  void onSubmit(context) {
    if (!_loginFormKey.currentState!.validate()) return;

    RouterApp router = RouterApp(context);
    router.goTo("Today");
  }
}
