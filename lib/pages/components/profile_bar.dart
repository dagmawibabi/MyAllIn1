// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'small_pfp.dart';

class ProfileBar extends StatefulWidget {
  const ProfileBar({super.key, required this.profile, this.widget});

  final Map profile;
  final dynamic widget;

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
            // Profile Pic
            SmallPFP(
              pic: widget.profile["profilepic"],
            ),
            SizedBox(width: 10.0),
            // Name and Username
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.profile["fullname"].toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.profile["username"].toString().toLowerCase(),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
        widget.widget ??
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert_outlined,
                color: Colors.grey,
              ),
            ),
      ],
    );
  }
}
