import 'package:flutter/cupertino.dart';
import 'packag'
    'e:flutter/material.dart';

class theme_model {
  bool isDark;
  theme_model({required this.isDark});
}

class PlatformProvider extends ChangeNotifier {
  bool Profile = false;
  String fullNamesetting = "";
  int i = 0;
  int index = 0;
  bool isdark = false;
  bool isIos = true;
  int selected = 0;
  DateTime initialDate = DateTime.now();
  TimeOfDay initialTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  void changePlatform(bool n) {
    isIos = n;
    notifyListeners();
  }

  void FullnameSettingmethod(String n) {
    fullNamesetting = n;
    notifyListeners();
  }

  void selectPageAndroid(int n) {
    selected = n;
    notifyListeners();
  }

  void changePageAndroid(int n) {
    index = n;
    notifyListeners();
  }

  void PickDate(DateTime n) {
    initialDate = n;
    notifyListeners();
  }

  void PickTime(TimeOfDay n) {
    initialTime = n;
    notifyListeners();
  }

  void ChangeProfile(bool n) {
    Profile = n;
    notifyListeners();
  }

  void Themechanger(bool n) {
    isdark = n;
    notifyListeners();
  }

  void homefunction() {
    i = 0;
    notifyListeners();
  }
}
