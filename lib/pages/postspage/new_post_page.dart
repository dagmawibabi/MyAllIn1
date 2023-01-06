// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/components/profile_bar.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({
    super.key,
    required this.currentUser,
    required this.newPostFunction,
  });

  final Map currentUser;
  final Function newPostFunction;

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  TextEditingController postContentController = TextEditingController();
  bool isPosting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Post",
        ),
        actions: [
          isPosting == true
              ? Container(
                  // width: 20.0,
                  // height: 20.0,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: CircularProgressIndicator(),
                )
              : Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    border: Border.all(
                      color: Colors.grey[800]!,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      isPosting = true;
                      setState(() {});
                      Map newPostObject = {
                        "fullname": widget.currentUser["fullname"],
                        "username": widget.currentUser["username"],
                        "content": postContentController.text.trim(),
                        "hidden": false,
                      };
                      await widget.newPostFunction(newPostObject);
                      isPosting = false;
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Post",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: Colors.grey[900]!.withOpacity(0.5),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: TextField(
              controller: postContentController,
              maxLength: 1000,
              maxLines: 100,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: InputBorder.none,
                hintText: "What would you like to post",
                counterStyle: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900]!.withOpacity(0.5),
                  border: Border.all(
                    color: Colors.grey[800]!,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Ionicons.camera_outline,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Ionicons.image_outline,
                      ),
                      onPressed: () {},
                    ),
                    // IconButton(
                    //   icon: Icon(
                    //     Ionicons.attach_outline,
                    //   ),
                    //   onPressed: () {},
                    // ),
                    IconButton(
                      icon: Icon(
                        Ionicons.eye_off_outline,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Ionicons.warning_outline,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
