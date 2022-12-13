// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myallin1/pages/postspage/posts.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

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

        Posts(
          showPic: true,
        ),
        Posts(),
        Posts(),
        Posts(),
        Posts(),
        Posts(
          showPic: true,
        ),
        Posts(),
        Posts(),
        Posts(
          showPic: true,
        ),
        Posts(),
        Posts(),
        Posts(),
        // End of Page
        SizedBox(height: 200.0),
      ],
    );
  }
}
