import 'package:flutter/material.dart';
import 'package:trackit_flutter/utils/Colors/index.dart';
import 'package:trackit_flutter/utils/Form/index.dart';

class TextFieldApp extends StatelessWidget {
  TextEditingController? controller;
  final String name;
  final String labelText;
  final Icon labelIcon;
  final bool isSecret;
  final TextInputType inputType;
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
    required this.labelIcon,
    required this.controller,
    this.isSecret = false,
    this.inputType = TextInputType.text,
    this.additionalValidators,
  })
      : super(key: key);

  bool isFocused(context) {
    return FocusScope.of(context).hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Theme(
        data: Theme.of(context).copyWith(
          primaryColor: ColorsUtils.lightBlue,
          hintColor: ColorsUtils.lightGray,
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: inputType,
          obscureText: isSecret,
          enableSuggestions: !isSecret,
          autocorrect: !isSecret,
          decoration: InputDecoration(
            prefixIcon: labelIcon,
            labelText: labelText,
            border: border,
            labelStyle: const TextStyle(
              fontSize: 19,
            ),
          ),
          validator: (value) => formUtils.validator(name, value, additionalValidators),
          onSaved: (value) => controller?.text = value ?? '',
        ),
      ),
    );
  }
}