import 'package:flutter/material.dart';
import 'package:trackit_flutter/utils/Colors/index.dart';

class InfoText extends StatelessWidget {
  final VoidCallback infoCallback;
  final String infoText;

  const InfoText({
    Key? key,
    required this.infoCallback,
    required this.infoText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: infoCallback,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Text(infoText,
            style: const TextStyle(
              fontSize: 14,
              color: ColorsUtils.lightBlue,
            )),
      ),
    );
  }
}
