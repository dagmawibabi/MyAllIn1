// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/components/rounded_button.dart';
import 'package:myallin1/pages/components/rounded_input_box.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
    this.switchPage,
    this.signupAccount,
    this.fullnameError,
    this.usernameError,
    this.passwordError,
  });

  final dynamic switchPage;
  final dynamic signupAccount;
  final dynamic fullnameError;
  final dynamic usernameError;
  final dynamic passwordError;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
            controller: fullnameController,
          ),
          widget.fullnameError
              ? Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                  child: Text(
                    "Fullname Error",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              : Container(),
          RoundedInputBox(
            hintText: "Username",
            hintTextColor: Colors.grey,
            suffixIcon: Ionicons.link_outline,
            suffixIconColor: Colors.grey[400],
            controller: usernameController,
          ),
          widget.usernameError
              ? Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                  child: Text(
                    "Username Already Exists",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              : Container(),
          RoundedInputBox(
            hintText: "Password",
            hintTextColor: Colors.grey,
            suffixIcon: Icons.lock_open_outlined,
            suffixIconColor: Colors.grey[400],
            controller: passwordController,
          ),
          widget.passwordError
              ? Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                  child: Text(
                    "Password Error",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              : Container(),
          RoundedInputBox(
            hintText: "Confirm",
            hintTextColor: Colors.grey,
            suffixIcon: Icons.lock_outline,
            suffixIconColor: Colors.grey[400],
            controller: confirmPasswordController,
          ),
          widget.passwordError
              ? Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                  child: Text(
                    "Passwords did not match",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              : Container(),
          RoundedButton(
            text: "Sign Up",
            clickFunction: () => {
              widget.signupAccount(
                fullnameController.text.toString().trim(),
                usernameController.text.toString().trim(),
                passwordController.text.toString().trim(),
              ),
            },
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
