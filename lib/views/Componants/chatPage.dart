import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/globas.dart';

class chatPage extends StatefulWidget {
  const chatPage({Key? key}) : super(key: key);

  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (Globals.allContact.isNotEmpty)
          ? ListView.builder(
              itemCount: Globals.allContact.length,
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () {},
                  leading: CircleAvatar(
                    radius: 30,
                    foregroundImage:
                        FileImage(Globals.allContact[i].image as File),
                  ),
                  title: Text("${Globals.allContact[i].fullName}"),
                  subtitle: Text("+91 ${Globals.allContact[i].phoneNumber}"),
                  trailing: IconButton(
                    icon: Icon(Icons.phone),
                    color: CupertinoColors.activeGreen,
                    onPressed: () async {
                      Uri url = Uri.parse(
                          "tel:+91${Globals.allContact[i].phoneNumber}");
                      await launchUrl(url);
                    },
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.import_contacts_outlined,
                    size: 200,
                  ),
                  Text(
                    "You have no Chat Yet!!!",
                    style: TextStyle(
                      fontSize: 21,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
