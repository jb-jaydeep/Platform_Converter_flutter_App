import 'package:flutter/cupertino.dart';
import 'Componants/Cupertino/CupertinoCallsPage.dart';
import 'Componants/Cupertino/CupertinoChatPage.dart';
import 'Componants/Cupertino/CupertinoPersonPage.dart';
import 'Componants/Cupertino/CupertinoSettingPage.dart';

class IosPlatform extends StatefulWidget {
  const IosPlatform({Key? key}) : super(key: key);

  @override
  State<IosPlatform> createState() => _IosPlatformState();
}

class _IosPlatformState extends State<IosPlatform> {
  List<Widget> pages = [
    CupertinoPersonPage(),
    CupertinoChatPage(),
    CupertinoCallsPage(),
    CupertinoSettingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), label: "Person"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_text), label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.phone), label: "Calls"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings), label: "Settings"),
        ],
      ),
      tabBuilder: (context, index) => CupertinoTabView(
        builder: (BuildContext context) {
          return pages[index];
        },
      ),
    );
  }
}
