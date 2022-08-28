import 'package:flutter/material.dart';

@immutable
class EntryLayout extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonCallback;
  final String infoText;

  const EntryLayout(
      {required this.buttonText,
      required this.buttonCallback,
      required this.infoText,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 36, right: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('./assets/images/logo.png'),
            const SizedBox(height: 20),
            ElevatedButton(
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
            Text(infoText)
          ],
        ),
      ),
    );
  }
}
