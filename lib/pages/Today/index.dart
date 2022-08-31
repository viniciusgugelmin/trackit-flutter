import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Logged/index.dart';
import 'package:intl/intl.dart';
import 'package:trackit_flutter/utils/Colors/index.dart';

class TodayPage extends StatelessWidget {
  const TodayPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    DateFormat formatter = DateFormat('dd/MM');
    DateFormat formatterWeekday = DateFormat('EEEE');

    String formattedDate = formatter.format(now);
    String formattedDateWeekday = formatterWeekday.format(now);

    const habits = [
      {
        'name': 'Wake up early',
        'description': 'Wake up early',
        'icon': 'assets/images/icons/icon_wakeup.png',
        'color': ColorsUtils.darkBlue,
        'progress': 0.5,
      },
    ];

    double completedHabits = 100.0;
    String completedHabitsMessages = '${completedHabits.toStringAsFixed(0)}% of habits completed';

    if (completedHabits == 100.0) {
      completedHabitsMessages = 'All habits completed';
    } else if (completedHabits == 0.0) {
      completedHabitsMessages = 'No habits completed';
    }

    return LoggedLayout(
      page: 'Today',
      body: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  "$formattedDateWeekday, $formattedDate",
                  style: const TextStyle(
                    color: ColorsUtils.darkBlue,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  completedHabitsMessages,
                  style: const TextStyle(
                    color: ColorsUtils.darkGray,
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
