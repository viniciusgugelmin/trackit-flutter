import 'package:flutter/material.dart';
import 'package:trackit_flutter/utils/Images/index.dart';

@immutable
class EntryLayout extends StatelessWidget {
  final String buttonText;
  final VoidCallback buttonCallback;
  final VoidCallback infoCallback;
  final String infoText;
  final Widget form;

  const EntryLayout(
      {required this.buttonText,
      required this.buttonCallback,
      required this.infoCallback,
      required this.infoText,
      required this.form,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImagesUtils imagesUtils = ImagesUtils();
    String logoPath = imagesUtils.getImagePath('logo.png');

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 36, right: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.only(bottom: 32),
                child: Image.asset(logoPath)),
            form,
            Container(
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
            ),
            InkWell(
              onTap: infoCallback,
              child: Text(infoText,
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.blue,
                      decoration: TextDecoration.underline)),
            ),
          ],
        ),
      ),
    );
  }
}
