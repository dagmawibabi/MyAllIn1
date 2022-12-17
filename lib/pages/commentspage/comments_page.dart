// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:myallin1/pages/commentspage/comments.dart';
import 'package:myallin1/pages/postspage/posts.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({
    super.key,
    this.post,
    required this.currentUser,
  });

  final dynamic post;
  final Map currentUser;

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comments",
        ),
      ),
      body: ListView(
        children: [
          Posts(
            currentUser: widget.currentUser,
            interactions: true,
            post: widget.post,
          ),

          Comments(),
          Comments(),
          Comments(),
          Comments(),

          // End of Page
          SizedBox(height: 200.0),
        ],
      ),
    );
  }
}
