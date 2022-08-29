import 'package:flutter/material.dart';

class FormApp extends StatelessWidget {
  final Widget fieldsContainer;
  final GlobalKey<FormState> formKey;

  const FormApp({
    Key? key,
    required this.formKey,
    required this.fieldsContainer,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: fieldsContainer,
    );
  }
}
