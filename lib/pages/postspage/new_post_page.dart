// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/components/profile_bar.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key, required this.currentUser});

  final Map currentUser;

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Post",
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              border: Border.all(
                color: Colors.grey[800]!,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                "Post",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            // color: Colors.grey[900],
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: ProfileBar(
              profile: widget.currentUser,
              widget: Container(),
            ),
          ),
          Container(
            height: 250.0,
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
            decoration: BoxDecoration(
              color: Colors.grey[900]!.withOpacity(0.5),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: InputBorder.none,
                hintText: "What would you like to post",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900]!.withOpacity(0.5),
                  border: Border.all(
                    color: Colors.grey[800]!,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Ionicons.camera_outline,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Ionicons.image_outline,
                      ),
                      onPressed: () {},
                    ),
                    // IconButton(
                    //   icon: Icon(
                    //     Ionicons.attach_outline,
                    //   ),
                    //   onPressed: () {},
                    // ),
                    IconButton(
                      icon: Icon(
                        Ionicons.eye_off_outline,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Ionicons.warning_outline,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}