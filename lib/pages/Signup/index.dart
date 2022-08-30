import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:trackit_flutter/layouts/Entry/index.dart';
import 'package:trackit_flutter/pages/Signup/widgets/SignupForm/index.dart';
import 'package:trackit_flutter/router.dart';
import 'package:trackit_flutter/widgets/Toast/index.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  SignupPageState createState() {
    return SignupPageState();
  }
}

class SignupPageState extends State<SignupPage> {
  final _signupFormKey = GlobalKey<FormState>();

  void onSubmit() {
    if (!_signupFormKey.currentState!.validate()) {
      ToastApp.show("Please check your inputs", duration: ToastApp.lengthLong);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    RouterApp router = RouterApp(context);
    ToastApp.init(context);

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
}
