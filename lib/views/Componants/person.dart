import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter_flutter_app/providers/providers.dart';
import 'package:provider/provider.dart';

import '../../models/globas.dart';

class personPage extends StatefulWidget {
  const personPage({Key? key}) : super(key: key);

  @override
  State<personPage> createState() => _personPageState();
}

class _personPageState extends State<personPage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      body: SingleChildScrollView(
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
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: h * 0.2,
                          color: Colors.blueGrey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  XFile? imageXfile = await picker.pickImage(
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
                                    Text("Camara"),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  XFile? imageXfile = await picker.pickImage(
                                      source: ImageSource.gallery);
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                  foregroundImage:
                      (image != null) ? FileImage(image as File) : null,
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
                      controller: addPageFormFullNameController,
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
                    TextFormField(
                      controller: addPageFormPhoneNumberController,
                      textInputAction: TextInputAction.next,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your Contact No. Please...";
                        } else if (val.length != 10) {
                          return "Enter a Valid Contact No.";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        setState(() {
                          phoneNumber = val;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "Enter Contact No...",
                        border: OutlineInputBorder(),
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
                    TextFormField(
                      controller: addPageFormEmailController,
                      textInputAction: TextInputAction.done,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your Email...";
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
                        hintText: "Enter Email...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.date_range_outlined),
                  onPressed: () async {
                    DateTime? PickedDate = await showDatePicker(
                      context: context,
                      initialDate:
                          Provider.of<PlatformProvider>(context, listen: false)
                              .initialDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2050),
                    );
                    Provider.of<PlatformProvider>(context, listen: false)
                        .PickDate(PickedDate!);
                  },
                ),
                Text(
                    "${Provider.of<PlatformProvider>(context).initialDate.day}/${Provider.of<PlatformProvider>(context).initialDate.month}/${Provider.of<PlatformProvider>(context).initialDate.year}"),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: () async {
                    TimeOfDay? PickedTime = await showTimePicker(
                      context: context,
                      initialTime:
                          Provider.of<PlatformProvider>(context, listen: false)
                              .initialTime,
                    );
                    Provider.of<PlatformProvider>(context, listen: false)
                        .PickTime(PickedTime!);
                  },
                ),
                Text(
                    "${Provider.of<PlatformProvider>(context).initialTime.hour}:${Provider.of<PlatformProvider>(context).initialTime.minute}"),
              ],
            ),
            ElevatedButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
