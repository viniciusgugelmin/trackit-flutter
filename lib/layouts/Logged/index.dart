import 'package:flutter/material.dart';
import 'package:trackit_flutter/utils/Image/index.dart';

class LoggedLayout extends StatelessWidget {
  final Widget body;

  const LoggedLayout({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageUtils imageUtils = ImageUtils();
    String miniLogoPath = imageUtils.getImagePath('mini_logo.png');

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(miniLogoPath),
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}