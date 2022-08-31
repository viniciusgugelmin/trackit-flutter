import 'package:flutter/material.dart';
import 'package:trackit_flutter/utils/Email/index.dart';
import 'package:trackit_flutter/utils/Form/index.dart';
import 'package:trackit_flutter/widgets/Form/index.dart';
import 'package:trackit_flutter/widgets/TextField/index.dart';

class SignupForm extends StatelessWidget {
  final GlobalKey<FormState> _signupFormKey;

  final Map<String, TextEditingController> controllers;

  static const padding = EdgeInsets.only(bottom: 10);
  static const border = OutlineInputBorder();

  const SignupForm({
    Key? key,
    required GlobalKey<FormState> signupFormKey,
    required this.controllers,
  })  : _signupFormKey = signupFormKey,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    EmailUtils emailUtils = EmailUtils();

    return FormApp(
      formKey: _signupFormKey,
      fieldsContainer: Column(
        children: <Widget>[
          TextFieldApp(
              controller: controllers['name'],
              name: 'Name',
              labelText: 'name',
              labelIcon: const Icon(Icons.person)),
          TextFieldApp(
            controller: controllers['email'],
            name: 'Email',
            labelText: 'email',
            labelIcon: const Icon(Icons.email),
            inputType: TextInputType.emailAddress,
            additionalValidators: [
              emailUtils.isEmail,
            ],
          ),
          TextFieldApp(
              controller: controllers['password'],
              name: 'Password',
              labelText: 'password',
              labelIcon: const Icon(Icons.lock),
              isSecret: true)
        ],
      ),
    );
  }
}
