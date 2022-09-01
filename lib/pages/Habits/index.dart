import 'package:flutter/material.dart';
import 'package:trackit_flutter/layouts/Logged/index.dart';
import 'package:trackit_flutter/models/User/index.dart';
import 'package:trackit_flutter/pages/Habits/widgets/NoHabits/index.dart';
import 'package:trackit_flutter/utils/Colors/index.dart';
import 'package:trackit_flutter/widgets/Form/index.dart';
import 'package:trackit_flutter/widgets/TextField/index.dart';
import 'package:trackit_flutter/widgets/Title/index.dart';

class HabitsPage extends StatefulWidget {
  const HabitsPage({Key? key}) : super(key: key);

  @override
  State<HabitsPage> createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  UserModel? loggedInUser;

  final GlobalKey<FormState> habitsFormKey = GlobalKey<FormState>();

  List habits = [];
  List<Widget> habitsWidgets = [];
  bool habitsLoaded = false;

  bool createHabitOpened = false;
  final _conName = TextEditingController();

  Future<List> getHabits() async {
    // TODO: Get habits
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return LoggedLayout(
      page: 'Habits',
      getUser: (user) {
        setState(() {
          loggedInUser = user;

          getHabits().then((habits) {
            setState(() {
              this.habits = habits;
              habitsLoaded = true;
            });
          });
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
          createHabitOpened ? Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.only(top: 20, bottom: 29),
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
                  fieldsContainer: Column(
                      children: [
                        TextFieldApp(controller: _conName, name: "Habit name", labelText: "habit name", labelIcon: const Icon(Icons.task_alt))
                      ]
                  ),
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
                      onPressed: () {
                        if (!habitsFormKey.currentState!.validate()) return;

                        setState(() {
                          habits.add({
                            'name': _conName.text,
                            'frequency': [1, 2, 3, 4, 5]
                          });
                          createHabitOpened = !createHabitOpened;
                          _conName.clear();

                          habitsWidgets = [];
                          for (var habit in habits) {
                            habitsWidgets.add(HabitContainer(habit: habit));
                          }
                        });
                      },
                      child: const Text('Create'),
                    ),
                  ],
                )
              ],
            )
          ) : Container(),
          habitsLoaded && habits.isEmpty ? const NoHabits() : Column(
            children: habitsWidgets,
          )
        ],
      ),
    );
  }
}


class HabitContainer extends StatelessWidget {
  const HabitContainer({Key? key, required this.habit}) : super(key: key);

  final Map habit;

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
                habit['name'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Frequency',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                'Mon, Tue, Wed, Thu, Fri',
                style: TextStyle(
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
