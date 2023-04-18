// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/components/rounded_button.dart';

import '../components/rounded_input_box.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    this.switchPage,
    this.loginAccount,
    this.usernameError,
    this.passwordError,
  });

  final dynamic switchPage;
  final dynamic loginAccount;
  final dynamic usernameError;
  final dynamic passwordError;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool savedLogins = false;
  bool rememberLogin = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[900],
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
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
            controller: usernameController,
          ),
          widget.usernameError
              ? Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                  child: Text(
                    "Username Not Found",
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
                    "Wrong Password",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              : Container(),
          RoundedButton(
            text: "Login",
            clickFunction: () => {
              widget.loginAccount(
                usernameController.text.toString().trim(),
                passwordController.text.toString(),
                rememberLogin,
              ),
            },
          ),
          SizedBox(height: 0.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  rememberLogin = !rememberLogin;
                  setState(() {});
                },
                child: Icon(
                  rememberLogin == true
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank_rounded,
                  color: Colors.yellowAccent,
                ),
              ),
              TextButton(
                onPressed: () {
                  rememberLogin = !rememberLogin;
                  setState(() {});
                },
                child: Text(
                  "Keep me logged in",
                  style: TextStyle(
                    color: Colors.yellowAccent,
                    fontWeight: rememberLogin == true
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onLongPress: () {
              savedLogins = !savedLogins;
              setState(() {});
            },
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Browse Anonymously",
                style: TextStyle(
                  color: Colors.orange,
                ),
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
          // Spacer(),
          // RoundedButton(
          //   text: "Browse Anonymous",
          //   backgroundColor: Colors.lightBlueAccent,
          // ),
          Spacer(),
          Spacer(),
          savedLogins == false
              ? Container()
              : Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[900]!.withOpacity(0.3),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Saved Login",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            Size(200.0, 20.0),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey[900]!,
                          ),
                        ),
                        child: Text(
                          "Dagmawi Babi",
                        ),
                        onPressed: () {
                          widget.loginAccount(
                              "dagmawibabi", "dagmawibabi", rememberLogin);
                        },
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(
                            Size(200.0, 20.0),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey[900]!,
                          ),
                        ),
                        child: Text(
                          "Anne Leone",
                        ),
                        onPressed: () {
                          widget.loginAccount("anne", "anne", rememberLogin);
                        },
                      ),
                    ],
                  ),
                ),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }
}
