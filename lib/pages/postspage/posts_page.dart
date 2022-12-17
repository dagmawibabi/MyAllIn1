// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myallin1/pages/postspage/posts.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({
    super.key,
    required this.feed,
    required this.currentUser,
  });

  final List feed;
  final Map currentUser;

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Start of Page
        SizedBox(height: 10.0),

        // widget.feed.map((item) => new Text(item)).toList());

        for (var eachPost in widget.feed)
          Posts(
            post: eachPost,
            currentUser: widget.currentUser,
          ),

        // End of Page
        SizedBox(height: 200.0),
      ],
    );
  }
}
