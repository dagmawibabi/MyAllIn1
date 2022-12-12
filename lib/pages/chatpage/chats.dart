// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/components/smallPFP.dart';

class Chats extends StatefulWidget {
  const Chats({super.key, this.borderRadius = 2.0});

  final double borderRadius;

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      margin: EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.5),
        // border: Border.all(
        //   color: Colors.black,
        // ),
        borderRadius: BorderRadius.circular(
          widget.borderRadius,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // PFP , Name , Username
          Row(
            children: [
              // Profile Pic
              SmallPFP(),
              SizedBox(width: 10.0),
              // Name and Username
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dagmawi Babi",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "@DagmawiBabi",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Chat Icon
          IconButton(
            onPressed: () {},
            icon: Icon(
              Ionicons.paper_plane_outline,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
