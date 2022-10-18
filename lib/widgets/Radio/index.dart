import 'package:flutter/material.dart';
import 'package:trackit_flutter/utils/Form/index.dart';

class RadioApp extends StatelessWidget {
  TextEditingController? controller;

  final FormUtils formUtils = FormUtils();

  RadioApp({
    Key? key,
    required this.controller,
  }) : super(key: key);

  bool isFocused(context) {
    return FocusScope.of(context).hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    return Radio(
      value: controller?.text == 'true',
      groupValue: controller,
      onChanged: (value) {
        print(controller?.text);
        controller?.text = "true";
      },
    );
  }
}
