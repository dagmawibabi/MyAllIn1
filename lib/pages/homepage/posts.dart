// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/components/smallPFP.dart';

class Posts extends StatefulWidget {
  const Posts({super.key, this.borderRadius = 2.0, this.showPic = false});

  final double borderRadius;
  final bool showPic;

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
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
          // PFP , Name , Username
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Profile Pic
                  SmallPFP(),
                  SizedBox(width: 10.0),
                  // Name and Username
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dagmawi Babi",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "@DagmawiBabi",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          // Content
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                child: Text(
                  "This is the first post in this new amazing social media that will take off. Trust me this is amazing. So gorgeous too.",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
              widget.showPic == false
                  ? Container()
                  : Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(
                          widget.borderRadius,
                        ),
                      ),
                      child: Image.asset(
                        "assets/images/me.jpg",
                      ),
                    ),
            ],
          ),
          // Interactions
          Row(
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
                          onPressed: () {},
                          icon: Icon(
                            Ionicons.heart_outline,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "1.2k",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    // Comments
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Ionicons.chatbubble_outline,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "864",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    // Repost
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Ionicons.repeat_outline,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "256",
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
