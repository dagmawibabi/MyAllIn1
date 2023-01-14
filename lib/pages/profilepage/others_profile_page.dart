import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myallin1/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:myallin1/pages/postspage/posts.dart';

class OthersProfilePage extends StatefulWidget {
  const OthersProfilePage({
    super.key,
    required this.fullname,
    required this.username,
    required this.profilepic,
  });

  final String fullname;
  final String username;
  final String profilepic;

  @override
  State<OthersProfilePage> createState() => _OthersProfilePageState();
}

class _OthersProfilePageState extends State<OthersProfilePage> {
  var baseURL = Config.baseUrl;
  bool profileLoading = true;
  dynamic profile;

  void getProfile() async {
    var route = "$baseURL/profile/getprofile/" + widget.username;
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    profile = jsonDecode(results.body);

    profileLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 20.0),
              // PFP Fullname and Username
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  profileLoading == true
                      ? Container(
                          width: 100.0,
                          height: 100.0,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(1000.0),
                            ),
                          ),
                          child: CircularProgressIndicator(
                            color: Colors.blueAccent,
                          ),
                        )
                      : Container(
                          width: 100.0,
                          height: 100.0,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(1000.0),
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: profile["profile"]["profilepic"],
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: Colors.grey[800]!,
                              strokeWidth: 2.0,
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error_outline,
                            ),
                          ),
                          // Image.network(
                          //   profile["profile"]["profilepic"],
                          // ),
                        ),
                  SizedBox(width: 15.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.fullname,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Icon(
                            Icons.verified,
                            color: Colors.lightBlue,
                            size: 16.0,
                          ),
                        ],
                      ),
                      Text(
                        "@" + widget.username,
                        style: TextStyle(
                          color: Colors.grey[300]!,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        profileLoading == true
                            ? "~~~"
                            : profile["profile"]["bio"].toString(),
                        style: TextStyle(
                          color: Colors.grey[300]!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25.0),
              // Profile Stats
              Container(
                margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
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
                          profileLoading == true
                              ? "~"
                              : profile["profile"]["posts"].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          "post",
                          style: TextStyle(
                            color: Colors.grey[500]!,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          profileLoading == true
                              ? "~"
                              : profile["profile"]["followers"].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          "followers",
                          style: TextStyle(
                            color: Colors.grey[500]!,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          profileLoading == true
                              ? "~"
                              : profile["profile"]["following"].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          "following",
                          style: TextStyle(
                            color: Colors.grey[500]!,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                color: Colors.grey[900]!.withOpacity(0.4),
                child: Row(
                  children: [
                    SizedBox(width: 20.0, height: 35.0),
                    Text(
                      "Posts",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey[600]!,
                      ),
                    ),
                  ],
                ),
              ),
              // Posts
              profileLoading == true
                  ? Container(
                      child: CircularProgressIndicator(
                        color: Colors.grey[600]!,
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              SizedBox(height: 10.0),
                              for (var eachPost in profile["posts"])
                                Posts(
                                  post: eachPost,
                                  currentUser: profile["profile"],
                                ),
                              SizedBox(height: 100.0),
                              Text(
                                "End of Posts",
                                style: TextStyle(
                                  color: Colors.grey[800]!,
                                ),
                              ),
                              SizedBox(height: 400.0),
                            ],
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
