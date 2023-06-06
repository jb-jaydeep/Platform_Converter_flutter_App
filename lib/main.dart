import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter_flutter_app/providers/providers.dart';
import 'package:platform_converter_flutter_app/views/Android_Platform.dart';
import 'package:platform_converter_flutter_app/views/ios_platform.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => PlatformProvider(),
      ),
    ],
    child: Consumer<PlatformProvider>(
      builder: (context, value, _) => (value.isIos == false)
          ? MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
                colorScheme: const ColorScheme.light(),
              ),
              darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme: const ColorScheme.dark(
                  brightness: Brightness.dark,
                ),
              ),
              themeMode:
                  (Provider.of<PlatformProvider>(context, listen: false).isdark)
                      ? ThemeMode.dark
                      : ThemeMode.light,
              home: const AndroidPlatform(),
            )
          : const CupertinoApp(
              debugShowCheckedModeBanner: false,
              home: IosPlatform(),
            ),
    ),
  ));
}
