// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myallin1/pages/components/small_pfp.dart';

class LikesListPage extends StatefulWidget {
  const LikesListPage({
    super.key,
    required this.likers,
  });

  final List likers;

  @override
  State<LikesListPage> createState() => _LikesListPageState();
}

class _LikesListPageState extends State<LikesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Likes",
        ),
      ),
      body: Column(children: [
        for (dynamic liker in widget.likers)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                SmallPFP(pic: "assets/images/me.jpg"),
                SizedBox(width: 10.0),
                Text(
                  liker.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
      ]),
    );
  }
}
