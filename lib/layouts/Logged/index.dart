import 'package:flutter/material.dart';
import 'package:trackit_flutter/context/User/index.dart';
import 'package:trackit_flutter/data/DatabaseHandler/DbHelper/index.dart';
import 'package:trackit_flutter/layouts/Logged/interfaces/IPage/index.dart';
import 'package:trackit_flutter/layouts/Logged/widgets/AppBar/index.dart';
import 'package:trackit_flutter/models/User/index.dart';
import 'package:trackit_flutter/router.dart';
import 'package:trackit_flutter/utils/Colors/index.dart';
import 'package:trackit_flutter/widgets/Toast/index.dart';

class LoggedLayout extends StatefulWidget {
  final Widget body;
  final String page;
  Function? getUser;

  LoggedLayout({Key? key, required this.body, required this.page, this.getUser}) : super(key: key);

  @override
  State<LoggedLayout> createState() => _LoggedLayoutState();
}

class _LoggedLayoutState extends State<LoggedLayout> {
  UserModel? loggedInUser;

  UserContext userContext = UserContext();

  late DbHelper dbHelper;

  Future<UserModel?> checkContext(Map<String, dynamic>? value, context) async {
    RouterApp router = RouterApp(context);

    if (value == null || value['token'] == null) {
      router.goTo('/');
      return null;
    }

    dbHelper = DbHelper();
    try {
      UserModel user = await dbHelper.getSessionUser(value['token']);
      userContext.setUser(user);
      return user;
    } catch (e) {
      print("Get: $e");
      ToastApp.show(
          e.toString().contains("Get user failed!")
              ? e.toString().replaceAll("Exception:", "")
              : "An error occured while getting user",
          type: "error");
      router.goTo('/');
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    userContext.getUser().then((user) {
      setState(() {
        loggedInUser = user;

        if (widget.getUser != null) {
          widget.getUser!(user);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    RouterApp router = RouterApp(context);

    List<IPage> pagesName = [
      const IPage('Habits', Icon(Icons.sunny)),
      const IPage('Today', Icon(Icons.task_rounded)),
      const IPage('Historic', Icon(Icons.calendar_month)),
    ];
    List<BottomNavigationBarItem> pages = [];
    int pageNumber = 0;
    pageNumber = pagesName.indexWhere((element) => element.name == widget.page);

    for (IPage page in pagesName) {
      pages.add(BottomNavigationBarItem(
        icon: page.icon,
        label: page.name,
      ));
    }

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: AppBarApp(),
          backgroundColor: ColorsUtils.darkBlue),
      body: SingleChildScrollView(
        child: Container(
            padding:
                const EdgeInsets.only(top: 28, left: 18, right: 18, bottom: 18),
            child: widget.body),
      ),
      backgroundColor: ColorsUtils.lightGray,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageNumber,
        backgroundColor: ColorsUtils.white,
        items: pages,
        selectedItemColor: ColorsUtils.lightBlue,
        onTap: (int index) => router.goTo(pagesName[index].name),
      ),
    );
  }
}
