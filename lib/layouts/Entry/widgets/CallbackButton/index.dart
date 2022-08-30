import 'package:flutter/material.dart';

class CallbackButton extends StatelessWidget {
  final VoidCallback buttonCallback;
  final String buttonText;

  const CallbackButton({
    Key? key,
    required this.buttonCallback,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 25),
      child: ElevatedButton(
        onPressed: buttonCallback,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(45),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(buttonText),
      ),
    );
  }
}
