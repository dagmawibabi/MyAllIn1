// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
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
          TextButton(
            onPressed: () {},
            child: Text(
              "Post",
              style: TextStyle(),
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
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: InputBorder.none,
                hintText: "What would you like to post",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
