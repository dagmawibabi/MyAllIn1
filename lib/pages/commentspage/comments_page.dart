// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/config/config.dart';
import 'package:myallin1/pages/chatpage/message_input_field.dart';
import 'package:myallin1/pages/commentspage/comments.dart';
import 'package:myallin1/pages/components/error_messages.dart';
import 'package:myallin1/pages/postspage/posts.dart';
import 'package:http/http.dart' as http;

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
  String baseURL = Config.baseUrl;
  bool gettingComments = true;
  bool isCommenting = false;
  List comments = [];
  TextEditingController textController = TextEditingController();

  void getCommnets() async {
    var route = "$baseURL/posts/getPostComments/" + widget.post["_id"];
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    dynamic resultsJSON = jsonDecode(results.body);
    List commentsRaw = resultsJSON;
    comments = commentsRaw.toList().reversed.toList();
    gettingComments = false;
    setState(() {});
  }

  void commentOnPost() async {
    isCommenting = true;
    setState(() {});

    var newComment = {
      "fullname": widget.currentUser["fullname"],
      "username": widget.currentUser["username"],
      "postID": widget.post["_id"],
      "content": textController.text.toString().trim(),
    };
    textController.clear();

    var route = "$baseURL/interactions/commentOnPost";

    var url = Uri.parse(route);
    var jsonFormat = jsonEncode(newComment);
    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonFormat,
    );

    getCommnets();

    isCommenting = false;
    setState(() {});
  }

  void likeUnlikeComments(dynamic comment) async {
    var newComment = {
      "commentID": comment["_id"],
      "likedBy": widget.currentUser["username"],
    };
    var route = "$baseURL/interactions/likeUnlikeComments";

    var url = Uri.parse(route);
    var jsonFormat = jsonEncode(newComment);
    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonFormat,
    );
    getCommnets();
  }

  void deleteComment(String commentID) async {
    var route = "$baseURL/interactions/deleteComment/" +
        widget.post["_id"] +
        "/" +
        commentID;
    var url = Uri.parse(route);
    await http.get(url);
    getCommnets();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCommnets();
  }

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
            extended: true,
            clickable: false,
          ),

          SizedBox(height: 0.0),

          MessageInputField(
            maxLines: 4,
            showAttachIcon: false,
            hintText: "Type comment ...",
            backgroundColor: Colors.grey[900]!.withOpacity(0.15),
            sendFunction: commentOnPost,
            textController: textController,
            sendFunctionLoading: isCommenting,
          ),

          SizedBox(height: 20.0),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Comments",
                  style: TextStyle(
                    color: Colors.grey[200]!,
                    fontSize: 18.0,
                  ),
                ),
                Text(
                  comments.length.toString(),
                  style: TextStyle(
                    color: Colors.grey[200]!,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.0),

          comments.isEmpty == true && gettingComments == false
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ErrorMessages(
                      title: "No Comments",
                      body: "There are no comments on this post.",
                      color: Colors.grey[600]!,
                      height: 110.0,
                      marginVertical: 50.0,
                      backgroundColor: Colors.grey[900]!.withOpacity(0.15),
                    ),
                  ],
                )
              : Container(),

          gettingComments == true
              ? Container(
                  height: 200.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Colors.grey[400]!,
                        strokeWidth: 1.0,
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        "Getting Comments",
                        style: TextStyle(
                          color: Colors.grey[800]!,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  child: Column(
                    children: [
                      for (var eachComment in comments)
                        Comments(
                          commentObject: eachComment,
                          currentUser: widget.currentUser,
                          likeUnlikeComments: likeUnlikeComments,
                          deleteComment: deleteComment,
                        ),
                    ],
                  ),
                ),

          // End of Page
          SizedBox(height: 200.0),
        ],
      ),
    );
  }
}
