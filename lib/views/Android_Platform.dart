import 'package:flutter/material.dart';
import 'package:platform_converter_flutter_app/views/Componants/callsPage.dart';
import 'package:platform_converter_flutter_app/views/Componants/chatPage.dart';
import 'package:platform_converter_flutter_app/views/Componants/person.dart';
import 'package:platform_converter_flutter_app/views/ios_platform.dart';
import 'package:provider/provider.dart';

import '../models/globas.dart';
import '../providers/providers.dart';
import 'Componants/settingPage.dart';

class AndroidPlatform extends StatefulWidget {
  const AndroidPlatform({Key? key}) : super(key: key);

  @override
  State<AndroidPlatform> createState() => _AndroidPlatformState();
}

class _AndroidPlatformState extends State<AndroidPlatform> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Platform Converter"),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Provider.of<PlatformProvider>(context, listen: false)
                  .selectPageAndroid(0);
              setState(() {});
              // Provider.of<PlatformProvider>(context, listen: true).selected = 0;
            },
            child: Icon(Icons.home)),
        actions: [
          Switch(
            value: Provider.of<PlatformProvider>(context).isIos,
            onChanged: (val) {
              Provider.of<PlatformProvider>(context, listen: false)
                  .changePlatform(val);
            },
          ),
        ],
      ),
      body: PageView(
        onPageChanged: (val) {
          Provider.of<PlatformProvider>(context, listen: false)
              .changePageAndroid(val);
        },
        children: [
          personPage(),
          chatPage(),
          CallPage(),
          SettingPage(),
        ],
        controller: pageController,
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          unselectedItemColor: (Provider.of<PlatformProvider>(context).isdark)
              ? Colors.white
              : Colors.black,
          fixedColor: Colors.red,
          currentIndex: Provider.of<PlatformProvider>(context).selected,
          onTap: (val) {
            Provider.of<PlatformProvider>(context, listen: false)
                .selectPageAndroid(val);
            pageController.jumpToPage(val);
          },
          // iconSize: 50,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Person",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mark_unread_chat_alt_sharp),
              label: "Chat",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.phone),
              label: "Calls",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Setting",
            ),
          ]),
    );
  }
}
