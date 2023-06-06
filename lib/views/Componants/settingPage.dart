import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter_flutter_app/providers/providers.dart';
import 'package:provider/provider.dart';

import '../../models/globas.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text("Profile"),
                subtitle: Text("Update your Profile"),
                leading: Icon(Icons.person),
                trailing: Switch(
                  onChanged: (val) {
                    Provider.of<PlatformProvider>(context, listen: false)
                        .ChangeProfile(val);
                  },
                  value: Provider.of<PlatformProvider>(context).Profile,
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              (Provider.of<PlatformProvider>(context).Profile)
                  ? Stepper(
                      controlsBuilder: (context, controlobject) {
                        return Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<PlatformProvider>(context).Profile =
                                    false;
                              },
                              child: Text("Save"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Provider.of<PlatformProvider>(context).Profile =
                                    false;
                              },
                              child: Text("Cancel"),
                            ),
                          ],
                        );
                      },
                      steps: [
                          Step(
                            title: Text("Profile"),
                            content: Column(
                              children: [
                                SizedBox(
                                  height: h * 0.02,
                                ),
                                SizedBox(
                                  height: h * 0.15,
                                  width: w,
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              height: h * 0.2,
                                              color: Colors.blueGrey,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () async {
                                                      XFile? imageXfile =
                                                          await picker.pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .camera);
                                                      String ImagePath =
                                                          imageXfile!.path;
                                                      setState(() {
                                                        image = File(ImagePath);
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Icon(Icons
                                                            .camera_alt_sharp),
                                                        Text("Camara"),
                                                      ],
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      XFile? imageXfile =
                                                          await picker.pickImage(
                                                              source:
                                                                  ImageSource
                                                                      .gallery);
                                                      String ImagePath =
                                                          imageXfile!.path;
                                                      setState(() {
                                                        image = File(ImagePath);
                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Icon(Icons.folder),
                                                        Text("File"),
                                                      ],
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        //full Name
                                        const Text(
                                          "Full Name",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller:
                                              addPageFormFullNameController,
                                          textInputAction: TextInputAction.next,
                                          validator: (val) {
                                            if (val!.isEmpty) {
                                              return "  Enter your Full Name...";
                                            } else {
                                              return null;
                                            }
                                          },
                                          onSaved: (val) {
                                            setState(() {
                                              fullName = val;
                                            });
                                          },
                                          decoration: const InputDecoration(
                                            hintText: "Enter First Name...",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        //Bio
                                        const Text(
                                          "Bio",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller:
                                              addPageFormEmailController,
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
                                          decoration: const InputDecoration(
                                            hintText: "Enter your Bio...",
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     ElevatedButton(
                                //       onPressed: () async {
                                //         if (addPageKey.currentState!.validate()) {
                                //           addPageKey.currentState!.save();
                                //           Contact c1 = Contact(
                                //             fullName: fullName!,
                                //             phoneNumber: phoneNumber!,
                                //             email: email!,
                                //             image: image!,
                                //           );
                                //           Globals.allContact.add(c1);
                                //           // await Navigator.of(context).pushReplacementNamed('/');
                                //           setState(() {});
                                //         }
                                //       },
                                //       child: Text(
                                //         "Save",
                                //         style: TextStyle(fontSize: 18),
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: w * 0.15,
                                //     ),
                                //     ElevatedButton(
                                //       onPressed: () async {
                                //         if (addPageKey.currentState!.validate()) {
                                //           addPageKey.currentState!.save();
                                //           Contact c1 = Contact(
                                //             fullName: fullName!,
                                //             phoneNumber: phoneNumber!,
                                //             email: email!,
                                //             image: image!,
                                //           );
                                //           Globals.allContact.add(c1);
                                //           // await Navigator.of(context).pushReplacementNamed('/');
                                //           setState(() {});
                                //         }
                                //       },
                                //       child: Text(
                                //         "Save",
                                //         style: TextStyle(fontSize: 18),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ])
                  : Container(),
              ListTile(
                title: Text("Theme"),
                subtitle: Text("Change Theme"),
                leading: Icon(Icons.wb_sunny_outlined),
                trailing: Switch(
                  value: Provider.of<PlatformProvider>(context).isdark,
                  onChanged: (val) {
                    Provider.of<PlatformProvider>(context, listen: false)
                        .Themechanger(val);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
