// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/chatpage/chat_room_page.dart';
import 'package:myallin1/pages/components/small_pfp.dart';
import 'package:myallin1/pages/profilepage/others_profile_page.dart';

class Chats extends StatefulWidget {
  const Chats({
    super.key,
    this.borderRadius = 2.0,
    required this.chatObject,
    required this.currentUsername,
    required this.backgroundColor,
    required this.currentUser,
  });

  final Map chatObject;
  final String currentUsername;
  final double borderRadius;
  final Color backgroundColor;
  final Map currentUser;

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatRoomPage(
              currentUsername: widget.currentUsername,
              chatObject: widget.chatObject,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
        margin: EdgeInsets.only(
          bottom: 3.0,
        ),
        decoration: BoxDecoration(
          color: widget.backgroundColor.withOpacity(0.2),
          // border: Border.all(
          //   color: Colors.black,
          // ),
          borderRadius: BorderRadius.circular(
            widget.borderRadius,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // PFP , Name , Username
            Row(
              children: [
                SizedBox(width: 5.0),

                // Profile Pic
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OthersProfilePage(
                          fullname: widget.chatObject["fullname"],
                          username: widget.chatObject["username"],
                          profilepic: widget.chatObject["profilepic"],
                          currentUser: widget.currentUser,
                        ),
                      ),
                    );
                  },
                  child: SmallPFP(
                    netpic: widget.chatObject["profilepic"],
                    size: 35.0,
                  ),
                ),
                SizedBox(width: 10.0),
                // Name and Username
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OthersProfilePage(
                          fullname: widget.chatObject["fullname"],
                          username: widget.chatObject["username"],
                          profilepic: widget.chatObject["profilepic"],
                          currentUser: widget.currentUser,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.chatObject["fullname"],
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 3.0),
                      Text(
                        "@" + widget.chatObject["username"],
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Chat Icon
            IconButton(
              onPressed: () {
                print(widget.chatObject);
              },
              icon: Icon(
                Ionicons.paper_plane_outline,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
