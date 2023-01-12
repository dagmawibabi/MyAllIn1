// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'small_pfp.dart';

class ProfileBar extends StatefulWidget {
  const ProfileBar({
    super.key,
    required this.profile,
    this.widget,
    this.postOptions,
  });

  final Map profile;
  final dynamic widget;
  final dynamic postOptions;

  @override
  State<ProfileBar> createState() => _ProfileBarState();
}

class _ProfileBarState extends State<ProfileBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(width: 5.0),
            // Profile Pic
            SmallPFP(
              netpic: widget.profile["profilepic"],
              size: 40.0,
            ),
            SizedBox(width: 7.0),
            // Name and Username
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.profile["fullname"].toString(),
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[200]!,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Icon(
                      Icons.verified,
                      color: Colors.lightBlue,
                      size: 16.0,
                    ),
                  ],
                ),
                SizedBox(height: 2.0),
                Text(
                  "@" + widget.profile["username"].toString().toLowerCase(),
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ],
        ),
        widget.widget ??
            Row(
              children: [
                Icon(
                  Ionicons.bookmark_outline,
                  size: 20.0,
                  color: Colors.grey[400]!,
                ),
                IconButton(
                  onPressed: () {
                    var postObject = {
                      "username":
                          widget.profile["username"].toString().toLowerCase(),
                      "content":
                          widget.profile["content"].toString().toLowerCase(),
                      "time": widget.profile["time"].toString().toLowerCase(),
                    };
                    widget.postOptions(postObject);
                  },
                  icon: Icon(
                    Icons.more_vert_outlined,
                    color: Colors.grey[400]!,
                  ),
                ),
              ],
            ),
      ],
    );
  }
}
