// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../components/smallPFP.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key, required this.type});

  final int type;

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.grey[900]!.withOpacity(0.5),
          // border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            bottomLeft: Radius.circular(20.0),
            topRight: Radius.circular(widget.type == 1 ? 20.0 : 5.0),
            bottomRight: Radius.circular(widget.type == 1 ? 20.0 : 5.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SmallPFP(),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Babi Dagmawi",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 3.0),
                        Text(
                          widget.type == 1
                              ? "started following you."
                              : "likes your post.",
                          style: TextStyle(
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.0),
                    Text(
                      "2m ago",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            widget.type == 1
                ? TextButton(
                    onPressed: () {},
                    child: Text(
                      "Follow",
                      style: TextStyle(
                        color: Colors.greenAccent,
                      ),
                    ),
                  )
                : Container(
                    clipBehavior: Clip.hardEdge,
                    width: 40.0,
                    height: 40.0,
                    margin: EdgeInsets.only(right: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      // border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: Image.asset(
                      "assets/images/me.jpg",
                      // width: 32.0,
                      fit: BoxFit.cover,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
