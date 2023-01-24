import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:myallin1/pages/bottomsheets/accounts_list_bottom_sheet.dart';
import 'package:myallin1/pages/imageViewerPage/image_viewer_page.dart';
import 'package:myallin1/pages/postspage/posts.dart';

class OthersProfilePage extends StatefulWidget {
  const OthersProfilePage({
    super.key,
    required this.fullname,
    required this.username,
    required this.profilepic,
    required this.currentUser,
  });

  final String fullname;
  final String username;
  final String profilepic;
  final Map currentUser;

  @override
  State<OthersProfilePage> createState() => _OthersProfilePageState();
}

class _OthersProfilePageState extends State<OthersProfilePage> {
  var baseURL = Config.baseUrl;
  bool profileLoading = true;
  List following = [];
  List followers = [];
  bool isFollowing = false;
  bool isFollowUnfollowing = false;
  dynamic profile;

  Future<void> getProfile() async {
    var route = "$baseURL/profile/getprofile/" + widget.username;
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    profile = jsonDecode(results.body);

    profileLoading = false;
    await getFollowing();
    await getFollowers();
    setState(() {});
  }

  Future<void> getFollowing() async {
    var route = "$baseURL/profile/getAllFollowing/" + widget.username;
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    dynamic resultsJSON = jsonDecode(results.body);
    following = resultsJSON;
    // print(following);
  }

  Future<void> getFollowers() async {
    var route = "$baseURL/profile/getAllFollowers/" + widget.username;
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    dynamic resultsJSON = jsonDecode(results.body);
    followers = resultsJSON;
    isFollowing = false;
    for (var eachFollower in followers) {
      if (eachFollower["username"] == widget.currentUser["username"]) {
        isFollowing = true;
      }
    }
    // print(followers);
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
          currentUser: profile["profile"],
          listTitle: title,
        );
      },
    );
  }

  Future<void> followUnfollow() async {
    isFollowUnfollowing = true;
    setState(() {});
    var route = "$baseURL/interactions/followUnfollowuser/" +
        widget.currentUser["username"] +
        "/" +
        widget.username;
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    // await getFollowers();
    await getProfile();
    isFollowUnfollowing = false;
    setState(() {});
    // dynamic resultsJSON = jsonDecode(results.body);
    // followers = resultsJSON;
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
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 13.0),
            child: isFollowUnfollowing == true
                ? Container(
                    width: 30.0,
                    child: CircularProgressIndicator(
                      color: Colors.grey[700]!,
                      strokeWidth: 2.0,
                    ),
                  )
                : ElevatedButton(
                    child: Text(
                      isFollowing == true ? "Unfollow" : "Follow",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () async {
                      await followUnfollow();
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                        Size(100.0, 10.0),
                      ),
                    ),
                  ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Ionicons.paper_plane_outline,
            ),
          ),
        ],
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
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageViewerPage(
                                    isNetworkImage: false,
                                    networkImage: profile["profile"]
                                        ["profilepic"],
                                    title: profile["profile"]["username"],
                                  ),
                                ),
                              );
                            },
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
              SizedBox(height: 10.0),

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
                            profileLoading == true
                                ? "~"
                                : profile["profile"]["followers"]
                                    .length
                                    .toString(),
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
                            profileLoading == true
                                ? "~"
                                : profile["profile"]["following"]
                                    .length
                                    .toString(),
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
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 30.0),
              SizedBox(height: 10.0),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       width: 130.0,
              //       padding:
              //           EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
              //       decoration: BoxDecoration(
              //         color: Colors.lightBlueAccent,
              //         borderRadius: BorderRadius.all(
              //           Radius.circular(5.0),
              //         ),
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Icon(
              //             Icons.person_add_alt_1_outlined,
              //             color: Colors.black,
              //           ),
              //           SizedBox(width: 10.0),
              //           Text(
              //             "Follow",
              //           ),
              //         ],
              //       ),
              //     ),
              //     SizedBox(width: 6.0),
              //     Container(
              //       width: 130.0,
              //       padding:
              //           EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
              //       decoration: BoxDecoration(
              //         color: Colors.lightGreenAccent,
              //         borderRadius: BorderRadius.all(
              //           Radius.circular(5.0),
              //         ),
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Icon(
              //             Ionicons.paper_plane_outline,
              //             color: Colors.black,
              //           ),
              //           SizedBox(width: 10.0),
              //           Text(
              //             "Message",
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // SizedBox(height: 20.0),

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
