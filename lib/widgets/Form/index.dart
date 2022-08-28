import 'package:flutter/material.dart';

class FormApp extends StatelessWidget {
  final Widget fieldsContainer;

  const FormApp({
    Key? key,
    required GlobalKey<FormState> formKey, required this.fieldsContainer,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: fieldsContainer,
    );
  }
}