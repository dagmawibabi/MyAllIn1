// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/components/roundedButton.dart';
import 'package:myallin1/pages/components/roundedInputBox.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
    this.switchPage,
    this.signupAccount,
  });

  final dynamic switchPage;
  final dynamic signupAccount;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[900],
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          RoundedInputBox(
            hintText: "Fullname",
            hintTextColor: Colors.grey,
            suffixIcon: Ionicons.person_outline,
            suffixIconColor: Colors.grey[400],
          ),
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
          RoundedInputBox(
            hintText: "Confirm",
            hintTextColor: Colors.grey,
            suffixIcon: Icons.lock_outline,
            suffixIconColor: Colors.grey[400],
          ),
          RoundedButton(
            text: "Sign Up",
            clickFunction: widget.signupAccount,
          ),
          SizedBox(height: 25.0),
          TextButton(
            onPressed: () {
              widget.switchPage();
            },
            child: Text("Already have an account? Login."),
          ),
          Spacer(),
          Spacer(),
        ],
      ),
    );
  }
}
