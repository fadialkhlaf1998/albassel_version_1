import 'package:albassel_version_1/app_localization.dart';
import 'package:albassel_version_1/const/app.dart';
import 'package:albassel_version_1/const/global.dart';
import 'package:albassel_version_1/view/intro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:math';

import 'package:get/get.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';

import 'firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:  'This channel is used for important notifications.', // description
  importance: Importance.max,
);
///final from Fadi Alkhlaf
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackhroundHadler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('backgrounf message ${message.messageId}');
}


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  TabbySDK().setup(
    withApiKey: '',
    environment: Environment.production,
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackhroundHadler);
  // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    sound: true,
    alert: true,
    badge: true,
  );

  runApp(const MyApp());

}
//final 2.0.0+6
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
      Get.updateLocale(Locale(language));
    });
    FirebaseMessaging.instance.getToken().then((value) {
      setState(() {
        if(value!=null){
          Global.firebase_token = value;
        }
      });
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      RemoteNotification notification = message.notification!;
      AndroidNotification androd = message.notification!.android!;

      if(notification != null && androd !=null){
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  playSound: true,
                  icon: "@mipmap/ic_launcher"
              )
          ),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            useMaterial3: false,
            // colorScheme: ColorScheme.fromSeed(seedColor: App.orange),
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
