import 'package:flutter/material.dart';
import 'package:myallin1/pages/signuppage/login_page.dart';
import 'package:myallin1/pages/signuppage/signup_page.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  bool login = true;
  void switchPage() {
    login = !login;
    setState(() {});
  }

  void loginAccount() {
    Navigator.pushNamed(context, "home");
  }

  void signupAccount() {
    Navigator.pushNamed(context, "home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: login
          ? LoginPage(
              switchPage: switchPage,
              loginAccount: loginAccount,
            )
          : SignUpPage(
              switchPage: switchPage,
              signupAccount: signupAccount,
            ),
    );
  }
}
