import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/components/rounded_icon_labeled_button.dart';
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
                    RoundedIconLabeledButton(
                      icon: Icons.block_outlined,
                      label: "Block",
                      color: Colors.blueAccent,
                    ),
                    RoundedIconLabeledButton(
                      icon: Icons.report_gmailerrorred,
                      label: "Report",
                      color: Colors.yellowAccent,
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
                            child: RoundedIconLabeledButton(
                              icon: Ionicons.eye_off_outline,
                              label: "Hide",
                              color: Colors.orange,
                              isLoading: isDeleting,
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              isDeleting = true;
                              setState(() {});
                              await widget.deletePost(widget.postObject);
                              Navigator.pop(context);
                            },
                            child: RoundedIconLabeledButton(
                              icon: Icons.delete_forever_outlined,
                              label: "Delete",
                              color: Colors.redAccent,
                              isLoading: isDeleting,
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
