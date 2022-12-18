// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/commentspage/comments_page.dart';
import 'package:myallin1/pages/components/profile_bar.dart';
import 'package:myallin1/pages/likeslistpage/likes_list_page.dart';
import 'package:http/http.dart' as http;

class Posts extends StatefulWidget {
  const Posts({
    super.key,
    this.borderRadius = 2.0,
    this.showPic = false,
    this.interactions = true,
    required this.post,
    required this.currentUser,
  });

  final double borderRadius;
  final bool showPic;
  final bool interactions;
  final Map post;
  final Map currentUser;

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  String baseURL = "https://dagmawibabi.com/philomena";
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.5),
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
          ProfileBar(
            profile: {
              "profilepic":
                  "assets/images/me.jpg", // widget.post["profilepic"],
              "fullname": widget.post["fullname"],
              "username": widget.post["username"],
            },
          ),
          SizedBox(height: 10.0),
          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                  child: Text(
                    widget.post["content"].toString().trim(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          onPressed: () {},
                          icon: Icon(
                            Ionicons.share_outline,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
