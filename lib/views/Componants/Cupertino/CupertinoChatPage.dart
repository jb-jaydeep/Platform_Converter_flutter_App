import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/globas.dart';
import '../../../providers/providers.dart';

class CupertinoChatPage extends StatefulWidget {
  const CupertinoChatPage({Key? key}) : super(key: key);

  @override
  State<CupertinoChatPage> createState() => _CupertinoChatPageState();
}

class _CupertinoChatPageState extends State<CupertinoChatPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Platform Converter"),
        leading:
            GestureDetector(onTap: () {}, child: Icon(CupertinoIcons.home)),
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
                return CupertinoButton(
                  onPressed: () {},
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            FileImage(Globals.allContact[i].image as File),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Globals.allContact[i].fullName,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle,
                            ),
                            Text(
                              "+91 ${Globals.allContact[i].phoneNumber}",
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle
                                  .copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Icon(
                          CupertinoIcons.phone,
                          color: CupertinoColors.activeGreen,
                        ),
                        onPressed: () async {
                          Uri url = Uri.parse(
                              "tel:+91${Globals.allContact[i].phoneNumber}");
                          await launchUrl(url);
                        },
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    CupertinoIcons.person,
                    size: 200,
                  ),
                  Text(
                    "You have no Chat Yet!!!",
                    style: TextStyle(
                      fontSize: 21,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
