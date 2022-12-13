// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:myallin1/pages/commentspage/comments.dart';
import 'package:myallin1/pages/components/small_pfp.dart';
import 'package:myallin1/pages/postspage/posts.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({super.key});

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
            showPic: true,
            interactions: false,
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
