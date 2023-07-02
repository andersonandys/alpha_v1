import 'dart:io';

import 'package:alpha/controllers/app_controler.dart';
import 'package:alpha/firebase_options.dart';
import 'package:alpha/screen/dashboard_screen.dart';
import 'package:alpha/screen/home_noconnect_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AwesomeNotifications().initialize(
    null, // Chemin vers l'icône de l'application
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic notifications',
        defaultColor: Colors.blue,
        ledColor: Colors.blue,
        playSound: true,
        enableVibration: true,
      ),
    ],
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appcontroller = Get.put(AppControler());
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    appcontroller.getlangue();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          )),
      home: (FirebaseAuth.instance.currentUser != null)
          ? const DashboardScreen()
          : const HomeNoconnectScreen(),
    );
  }
}
