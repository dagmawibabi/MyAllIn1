// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:myallin1/model/userProfile.dart';
import 'package:myallin1/pages/homepage/homepage.dart';
import 'package:myallin1/pages/notificationpage/notificationpage.dart';
import 'package:myallin1/pages/repostslistpage/reposts_list_page.dart';
import 'package:myallin1/pages/signuppage/loginsignup.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  // Hive
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserProfileAdapter());

  // await Hive.openBox<UserProfile>("UserProfiles");

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

    // Color primaryColor = Color.fromARGB(255, 18, 18, 18);
    Color primaryColor = Color.fromARGB(100, 18, 18, 18);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "loginSignup",
      routes: {
        "loginSignup": (context) => LoginSignup(),
        "home": (context) => HomePage(),
        "notification": (context) => NotificationPage(),
        // "profile": (context) => ProfilePage(),
        // "comments": (context) => CommentsPage(),
        // "likeslist": (context) => LikesListPage(),
        "repostslist": (context) => RepostListPage(),
      },
      // themeMode: ThemeMode.da,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.grey[200],
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey[600]!,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: primaryColor,
        // scaffoldBackgroundColor:
        //     Colors.grey[900]!.withOpacity(0.4), // primaryColor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        textTheme: TextTheme(),
        fontFamily: GoogleFonts.roboto().fontFamily,
        // dialogBackgroundColor: primaryColor,
      ),
    );
  }
}
