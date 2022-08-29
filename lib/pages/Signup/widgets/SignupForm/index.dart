import 'package:flutter/material.dart';
import 'package:trackit_flutter/utils/Email/index.dart';
import 'package:trackit_flutter/utils/Form/index.dart';
import 'package:trackit_flutter/widgets/Form/index.dart';
import 'package:trackit_flutter/widgets/TextField/index.dart';

class SignupForm extends StatelessWidget {
  static const padding = EdgeInsets.only(bottom: 10);
  static const border = OutlineInputBorder();

  const SignupForm({
    Key? key,
    required GlobalKey<FormState> signupFormKey,
  })  : _signupFormKey = signupFormKey,
        super(key: key);

  final GlobalKey<FormState> _signupFormKey;

  @override
  Widget build(BuildContext context) {
    EmailUtils emailUtils = EmailUtils();

    return FormApp(
      formKey: _signupFormKey,
      fieldsContainer: Column(
        children: <Widget>[
          TextFieldApp(name: 'Name', labelText: 'email'),
          TextFieldApp(
            name: 'Email',
            labelText: 'email',
            additionalValidators: [
              emailUtils.isEmail,
            ],
          ),
          TextFieldApp(name: 'Password', labelText: 'password')
        ],
      ),
    );
  }
}
