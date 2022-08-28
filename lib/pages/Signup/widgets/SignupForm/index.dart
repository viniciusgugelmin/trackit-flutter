import 'package:flutter/material.dart';
import 'package:trackit_flutter/utils/Email/index.dart';
import 'package:trackit_flutter/utils/Form/index.dart';
import 'package:trackit_flutter/widgets/Form/index.dart';

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
    FormUtils formUtils = FormUtils();
    EmailUtils emailUtils = EmailUtils();

    return FormApp(
      formKey: _signupFormKey,
      fieldsContainer: Column(
        children: <Widget>[
          Container(
            padding: padding,
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'name',
                border: border,
              ),
              validator: (value) =>
                  formUtils.validator('Name', value),
            ),
          ),
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
