// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../components/small_pfp.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.2),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SmallPFP(
                    pic: "assets/images/me.jpg",
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dagmawi Babi",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "@DagmawiBabi",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "4m ago",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[800]!,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Text(
            "This is the first comment on this post. Cool pixel picture bruh so cool!",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey[200]!,
            ),
          ),
        ],
      ),
    );
  }
}
