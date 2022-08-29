import 'package:flutter/material.dart';
import 'package:trackit_flutter/utils/Email/index.dart';
import 'package:trackit_flutter/utils/Form/index.dart';
import 'package:trackit_flutter/widgets/Form/index.dart';
import 'package:trackit_flutter/widgets/TextField/index.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
    required GlobalKey<FormState> loginFormKey,
  })  : _loginFormKey = loginFormKey,
        super(key: key);

  final GlobalKey<FormState> _loginFormKey;

  @override
  Widget build(BuildContext context) {
    EmailUtils emailUtils = EmailUtils();

    return FormApp(
      formKey: _loginFormKey,
      fieldsContainer: Column(
        children: <Widget>[
          TextFieldApp(
              name: 'Email',
              labelText: 'email',
              additionalValidators: [
                emailUtils.isEmail,
              ]),
          TextFieldApp(name: 'Password', labelText: 'password', isSecret: true),
        ],
      ),
    );
  }
}
