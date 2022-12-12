// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myallin1/pages/homepage/homepage.dart';
import 'package:myallin1/pages/signuppage/loginpage.dart';
import 'package:myallin1/pages/signuppage/loginsignup.dart';
import 'package:myallin1/pages/signuppage/signuppage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //Colors.grey[200],
        statusBarIconBrightness: Brightness.light,
      ),
    );

    Color primaryColor = Color.fromARGB(255, 18, 18, 18);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "loginSignup",
      routes: {
        "home": (context) => HomePage(),
        "loginSignup": (context) => LoginSignup(),
      },
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
        ),
        scaffoldBackgroundColor: primaryColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.grey[800],
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
    );
  }
}
