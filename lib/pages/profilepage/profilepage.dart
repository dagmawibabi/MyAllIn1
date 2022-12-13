// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/profilepage/profile_details.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.profile});

  final Map profile;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.qr_code,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, "loginSignup");
            },
            icon: Icon(
              Ionicons.log_out_outline,
            ),
          ),
        ],
      ),
      body: Container(
        // height: 300.0,
        // width: 300.0,
        // alignment: Alignment.center,
        // width: MediaQuery.of(context).size.width * 0.8,
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: Column(
          children: [
            Hero(
              tag: "profilepic",
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Image.asset(
                  widget.profile["profilepic"],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                color: Colors.grey[900]!.withOpacity(0.2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[850]!.withOpacity(0.3),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[900]!.withOpacity(0.4),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20.0),
                                ),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Ionicons.person_outline,
                                ),
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.profile["fullname"].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  widget.profile["username"]
                                      .toString()
                                      .toLowerCase(),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[900]!.withOpacity(0.4),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100.0),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Ionicons.camera_outline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[900]!.withOpacity(0.4),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              widget.profile["posts"].toString(),
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "posts",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              widget.profile["followers"].toString(),
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "followers",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              widget.profile["following"].toString(),
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "following",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ProfileDetails(
                    icon: Icons.phone_outlined,
                    label: "phone number",
                    content: widget.profile["phone"],
                  ),
                  ProfileDetails(
                    icon: Icons.alternate_email_outlined,
                    label: "email",
                    content: widget.profile["email"],
                  ),
                  ProfileDetails(
                    icon: Icons.format_quote_rounded,
                    label: "bio",
                    content: widget.profile["bio"],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
