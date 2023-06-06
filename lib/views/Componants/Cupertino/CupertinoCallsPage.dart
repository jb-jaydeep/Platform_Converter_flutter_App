import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/globas.dart';
import '../../../providers/providers.dart';

class CupertinoCallsPage extends StatefulWidget {
  const CupertinoCallsPage({Key? key}) : super(key: key);
  @override
  State<CupertinoCallsPage> createState() => _CupertinoCallsPageState();
}

class _CupertinoCallsPageState extends State<CupertinoCallsPage> {
  // Future<void> launchUrl(Uri url) async {
  //   if (await canLaunch(url.toString())) {
  //     await launch(url.toString());
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("Platform Converter"),
        leading: GestureDetector(
            onTap: () {
              // Navigator.of(context).pop();
            },
            child: const Icon(CupertinoIcons.home)),
        trailing: CupertinoSwitch(
          value: Provider.of<PlatformProvider>(context).isIos,
          onChanged: (val) {
            Provider.of<PlatformProvider>(context, listen: false)
                .changePlatform(val);
          },
        ),
      ),
      child: (Globals.allContact.isNotEmpty)
          ? ListView.builder(
              itemCount: Globals.allContact.length,
              itemBuilder: (context, i) {
                return CupertinoListTile(
                  onTap: () {},
                  leading: CircleAvatar(
                    radius: 30,
                    foregroundImage:
                        FileImage(Globals.allContact[i].image as File),
                  ),
                  title: Text(Globals.allContact[i].fullName),
                  subtitle: Text("+91 ${Globals.allContact[i].phoneNumber}"),
                  trailing: CupertinoButton(
                    padding: const EdgeInsets.all(16),
                    child: const Icon(
                      CupertinoIcons.phone,
                      color: CupertinoColors.activeGreen,
                    ),
                    onPressed: () async {
                      Uri url = Uri.parse(
                          "tel:+91${Globals.allContact[i].phoneNumber}");
                      await launchUrl(url);
                    },
                  ),
                );
              },
            )
          : const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.import_contacts_outlined,
                    size: 200,
                  ),
                  Text(
                    "You have no contact Yet!!!",
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
