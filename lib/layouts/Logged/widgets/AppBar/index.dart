import 'package:flutter/material.dart';
import 'package:trackit_flutter/router.dart';
import 'package:trackit_flutter/utils/Image/index.dart';

class AppBarApp extends StatelessWidget {
  const AppBarApp({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RouterApp router = RouterApp(context);
    ImageUtils imageUtils = ImageUtils();
    String miniLogoPath = imageUtils.getImagePath('mini_logo.png');

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child:
                  Image.asset(miniLogoPath, alignment: Alignment.centerLeft)),
          Expanded(
            flex: 0,
            child: Container(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  router.goTo('/');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
