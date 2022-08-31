import 'package:flutter/material.dart';
import 'package:trackit_flutter/utils/Colors/index.dart';

class TitleApp extends StatelessWidget {
  final String title;

  const TitleApp(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            title,
            style: const TextStyle(
              color: ColorsUtils.darkBlue,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}
