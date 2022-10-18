import 'package:flutter/material.dart';
import 'package:trackit_flutter/utils/Colors/index.dart';

class NoHabits extends StatelessWidget {
  const NoHabits({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 27),
      child: Row(
        children: const [
          Flexible(
            child: Text(
              "You don't have any habits registered yet. Add a habit to start tracking!",
              style: TextStyle(
                color: ColorsUtils.darkerGray,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}