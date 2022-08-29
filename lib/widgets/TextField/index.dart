import 'package:flutter/material.dart';
import 'package:trackit_flutter/utils/Colors/index.dart';
import 'package:trackit_flutter/utils/Form/index.dart';

@immutable
class TextFieldApp extends StatelessWidget {
  final String name;
  final String labelText;
  final bool isSecret;
  final List<Function>? additionalValidators;

  final EdgeInsets padding = const EdgeInsets.only(bottom: 10);
  final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(5)
  );

  final FormUtils formUtils = FormUtils();

  TextFieldApp({
    Key? key,
    required this.name,
    required this.labelText,
    this.isSecret = false,
    this.additionalValidators,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: ColorsUtils.lightBlue,
          hintColor: ColorsUtils.gray,
        ),
        child: TextFormField(
          obscureText: isSecret,
          enableSuggestions: !isSecret,
          autocorrect: !isSecret,
          decoration: InputDecoration(
            labelText: labelText,
            border: border,
          ),
          validator: (value) => formUtils.validator(name, value, additionalValidators),
        ),
      ),
    );
  }
}