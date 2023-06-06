import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

PageController pageController = PageController();
ImagePicker picker = ImagePicker();
File? image;
GlobalKey<FormState> addPageKey = GlobalKey<FormState>();
TextEditingController addPageFormFullNameController = TextEditingController();
// TextEditingController addPageFormLastNameController = TextEditingController();
TextEditingController addPageFormPhoneNumberController =
    TextEditingController();
TextEditingController addPageFormEmailController = TextEditingController();
String? fullName;
// String? lastName;
String? phoneNumber;
String? email;

class Contact {
  String fullName;
  String phoneNumber;
  String email;
  File? image;

  Contact({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    this.image,
  });
}

class Globals {
  static List<Contact> allContact = [];
}
