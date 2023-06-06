import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../models/globas.dart';
import '../../../providers/providers.dart';

class CupertinoPersonPage extends StatefulWidget {
  const CupertinoPersonPage({Key? key}) : super(key: key);

  @override
  State<CupertinoPersonPage> createState() => _CupertinoPersonPageState();
}

class _CupertinoPersonPageState extends State<CupertinoPersonPage> {
  final ImagePicker picker = ImagePicker();
  File? image;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Platform Converter"),
        leading: Icon(CupertinoIcons.home),
        trailing: CupertinoSwitch(
          value: Provider.of<PlatformProvider>(context).isIos,
          onChanged: (val) {
            Provider.of<PlatformProvider>(context, listen: false)
                .changePlatform(val);
          },
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h * 0.16,
            ),
            SizedBox(
              height: h * 0.15,
              width: w,
              child: GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoActionSheet(
                        actions: [
                          CupertinoActionSheetAction(
                            onPressed: () async {
                              final XFile? imageXfile = await picker.pickImage(
                                source: ImageSource.camera,
                              );
                              String imagePath = imageXfile!.path;
                              setState(() {
                                image = File(imagePath);
                                Navigator.of(context).pop();
                              });
                            },
                            child: Text('Camera'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () async {
                              final XFile? imageXfile = await picker.pickImage(
                                source: ImageSource.gallery,
                              );
                              String imagePath = imageXfile!.path;
                              setState(() {
                                image = File(imagePath);
                                Navigator.of(context).pop();
                              });
                            },
                            child: Text('File'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  backgroundImage: (image != null) ? FileImage(image!) : null,
                  child: Icon(
                    Icons.camera_alt,
                    size: 60,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: addPageKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Full Name",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoTextField(
                      controller: addPageFormFullNameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      placeholder: "Enter Full Name...",
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Phone Number",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoTextField(
                      controller: addPageFormPhoneNumberController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      placeholder: "Enter Phone Number...",
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoTextField(
                      controller: addPageFormEmailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      placeholder: "Enter Email...",
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CupertinoButton(
                child: Icon(CupertinoIcons.calendar),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      message: SizedBox(
                        height: 200,
                        child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime:
                                Provider.of<PlatformProvider>(context)
                                    .initialDate,
                            dateOrder: DatePickerDateOrder.dmy,
                            onDateTimeChanged: (DateTime date) {
                              Provider.of<PlatformProvider>(context,
                                      listen: false)
                                  .PickDate(date);
                            }),
                      ),
                    ),
                  );
                }),
            CupertinoButton(
                child: Icon(CupertinoIcons.time),
                onPressed: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      message: SizedBox(
                        height: 200,
                        child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.time,
                            initialDateTime:
                                Provider.of<PlatformProvider>(context)
                                    .initialDate,
                            dateOrder: DatePickerDateOrder.dmy,
                            onDateTimeChanged: (date) {
                              Provider.of<PlatformProvider>(context,
                                      listen: false)
                                  .PickTime(date as TimeOfDay);
                            }),
                      ),
                    ),
                  );
                }),
            CupertinoButton(
              onPressed: () {
                if (addPageKey.currentState!.validate()) {
                  addPageKey.currentState!.save();
                  Contact c1 = Contact(
                    fullName: fullName!,
                    phoneNumber: phoneNumber!,
                    email: email!,
                    image: image,
                  );
                  Globals.allContact.add(c1);
                  addPageFormEmailController.clear();
                  addPageFormFullNameController.clear();
                  addPageFormPhoneNumberController.clear();
                }
              },
              child: Text(
                "Save",
                style: TextStyle(fontSize: 18),
              ),
              color: CupertinoColors.activeBlue,
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
