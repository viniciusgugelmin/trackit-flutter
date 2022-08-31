import 'package:flutter/material.dart';
import 'package:trackit_flutter/context/User/index.dart';
import 'package:trackit_flutter/data/DatabaseHandler/DbHelper/index.dart';
import 'package:trackit_flutter/layouts/Entry/index.dart';
import 'package:trackit_flutter/models/User/index.dart';
import 'package:trackit_flutter/pages/Login/widgets/LoginForm/index.dart';
import 'package:trackit_flutter/router.dart';
import 'package:trackit_flutter/widgets/Toast/index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  late DbHelper dbHelper;
  late UserContext userContext;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    userContext = UserContext();
  }

  Future<void> onSubmit(context) async {
    if (!_loginFormKey.currentState!.validate()) {
      ToastApp.show("Please check your inputs", type: "error");
      return;
    }

    String email = _conEmail.text;
    String password = _conPassword.text;

    try {
      UserModel user = await dbHelper.getLoginUser(email, password);
      print(user.id);
    } catch (e) {
      print("Login: $e");
      ToastApp.show(
          e.toString().contains("Login failed!")
              ? e.toString().replaceAll("Exception:", "")
              : "An error occured while saving the user",
          type: "error");
      return;
    }

    ToastApp.show("User logged in successfully");

    RouterApp router = RouterApp(context);
    router.goTo("Today");
  }

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
          form: LoginForm(loginFormKey: _loginFormKey, controllers: {
            'email': _conEmail,
            'password': _conPassword,
          })),
    );
  }
}
