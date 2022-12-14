// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/config/config.dart';
import 'package:myallin1/pages/commentspage/comments_page.dart';
import 'package:myallin1/pages/components/profile_bar.dart';
import 'package:myallin1/pages/likeslistpage/likes_list_page.dart';
import 'package:http/http.dart' as http;
import 'package:myallin1/pages/profilepage/others_profile_page.dart';

import '../components/small_pfp.dart';
import '../profilepage/profilepage.dart';

class Posts extends StatefulWidget {
  const Posts({
    super.key,
    this.borderRadius = 2.0,
    this.showPic = false,
    this.interactions = true,
    required this.post,
    required this.currentUser,
    this.extended = false,
    this.clickable = true,
    this.postOptions,
    this.getFeed,
    this.deletePost,
  });

  final double borderRadius;
  final bool showPic;
  final bool interactions;
  final Map post;
  final Map currentUser;
  final bool extended;
  final bool clickable;
  final dynamic postOptions;
  final dynamic getFeed;
  final dynamic deletePost;

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  String baseURL = Config.baseUrl;
  // Like Displie Posts
  void likeDislikePosts(String postID) async {
    var postReq = {
      "postID": postID,
      "likedBy": widget.currentUser["username"],
    };
    var route = "$baseURL/interactions/likeDislikePosts";
    var url = Uri.parse(route);
    var jsonFormat = jsonEncode(postReq);
    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonFormat,
    );
    widget.getFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.2),
        // border: Border.all(
        //   color: Colors.black,
        // ),
        borderRadius: BorderRadius.circular(
          widget.borderRadius,
        ),
      ),
      child: Column(
        children: [
          // PFP Name Username
          // ProfileBar(
          //   profile: {
          //     "profilepic":
          //         "https://dagmawibabi.com/static/media/me.b4b941897136a2959e33.png", // widget.post["profilepic"],
          //     "fullname": widget.post["fullname"],
          //     "username": widget.post["username"],
          //   },
          //   postOptions: widget.postOptions,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // PFP Name Username
              GestureDetector(
                onTap: () {
                  widget.post["username"] == widget.currentUser["username"]
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              profile: widget.currentUser,
                            ),
                          ),
                        )
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OthersProfilePage(
                              fullname: widget.post["fullname"],
                              username: widget.post["username"],
                              profilepic:
                                  "https://dagmawibabi.com/static/media/me.b4b941897136a2959e33.png",
                            ),
                          ),
                        );
                },
                child: Row(
                  children: [
                    SizedBox(width: 5.0),
                    // Profile Pic
                    SmallPFP(
                      netpic:
                          "https://dagmawibabi.com/static/media/me.b4b941897136a2959e33.png",
                      size: 40.0,
                    ),
                    SizedBox(width: 7.0),
                    // Name and Username
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.post["fullname"].toString(),
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey[200]!,
                                fontWeight: FontWeight.bold,
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
                        SizedBox(height: 2.0),
                        Text(
                          "@" +
                              widget.post["username"].toString().toLowerCase(),
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Bookmark and More Post Options
              Row(
                children: [
                  Icon(
                    Ionicons.bookmark_outline,
                    size: 20.0,
                    color: Colors.grey[400]!,
                  ),
                  IconButton(
                    onPressed: () async {
                      var postObject = {
                        "username":
                            widget.post["username"].toString().toLowerCase(),
                        "content": widget.post["content"],
                        "time": widget.post["time"].toString().toLowerCase(),
                      };
                      widget.postOptions(postObject);
                    },
                    icon: Icon(
                      Icons.more_vert_outlined,
                      color: Colors.grey[400]!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 0.0),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  widget.clickable == true
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentsPage(
                              currentUser: widget.currentUser,
                              post: widget.post,
                            ),
                          ),
                        )
                      : () {};
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Text(
                    widget.post["content"].toString().trim(),
                    textAlign: TextAlign.start,
                    maxLines: widget.extended == true ? 100 : 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey[300]!,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
              widget.showPic == false
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentsPage(
                              currentUser: widget.currentUser,
                              post: widget.post,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(
                            widget.borderRadius,
                          ),
                        ),
                        child: Image.asset(
                          widget.post["profilepic"],
                        ),
                      ),
                    ),
            ],
          ),
          // Interactions
          widget.interactions == false
              ? Container()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Like Comment Repost
                    Container(
                      width: 250.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Like Dislike
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  likeDislikePosts(widget.post["_id"]);
                                },
                                icon: Icon(
                                  widget.post["likers"].contains(
                                          widget.currentUser["username"])
                                      ? Ionicons.heart
                                      : Ionicons.heart_outline,
                                  size: 24.0,
                                  color: widget.post["likers"].contains(
                                          widget.currentUser["username"])
                                      ? Colors.pinkAccent
                                      : Colors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LikesListPage(
                                        likers: widget.post["likers"],
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  widget.post["likes"].toString(),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(width: 4.0),

                          // Comments
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CommentsPage(
                                    currentUser: widget.currentUser,
                                    post: widget.post,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CommentsPage(
                                          currentUser: widget.currentUser,
                                          post: widget.post,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Ionicons.chatbubble_outline,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                ),
                                Text(
                                  widget.post["comments"].toString(),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 4.0),

                          // Repost
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "repostslist");
                            },
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "repostslist");
                                  },
                                  icon: Icon(
                                    Ionicons.repeat_outline,
                                    color: Colors.white,
                                    size: 24.0,
                                  ),
                                ),
                                Text(
                                  widget.post["reposts"].toString(),
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Share
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            widget.postOptions();
                          },
                          icon: Icon(
                            Ionicons.share_social_outline,
                            size: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        // IconButton(
                        //   onPressed: () {},
                        //   icon: Icon(
                        //     Ionicons.share_outline,
                        //     size: 20.0,
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
