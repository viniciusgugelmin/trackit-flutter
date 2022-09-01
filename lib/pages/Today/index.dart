import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Logged/index.dart';
import 'package:intl/intl.dart';
import 'package:trackit_flutter/models/User/index.dart';
import 'package:trackit_flutter/utils/Colors/index.dart';
import 'package:trackit_flutter/widgets/Title/index.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  State<TodayPage> createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  UserModel? loggedInUser;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    DateFormat formatter = DateFormat('dd/MM');
    DateFormat formatterWeekday = DateFormat('EEEE');

    String formattedDate = formatter.format(now);
    String formattedDateWeekday = formatterWeekday.format(now);

    const completedHabits = 100.0;
    String completedHabitsMessages =
        '${completedHabits.toStringAsFixed(0)}% of habits completed';

    if (completedHabits == 100.0) {
      completedHabitsMessages = 'All habits completed';
    } else if (completedHabits == 0.0) {
      completedHabitsMessages = 'No habits completed';
    }

    String welcomeMessage =
        loggedInUser != null ? 'Hello, ${loggedInUser?.name}\n' : '';

    return LoggedLayout(
      page: 'Today',
      getUser: (user) {
        setState(() {
          loggedInUser = user;
        });
      },
      body: Column(
        children: [
          Row(children: [
            Flexible(
              child: Text(welcomeMessage,
                  style:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ColorsUtils.darkerGray)),
            ),
          ]),
          TitleApp("$formattedDateWeekday, $formattedDate"),
          Row(
            children: [
              Flexible(
                child: Text(
                  completedHabitsMessages,
                  style: const TextStyle(
                    color: completedHabits == 0.0
                        ? ColorsUtils.darkGray
                        : ColorsUtils.green,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
