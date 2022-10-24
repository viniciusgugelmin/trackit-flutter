import 'package:flutter/material.dart';
import 'package:trackit_flutter/data/DatabaseHandler/DbHelper/index.dart';
import 'package:trackit_flutter/layouts/Logged/index.dart';
import 'package:intl/intl.dart';
import 'package:trackit_flutter/models/Habit/index.dart';
import 'package:trackit_flutter/models/HabitUser/index.dart';
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

  late DbHelper dbHelper;

  List<HabitModel> habits = [];
  List<Widget> habitsWidgets = [];
  bool habitsLoaded = false;

  List<HabitUserModel> habitsUser = [];

  double completedHabitsPercentage = 100;
  String completedHabitsMessages = '${100}% of habits completed';

  Future<void> getTodayHabits(String userId) async {
    dbHelper.getByUserIdAndDate(userId).then((value) {
      if (habits.length == 0) {
        setState(() {
          habits = value;
          habitsLoaded = true;
          mountHabitsWidget();
          mountTextWidget();
        });
        return;
      }

      dbHelper.getHabitUserByUserIdAndDate(userId).then((_value) {
        setState(() {
          habits = value;
          habitsLoaded = true;
          habitsUser = _value;
          mountHabitsWidget();
          mountTextWidget();
        });
      });
    });
  }

  void mountHabitsWidget() {
    habitsWidgets = [];
    for (var habit in habits) {
      var key = UniqueKey();
      habitsWidgets.add(HabitContainer(
          key: key,
          habit: habit,
          completeHabit: () => {
                setState(() {
                  // check if habit is already completed
                  bool checkIfHabitIsAlreadyCompletedToday = habitsUser
                      .where((element) =>
                          element.habitId == habit.id &&
                          element.userId == loggedInUser!.id)
                      .isNotEmpty;

                  if (!checkIfHabitIsAlreadyCompletedToday) {
                    completeHabit(habit.id, loggedInUser!.id, key);
                    habitsUser.add(HabitUserModel(
                        habit.id, loggedInUser!.id, DateTime.now()));
                    mountHabitsWidget();
                    mountTextWidget();
                    return;
                  }

                  descompleteHabit(habit.id, loggedInUser!.id, key);
                  habitsUser.removeWhere((element) =>
                      element.habitId == habit.id &&
                      element.userId == loggedInUser!.id);
                  mountHabitsWidget();
                  mountTextWidget();
                })
              },
          isCompleted:
              habitsUser.any((element) => element.habitId == habit.id)));
    }
  }

  void mountTextWidget() {
    completedHabitsPercentage =
        habits.isNotEmpty ? (habitsUser.length / habits.length) * 100 : 100;
    completedHabitsMessages =
        '${completedHabitsPercentage.toStringAsFixed(0)}% of habits completed';

    if (completedHabitsPercentage == 100) {
      completedHabitsMessages = 'All habits completed';
    }

    if (completedHabitsPercentage == 0) {
      completedHabitsMessages = 'No habits completed';
    }
  }

  Future<void> completeHabit(String habitId, String userId, Key key) async {
    await dbHelper.saveHabitUser(habitId, userId);
  }

  Future<void> descompleteHabit(String habitId, String userId, Key key) async {
    await dbHelper.deleteHabitUser(habitId, userId);
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    DateFormat formatter = DateFormat('dd/MM');
    DateFormat formatterWeekday = DateFormat('EEEE');

    String formattedDate = formatter.format(now);
    String formattedDateWeekday = formatterWeekday.format(now);

    String welcomeMessage =
        loggedInUser != null ? 'Hello, ${loggedInUser?.name}\n' : '';

    return LoggedLayout(
      page: 'Today',
      getUser: (user) async {
        setState(() {
          loggedInUser = user;
        });

        await getTodayHabits(user.id);
      },
      body: Column(
        children: [
          Row(children: [
            Flexible(
              child: Text(welcomeMessage,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorsUtils.darkerGray)),
            ),
          ]),
          TitleApp("$formattedDateWeekday, $formattedDate"),
          Row(
            children: [
              Flexible(
                child: Text(
                  completedHabitsMessages,
                  style: const TextStyle(
                    color: ColorsUtils.darkerGray,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          habitsLoaded && habits.isEmpty
              ? const Text('')
              : Column(
                  children: habitsWidgets,
                )
        ],
      ),
    );
  }
}

class HabitContainer extends StatefulWidget {
  final Function completeHabit;
  final bool isCompleted;

  const HabitContainer(
      {Key? key,
      required this.habit,
      required this.completeHabit,
      required this.isCompleted})
      : super(key: key);

  final HabitModel habit;

  @override
  State<HabitContainer> createState() => _HabitContainerState();
}

class _HabitContainerState extends State<HabitContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: ColorsUtils.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: ColorsUtils.lightGray,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.habit.name,
                style: const TextStyle(
                  fontSize: 18,
                  color: ColorsUtils.darkerGray,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () => widget.completeHabit(),
                icon: const Icon(Icons.check_circle_outline),
                color: widget.isCompleted
                    ? ColorsUtils.green
                    : ColorsUtils.lightGray,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
