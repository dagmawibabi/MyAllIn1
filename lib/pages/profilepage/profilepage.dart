// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/config/config.dart';
import 'package:myallin1/pages/bottomsheets/accounts_list_bottom_sheet.dart';
import 'package:myallin1/pages/imageViewerPage/image_viewer_page.dart';
import 'package:myallin1/pages/profilepage/profile_details.dart';
import 'package:myallin1/pages/signuppage/loginsignup.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.profile});

  final Map profile;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String baseURL = Config.baseUrl;
  Map profile = {};
  List following = [];
  List followers = [];

  void getProfile() async {
    profile = widget.profile;
    setState(() {});

    var route = "$baseURL/profile/getprofile/" + widget.profile["username"];
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    dynamic resultsJSON = jsonDecode(results.body);
    profile = resultsJSON["profile"];

    setState(() {});
  }

  void getFollowing() async {
    var route =
        "$baseURL/profile/getAllFollowers/" + widget.profile["username"];
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    dynamic resultsJSON = jsonDecode(results.body);
    followers = resultsJSON;
  }

  void getFollowers() async {
    var route =
        "$baseURL/profile/getAllFollowing/" + widget.profile["username"];
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    dynamic resultsJSON = jsonDecode(results.body);
    following = resultsJSON;
  }

  void showFollowingOrFollowers(title, accountList) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 0),
      constraints: BoxConstraints(
        // minHeight: MediaQuery.of(context).size.height * 0.6,
        maxHeight: (MediaQuery.of(context).size.height * 0.8),
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return AccountsListBottomSheet(
          listOfAccounts: accountList,
          currentUser: widget.profile,
          listTitle: title,
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
    getFollowing();
    getFollowers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: Icon(
              Icons.dark_mode_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.qr_code,
            ),
          ),
          IconButton(
            onPressed: () {
              // Navigator.popAndPushNamed(context, "loginSignup");
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginSignup()),
                (route) => false,
              );
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
        child: ListView(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageViewerPage(
                          isNetworkImage: true,
                          networkImage: profile["profilepic"],
                          title: profile["username"],
                        ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: "profilepic",
                    child: Container(
                      height: 400.0,
                      width: double.infinity,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: profile["profilepic"],
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: Colors.grey[800]!,
                          strokeWidth: 2.0,
                        ),
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Icon(
                          Icons.error_outline,
                        ),
                      ),
                      // Image.network(
                      //   profile["profilepic"],
                      //   // "assets/images/me2.jpg",
                      // ),
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
                                    Row(
                                      children: [
                                        Text(
                                          profile["fullname"].toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        SizedBox(width: 5.0),
                                        Icon(
                                          Icons.verified,
                                          color: Colors.lightBlue,
                                          size: 18.0,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2.0),
                                    Text(
                                      "@" +
                                          profile["username"]
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
                                  profile["posts"].toString(),
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
                            GestureDetector(
                              onTap: () {
                                showFollowingOrFollowers(
                                  "Followers",
                                  followers,
                                );
                              },
                              child: Column(
                                children: [
                                  Text(
                                    profile["followers"].length.toString(),
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
                            ),
                            GestureDetector(
                              onTap: () {
                                showFollowingOrFollowers(
                                  "Following",
                                  following,
                                );
                              },
                              child: Column(
                                children: [
                                  Text(
                                    profile["following"].length.toString(),
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
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.0),
                      ProfileDetails(
                        icon: Icons.phone_outlined,
                        label: "phone number",
                        content: profile["phone"],
                      ),
                      ProfileDetails(
                        icon: Icons.alternate_email_outlined,
                        label: "email",
                        content: profile["email"],
                      ),
                      ProfileDetails(
                        icon: Icons.format_quote_rounded,
                        label: "bio",
                        content: profile["bio"],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
