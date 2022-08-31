import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Logged/index.dart';
import 'package:trackit_flutter/utils/Colors/index.dart';
import 'package:trackit_flutter/widgets/Title/index.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoggedLayout(
      page: 'Habits',
      body: Column(
        children: [
          const TitleApp('My habits'),
          Container(
            padding: const EdgeInsets.only(top: 17),
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
          )
        ],
      ),
    );
  }
}