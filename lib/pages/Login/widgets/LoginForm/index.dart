import 'package:flutter/material.dart';
import 'package:trackit_flutter/utils/Email/index.dart';
import 'package:trackit_flutter/widgets/Form/index.dart';
import 'package:trackit_flutter/widgets/TextField/index.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> _loginFormKey;

  final Map<String, TextEditingController> controllers;

  const LoginForm({
    Key? key,
    required GlobalKey<FormState> loginFormKey,
    required this.controllers,
  })  : _loginFormKey = loginFormKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    EmailUtils emailUtils = EmailUtils();

    return FormApp(
      formKey: _loginFormKey,
      fieldsContainer: Column(
        children: <Widget>[
          TextFieldApp(
              controller: controllers['email'],
              name: 'Email',
              labelText: 'email',
              labelIcon: const Icon(Icons.email),
              inputType: TextInputType.emailAddress,
              additionalValidators: [
                emailUtils.isEmail,
              ]),
          TextFieldApp(
              controller: controllers['password'],
              name: 'Password',
              labelText: 'password',
              labelIcon: const Icon(Icons.lock),
              isSecret: true),
        ],
      ),
    );
  }
}
