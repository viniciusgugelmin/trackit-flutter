import 'package:flutter/material.dart';
import 'package:trackit_flutter/utils/Colors/index.dart';

class TitleApp extends StatelessWidget {
  final String title;
  final Widget plus;

  const TitleApp(
    this.title, {
    Key? key,
    this.plus = const SizedBox(width: 10),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Text(
            title,
            style: const TextStyle(
              color: ColorsUtils.darkBlue,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        plus,
      ],
    );
  }
}
