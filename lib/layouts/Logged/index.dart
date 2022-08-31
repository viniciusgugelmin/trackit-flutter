import 'package:flutter/material.dart';
import 'package:trackit_flutter/context/User/index.dart';
import 'package:trackit_flutter/data/DatabaseHandler/DbHelper/index.dart';
import 'package:trackit_flutter/layouts/Logged/interfaces/IPage/index.dart';
import 'package:trackit_flutter/layouts/Logged/widgets/AppBar/index.dart';
import 'package:trackit_flutter/models/User/index.dart';
import 'package:trackit_flutter/router.dart';
import 'package:trackit_flutter/utils/Colors/index.dart';
import 'package:trackit_flutter/widgets/Toast/index.dart';

class LoggedLayout extends StatelessWidget {
  UserModel? loggedInUser;

  UserContext userContext = UserContext();
  late DbHelper dbHelper;

  final Widget body;
  final String page;

  LoggedLayout({Key? key, required this.body, required this.page})
      : super(key: key);

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
  Widget build(BuildContext context) {
    userContext.getToken().then(
        (value) async => {loggedInUser = await checkContext(value, context)});
    RouterApp router = RouterApp(context);

    List<IPage> pagesName = [
      const IPage('Habits', Icon(Icons.sunny)),
      const IPage('Today', Icon(Icons.task_rounded)),
      const IPage('Historic', Icon(Icons.calendar_month)),
    ];
    List<BottomNavigationBarItem> pages = [];
    int pageNumber = 0;
    pageNumber = pagesName.indexWhere((element) => element.name == page);

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
            child: body),
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
