// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/components/roundedButton.dart';

import '../components/roundedInputBox.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    this.switchPage,
    this.loginAccount,
  });

  final dynamic switchPage;
  final dynamic loginAccount;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[900],
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          RoundedInputBox(
            hintText: "Username",
            hintTextColor: Colors.grey,
            suffixIcon: Ionicons.link_outline,
            suffixIconColor: Colors.grey[400],
          ),
          RoundedInputBox(
            hintText: "Password",
            hintTextColor: Colors.grey,
            suffixIcon: Icons.lock_open_outlined,
            suffixIconColor: Colors.grey[400],
          ),
          RoundedButton(
            text: "Login",
            clickFunction: widget.loginAccount,
          ),
          SizedBox(height: 0.0),
          TextButton(
            onPressed: () {},
            child: Text(
              "Browse Anonymously",
              style: TextStyle(
                color: Colors.orange,
              ),
            ),
          ),
          SizedBox(height: 25.0),
          TextButton(
            onPressed: () {
              widget.switchPage();
            },
            child: Text("Don't have an account? Sign up."),
          ),
          // SizedBox(height: 25.0),
          // Spacer(),
          // RoundedButton(
          //   text: "Browse Anonymous",
          //   backgroundColor: Colors.lightBlueAccent,
          // ),
          Spacer(),
          Spacer(),
        ],
      ),
    );
  }
}
