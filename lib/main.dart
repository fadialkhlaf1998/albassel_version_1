import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/helper/log_in_api.dart';
import 'package:albassel_version_1/view/checkout.dart';
import 'package:albassel_version_1/view/home.dart';
import 'package:albassel_version_1/view/sign_in.dart';
import 'package:albassel_version_1/view/intro.dart';
import 'package:albassel_version_1/view/no_internet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:math';

import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static void set_local(BuildContext context , Locale locale){
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.set_locale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void set_locale(Locale locale){
    setState(() {
      _locale=locale;
    });
  }

  @override
  void initState() {
    super.initState();
    Global.load_language().then((language) {
      setState(() {
        _locale= Locale(language);
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: generateMaterialColor(App.orange),
            fontFamily: "OpenSans"
        ),
        locale: _locale,
        supportedLocales: [Locale('en', ''), Locale('ar', '')],
        localizationsDelegates: const [
          App_Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (local, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == local!.languageCode) {
              Global.lang_code=supportedLocale.languageCode;
              return supportedLocale;
            }
          }

          return supportedLocales.first;
        },

        home: Intro()
      //SignIn(),
      //Intro()
    );
  }
  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));
}
