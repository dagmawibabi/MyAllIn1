import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myallin1/config/config.dart';
import 'package:myallin1/model/userProfile.dart';
import 'package:myallin1/pages/homepage/homepage.dart';
import 'package:myallin1/pages/signuppage/login_page.dart';
import 'package:myallin1/pages/signuppage/signup_page.dart';
import 'package:http/http.dart' as http;

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  // Globals
  String baseURL = Config.baseUrl;
  bool login = true;
  bool fullnameError = false;
  bool usernameError = false;
  bool passwordError = false;
  bool alreadyLoggedIn = false;

  void switchPage() {
    login = !login;
    setState(() {});
  }

  void loginAccount(
      String username, String password, bool rememberLogin) async {
    var route = "$baseURL/authentication/login";
    var url = Uri.parse(route);
    var loginObject = {"username": username, "password": password};
    var jsonFormat = jsonEncode(loginObject);
    var result = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonFormat,
    );
    usernameError = false;
    passwordError = false;

    if (result.body == "Username Not Found") {
      usernameError = true;
      setState(() {});
    } else if (result.body == "Wrong Account Password") {
      passwordError = true;
      setState(() {});
    } else {
      var currentUser = jsonDecode(result.body);
      if (rememberLogin == true) {
        saveLoggedInUser(currentUser);
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            currentUser: currentUser,
          ),
        ),
      );
    }
  }

  void quickLogin() async {}

  void signupAccount(String fullname, String username, String password) async {
    var route = "$baseURL/authentication/signup";
    var url = Uri.parse(route);
    var signUpObject = {
      "fullname": fullname,
      "username": username,
      "password": password
    };
    var jsonFormat = jsonEncode(signUpObject);
    var result = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonFormat,
    );
    fullnameError = false;
    usernameError = false;
    passwordError = false;

    if (result.body == "Username already exists") {
      usernameError = true;
      setState(() {});
    } else {
      var currentUser = jsonDecode(result.body);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            currentUser: currentUser,
          ),
        ),
      );
    }
  }

  void saveLoggedInUser(currentUser) async {
    Box userProfileBox = await Hive.openBox("UserProfiles");
    UserProfile loggedInUser = UserProfile()
      ..verified = currentUser["verified"]
      ..fullname = currentUser["fullname"]
      ..username = currentUser["username"]
      ..password = currentUser["password"]
      ..profilepic = currentUser["profilepic"]
      ..phone = currentUser["phone"]
      ..email = currentUser["email"]
      ..bio = currentUser["bio"]
      ..posts = currentUser["posts"]
      ..followers = currentUser["followers"]
      ..following = currentUser["following"]
      ..communities = currentUser["communities"];
    await userProfileBox.put("loggedInUser", loggedInUser);
  }

  void getSavedLogin() async {
    Box userProfileBox = await Hive.openBox("UserProfiles");
    // If there is a logged in user
    if (userProfileBox.get("loggedInUser") != null) {
      alreadyLoggedIn = true;
      setState(() {});
      print("ONE LOGGED IN USER!");
      UserProfile abc = await userProfileBox.get("loggedInUser");
      loginAccount(abc.username, abc.password, true);
    } else {
      print("NO LOGGED IN USERS!");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSavedLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: alreadyLoggedIn == true
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 1.0,
              ),
            )
          : ListView(
              children: [
                login
                    ? LoginPage(
                        switchPage: switchPage,
                        loginAccount: loginAccount,
                        usernameError: usernameError,
                        passwordError: passwordError,
                      )
                    : SignUpPage(
                        switchPage: switchPage,
                        signupAccount: signupAccount,
                        fullnameError: fullnameError,
                        usernameError: usernameError,
                        passwordError: passwordError,
                      ),
              ],
            ),
    );
  }
}
