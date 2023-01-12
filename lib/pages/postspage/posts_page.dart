// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myallin1/config/config.dart';
import 'package:myallin1/pages/postspage/post_options_bottom_sheet.dart';
import 'package:myallin1/pages/postspage/posts.dart';
import 'package:http/http.dart' as http;

class PostsPage extends StatefulWidget {
  const PostsPage({
    super.key,
    required this.feed,
    required this.currentUser,
    required this.getFeed,
  });

  final List feed;
  final Map currentUser;
  final Function getFeed;

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  var baseURL = Config.baseUrl;

  // Delete Posts
  Future<void> deletePost(Map postObject) async {
    var deletePost = {
      "username": postObject["username"],
      "content": postObject["content"],
      "time": postObject["time"],
    };
    print(deletePost);
    var route = "$baseURL/posts/deletePost";
    var url = Uri.parse(route);
    var jsonFormat = jsonEncode(deletePost);
    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonFormat,
    );
    widget.getFeed();
  }

  // Post Options
  void postOptions(Map postObject) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return PostOptions(
          deletePost: deletePost,
          postObject: postObject,
          currentUser: widget.currentUser,
        );
      },
    );
  }

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
            postOptions: postOptions,
            getFeed: widget.getFeed,
            deletePost: deletePost,
          ),

        // End of Page
        SizedBox(height: 200.0),
      ],
    );
  }
}
