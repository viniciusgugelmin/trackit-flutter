import 'package:flutter/material.dart';
import 'package:trackit_flutter/context/User/index.dart';
import 'package:trackit_flutter/layouts/Entry/widgets/CallbackButton/index.dart';
import 'package:trackit_flutter/layouts/Entry/widgets/InfoText/index.dart';
import 'package:trackit_flutter/router.dart';
import 'package:trackit_flutter/utils/Image/index.dart';

class EntryLayout extends StatelessWidget {
  UserContext userContext = UserContext();
  final String buttonText;
  final VoidCallback buttonCallback;
  final VoidCallback infoCallback;
  final String infoText;
  final Widget form;

  EntryLayout(
      {required this.buttonText,
      required this.buttonCallback,
      required this.infoCallback,
      required this.infoText,
      required this.form,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    RouterApp router = RouterApp(context);
    userContext.getToken().then((value) => value != null ? router.goTo('Today') : null);

    ImageUtils imageUtils = ImageUtils();
    String logoPath = imageUtils.getImagePath('logo.png');

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
            CallbackButton(
                buttonCallback: buttonCallback, buttonText: buttonText),
            InfoText(infoCallback: infoCallback, infoText: infoText),
          ],
        ),
      ),
    );
  }
}
