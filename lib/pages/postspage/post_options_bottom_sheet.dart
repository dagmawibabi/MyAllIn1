import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/postspage/posts.dart';

class PostOptions extends StatefulWidget {
  const PostOptions({
    super.key,
    required this.deletePost,
    required this.postObject,
    required this.currentUser,
    required this.post,
  });

  final Function deletePost;
  final Map postObject;
  final Map currentUser;
  final Map post;

  @override
  State<PostOptions> createState() => _PostOptionsState();
}

class _PostOptionsState extends State<PostOptions> {
  bool isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200.0,
      decoration: BoxDecoration(
        // color: Colors.grey[900]!,
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(
            20.0,
          ),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900]!,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.0),

                Text(
                  "Post Options",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10.0),

                // Post Preview
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900]!.withOpacity(0.2),
                    // borderRadius: BorderRadius.all(
                    //   Radius.circular(20.0),
                    // ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Posts(
                    post: widget.post,
                    currentUser: widget.currentUser,
                  ),
                ),
                SizedBox(height: 15.0),

                // Post Block, Report, Hide and Delete
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 18, 18, 18),
                            border: Border.all(
                              color: Colors.blueAccent,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                100.0,
                              ),
                            ),
                          ),
                          child: Icon(
                            Icons.block_outlined,
                            size: 30.0,
                            color: Colors.blueAccent,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "Block",
                          style: TextStyle(
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 18, 18, 18),
                            border: Border.all(
                              color: Colors.yellowAccent,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                100.0,
                              ),
                            ),
                          ),
                          child: Icon(
                            Icons.report_gmailerrorred,
                            size: 30.0,
                            color: Colors.yellowAccent,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "Report",
                          style: TextStyle(
                            color: Colors.yellowAccent,
                          ),
                        ),
                      ],
                    ),
                    widget.currentUser["username"] !=
                            widget.postObject["username"]
                        ? GestureDetector(
                            onTap: () async {
                              // isDeleting = true;
                              // setState(() {});
                              // await widget.deletePost(widget.postObject);
                              // Navigator.pop(context);
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 18, 18, 18),
                                    border: Border.all(
                                      color: Colors.orange,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        100.0,
                                      ),
                                    ),
                                  ),
                                  child: isDeleting == true
                                      ? Container(
                                          child: CircularProgressIndicator(
                                            color: Colors.orange,
                                          ),
                                        )
                                      : Icon(
                                          Ionicons.eye_off_outline,
                                          size: 30.0,
                                          color: Colors.orange,
                                        ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  "Hide",
                                  style: TextStyle(
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              isDeleting = true;
                              setState(() {});
                              await widget.deletePost(widget.postObject);
                              Navigator.pop(context);
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(
                                      isDeleting == true ? 7.5 : 10.0),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 18, 18, 18),
                                    border: Border.all(
                                      color: Colors.redAccent,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        100.0,
                                      ),
                                    ),
                                  ),
                                  child: isDeleting == true
                                      ? Container(
                                          child: CircularProgressIndicator(
                                            color: Colors.redAccent,
                                          ),
                                        )
                                      : Icon(
                                          Icons.delete_forever_outlined,
                                          size: 30.0,
                                          color: Colors.redAccent,
                                        ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
