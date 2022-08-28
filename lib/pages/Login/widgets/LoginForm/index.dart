import 'package:flutter/material.dart';
import 'package:trackit_flutter/utils/Email/index.dart';
import 'package:trackit_flutter/utils/Form/index.dart';
import 'package:trackit_flutter/widgets/Form/index.dart';

class LoginForm extends StatelessWidget {
  static const padding = EdgeInsets.only(bottom: 10);
  static const border = OutlineInputBorder();

  const LoginForm({
    Key? key,
    required GlobalKey<FormState> loginFormKey,
  })  : _loginFormKey = loginFormKey,
        super(key: key);

  final GlobalKey<FormState> _loginFormKey;

  @override
  Widget build(BuildContext context) {
    FormUtils formUtils = FormUtils();
    EmailUtils emailUtils = EmailUtils();

    return FormApp(
      formKey: _loginFormKey,
      fieldsContainer: Column(
        children: <Widget>[
          Container(
            padding: padding,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'email',
                border: border,
              ),
              validator: (value) =>
                  formUtils.validator('Email', value, [emailUtils.isEmail]),
            ),
          ),
          Container(
            padding: padding,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'password',
                border: border,
              ),
              validator: (value) => formUtils.validator('Password', value),
            ),
          ),
        ],
      ),
    );
  }
}
