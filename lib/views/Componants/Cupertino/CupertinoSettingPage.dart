import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter_flutter_app/providers/providers.dart';
import 'package:provider/provider.dart';

import '../../../models/globas.dart';

class CupertinoSettingPage extends StatefulWidget {
  const CupertinoSettingPage({Key? key}) : super(key: key);

  @override
  State<CupertinoSettingPage> createState() => _CupertinoSettingPageState();
}

class _CupertinoSettingPageState extends State<CupertinoSettingPage> {
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CupertinoFormSection(
                header: Text('Profile'),
                children: [
                  CupertinoFormRow(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Update your Data'),
                        CupertinoSwitch(
                          onChanged: (val) {
                            Provider.of<PlatformProvider>(context,
                                    listen: false)
                                .ChangeProfile(val);
                          },
                          value: Provider.of<PlatformProvider>(context).Profile,
                        ),
                      ],
                    ),
                  ),
                  if (Provider.of<PlatformProvider>(context).Profile)
                    CupertinoFormRow(
                      child: Column(
                        children: [
                          SizedBox(
                            height: h * 0.02,
                          ),
                          SizedBox(
                            height: h * 0.15,
                            width: w,
                            child: GestureDetector(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoActionSheet(
                                      actions: [
                                        CupertinoActionSheetAction(
                                          onPressed: () async {
                                            XFile? imageXfile =
                                                await ImagePicker().pickImage(
                                                    source: ImageSource.camera);
                                            String ImagePath = imageXfile!.path;
                                            setState(() {
                                              image = File(ImagePath);
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Icon(Icons.camera_alt_sharp),
                                              Text("Camera"),
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                          ),
                                        ),
                                        CupertinoActionSheetAction(
                                          onPressed: () async {
                                            XFile? imageXfile =
                                                await ImagePicker().pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            String ImagePath = imageXfile!.path;
                                            setState(() {
                                              image = File(ImagePath);
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Icon(Icons.folder),
                                              Text("File"),
                                            ],
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey.shade200,
                                foregroundImage: (image != null)
                                    ? FileImage(image as File)
                                    : null,
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
                                  // Full Name
                                  Text(
                                    "Full Name",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CupertinoTextFormFieldRow(
                                    controller: addPageFormFullNameController,
                                    textInputAction: TextInputAction.next,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Enter your Full Name...";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (val) {
                                      setState(() {
                                        fullName = val;
                                      });
                                    },
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Bio
                                  Text(
                                    "Bio",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CupertinoTextFormFieldRow(
                                    controller: addPageFormEmailController,
                                    textInputAction: TextInputAction.done,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "Enter your Bio...";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (val) {
                                      setState(() {
                                        email = val;
                                      });
                                    },
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              CupertinoFormSection(
                header: Text('Theme'),
                children: [
                  CupertinoFormRow(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Change Theme'),
                        CupertinoSwitch(
                          value: Provider.of<PlatformProvider>(context).isdark,
                          onChanged: (val) {
                            Provider.of<PlatformProvider>(context,
                                    listen: false)
                                .Themechanger(val);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
