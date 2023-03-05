// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/commentspage/comment_options_bottom_sheet.dart';
import 'package:myallin1/pages/commentspage/comments_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/small_pfp.dart';

class Comments extends StatefulWidget {
  const Comments({
    super.key,
    required this.commentObject,
    required this.currentUser,
    required this.likeUnlikeComments,
    required this.deleteComment,
  });

  final Map commentObject;
  final Map currentUser;
  final Function likeUnlikeComments;
  final Function deleteComment;

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  bool liked = false;
  bool isBookmarked = false;

  void commentOptions() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 0),
      constraints: BoxConstraints(
        // minHeight: MediaQuery.of(context).size.height * 0.6,
        maxHeight: (MediaQuery.of(context).size.height * 0.8),
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) => CommentOptionsBottomSheet(
        deleteComment: widget.deleteComment,
        commentObject: widget.commentObject,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    liked =
        widget.commentObject["likers"].contains(widget.currentUser["username"]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 8.0),
      padding: EdgeInsets.only(left: 10.0, top: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.15),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Row(
                  children: [
                    SmallPFP(
                      netpic: widget.currentUser["profilepic"].toString(),
                      size: 34.0,
                    ),
                    SizedBox(width: 6.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.commentObject["fullname"].toString(),
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "@" + widget.commentObject["username"].toString(),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        DateTime.fromMillisecondsSinceEpoch(
                                widget.commentObject["time"])
                            .toString()
                            .substring(11, 16),
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey[600]!,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        DateTime.fromMillisecondsSinceEpoch(
                                widget.commentObject["time"])
                            .toString()
                            .substring(0, 10),
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey[800]!,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () async {
                      commentOptions();
                      // var postObject = {
                      //   "username":
                      //       widget.post["username"].toString().toLowerCase(),
                      //   "content": widget.post["content"],
                      //   "time": widget.post["time"].toString().toLowerCase(),
                      // };
                      // widget.postOptions(postObject, widget.post);
                    },
                    icon: Icon(
                      Icons.more_vert_outlined,
                      color: Colors.grey[400]!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // SizedBox(height: 10.0),
          // Content
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Linkify(
                      onOpen: (link) {
                        var postedLink = Uri.parse(link.url);
                        launchUrl(
                          postedLink,
                          mode: LaunchMode.externalApplication,
                        );
                      },
                      maxLines: 100,
                      text: widget.commentObject["content"].toString().trim(),
                      style: TextStyle(
                        fontSize: 16.5,
                        color: Colors.grey[300]!,
                        height: 1.4,
                      ),
                      linkStyle: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 14.5,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          liked = !liked;
                          setState(() {});
                          await widget.likeUnlikeComments(widget.commentObject);
                        },
                        icon: Icon(
                          liked ? Ionicons.heart : Ionicons.heart_outline,
                          size: 20.0,
                          color: liked ? Colors.pinkAccent : Colors.white,
                        ),
                      ),
                      Text(
                        widget.commentObject["likeCount"].toString(),
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => CommentsPage(
                          //       currentUser: widget.currentUser,
                          //       post: widget.commentObject,
                          //     ),
                          //   ),
                          // );
                        },
                        icon: Icon(
                          Ionicons.chatbubble_outline,
                          color: Colors.white,
                          size: 16.0,
                        ),
                      ),
                      Text(
                        widget.commentObject["commentCount"].toString(),
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      isBookmarked = !isBookmarked;
                      setState(() {});
                    },
                    child: Icon(
                      isBookmarked == true
                          ? Ionicons.bookmark
                          : Ionicons.bookmark_outline,
                      size: 20.0,
                      color: isBookmarked == true
                          ? Colors.yellow
                          : Colors.grey[400]!,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // widget.postOptions();
                      // share(widget.post);
                    },
                    icon: Icon(
                      Ionicons.share_social_outline,
                      size: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
