import 'package:flutter/material.dart';
import 'package:trackit_flutter/context/Habit/index.dart';
import 'package:trackit_flutter/data/DatabaseHandler/DbHelper/index.dart';
import 'package:trackit_flutter/layouts/Logged/index.dart';
import 'package:trackit_flutter/models/Habit/index.dart';
import 'package:trackit_flutter/models/User/index.dart';
import 'package:trackit_flutter/pages/Habits/widgets/NoHabits/index.dart';
import 'package:trackit_flutter/utils/Colors/index.dart';
import 'package:trackit_flutter/widgets/Form/index.dart';
import 'package:trackit_flutter/widgets/TextField/index.dart';
import 'package:trackit_flutter/widgets/Title/index.dart';
import 'package:trackit_flutter/widgets/Toast/index.dart';

const List<Widget> daysOfWeek = <Widget>[
  Text('M'),
  Text('T'),
  Text('W'),
  Text('T'),
  Text('F'),
  Text('S'),
  Text('S'),
];

class HabitsPage extends StatefulWidget {
  const HabitsPage({Key? key}) : super(key: key);

  @override
  State<HabitsPage> createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  UserModel? loggedInUser;

  HabitContext habitContext = HabitContext();

  final GlobalKey<FormState> habitsFormKey = GlobalKey<FormState>();

  late DbHelper dbHelper;

  List<HabitModel> habits = [];
  List<Widget> habitsWidgets = [];
  bool habitsLoaded = false;

  bool createHabitOpened = false;

  final _conName = TextEditingController();
  final List<bool> _conFrequency = <bool>[
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  Future<void> getHabits(String userId) async {
    List<HabitModel> _habits = await dbHelper.getByUserId(userId);

    setState(() {
      habits = _habits;
      habitsLoaded = true;
      mountHabitsWidget();
    });
  }

  void mountHabitsWidget() {
    habitsWidgets = [];
    for (var habit in habits) {
      var key = UniqueKey();
      habitsWidgets.add(HabitContainer(
          key: key,
          habit: habit,
          removeHabit: () => {
                setState(() {
                  deleteHabit(habit.id, key);
                })
              }));
    }
  }

  Future<void> deleteHabit(String id, Key key) async {
    habits.removeWhere((habit) => habit.id == id);
    habitsWidgets.removeWhere((item) => item.key == key);
    await dbHelper.deleteHabit(id);
    await habitContext.deleteHabit(id);
  }

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return LoggedLayout(
      page: 'Habits',
      getUser: (user) async {
        await getHabits(user.id);

        setState(() {
          loggedInUser = user;
        });
      },
      body: Column(
        children: [
          TitleApp(
            'My habits',
            plus: SizedBox(
              width: 40,
              height: 35,
              child: ElevatedButton(
                  onPressed: () => setState(() {
                        createHabitOpened = !createHabitOpened;
                      }),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const Icon(Icons.add, size: 20)),
            ),
          ),
          // TODO: Refactor to a widget
          createHabitOpened
              ? Container(
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
                      FormApp(
                        formKey: habitsFormKey,
                        fieldsContainer: Column(children: [
                          TextFieldApp(
                              controller: _conName,
                              name: "Habit name",
                              labelText: "habit name",
                              labelIcon: const Icon(Icons.task_alt)),
                          Row(
                            children: [
                              ToggleButtons(
                                direction: Axis.horizontal,
                                onPressed: (int index) {
                                  // All buttons are selectable.
                                  setState(() {
                                    _conFrequency[index] =
                                        !_conFrequency[index];
                                  });
                                },
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                selectedBorderColor: ColorsUtils.darkGray,
                                selectedColor: ColorsUtils.white,
                                fillColor: ColorsUtils.darkGray,
                                borderColor: ColorsUtils.darkGray,
                                color: ColorsUtils.darkGray,
                                constraints: const BoxConstraints(
                                  minHeight: 30.0,
                                  minWidth: 30.0,
                                ),
                                isSelected: _conFrequency,
                                children: daysOfWeek,
                              ),
                            ],
                          )
                        ]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => setState(() {
                              createHabitOpened = !createHabitOpened;
                            }),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (!habitsFormKey.currentState!.validate()) {
                                return;
                              }

                              if (_conFrequency
                                  .every((element) => element == false)) {
                                ToastApp.show(
                                    'You must select at least one day of the week',
                                    type: 'error');
                                return;
                              }

                              try {
                                HabitModel newHabit = HabitModel(_conName.text,
                                    loggedInUser?.id ?? "", _conFrequency);
                                await dbHelper.saveHabit(newHabit);

                                setState(() {
                                  habits.add(newHabit);
                                  habitContext.setHabit(newHabit);

                                  createHabitOpened = !createHabitOpened;
                                  _conName.clear();
                                  _conFrequency.fillRange(0, 7, false);

                                  mountHabitsWidget();
                                });
                              } catch (e) {
                                print("Get: $e");
                                ToastApp.show(
                                    e
                                            .toString()
                                            .contains("Saving habit failed!")
                                        ? e
                                            .toString()
                                            .replaceAll("Exception:", "")
                                        : "An error occured while saving habit",
                                    type: "error");
                              }
                            },
                            child: const Text('Create'),
                          ),
                        ],
                      )
                    ],
                  ))
              : Container(),
          habitsLoaded && habits.isEmpty
              ? const NoHabits()
              : Column(
                  children: habitsWidgets,
                )
        ],
      ),
    );
  }
}

class HabitContainer extends StatefulWidget {
  final Function removeHabit;

  const HabitContainer(
      {Key? key, required this.habit, required this.removeHabit})
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
    List<bool> days = widget.habit.frequency;
    List<String> daysNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    String daysString = '';

    for (int i = 0; i < days.length; i++) {
      if (days[i]) {
        if (daysString.isNotEmpty) daysString += ', ';

        daysString += daysNames[i];
      }
    }

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
                onPressed: () => widget.removeHabit(),
                icon: const Icon(Icons.delete_forever_rounded,
                    color: ColorsUtils.darkerGray),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Frequency',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                daysString.isEmpty ? 'None' : daysString,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
