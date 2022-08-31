import 'package:flutter/material.dart';
import 'package:trackit_flutter/data/DatabaseHandler/DbHelper/index.dart';
import 'package:trackit_flutter/layouts/Entry/index.dart';
import 'package:trackit_flutter/models/User/index.dart';
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

  final _conName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  late DbHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  Future<void> onSubmit(context) async {
    if (!_signupFormKey.currentState!.validate()) {
      ToastApp.show("Please check your inputs", type: "error");
      return;
    }

    String name = _conName.text;
    String email = _conEmail.text;
    String password = _conPassword.text;

    UserModel user = UserModel(name, email, password);

    try {
      await dbHelper.saveUser(user);
    } catch (e) {
      print("Signup: $e");
      ToastApp.show("An error occured while saving the user", type: "error");
      return;
    }

    ToastApp.show("User created successfully");

    RouterApp router = RouterApp(context);
    router.goTo("Login");
  }

  @override
  Widget build(BuildContext context) {
    RouterApp router = RouterApp(context);

    return Scaffold(
      body: EntryLayout(
          buttonText: 'Sign up',
          buttonCallback: () => onSubmit(context),
          infoCallback: () {
            router.goTo("Login");
          },
          infoText: 'Already have an account? Log in!',
          form: SignupForm(signupFormKey: _signupFormKey, controllers: {
            'name': _conName,
            'email': _conEmail,
            'password': _conPassword,
          })),
    );
  }
}
