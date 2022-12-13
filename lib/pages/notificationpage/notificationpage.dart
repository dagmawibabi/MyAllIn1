// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:myallin1/pages/notificationpage/notifications.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.clear_all_outlined,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          // Start of Page
          SizedBox(height: 10.0),

          Container(
            margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
            padding: EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              color: Colors.grey[900]!.withOpacity(0.2),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 2.0, bottom: 5.0),
                  child: Text(
                    "Today",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Notifications(type: 1),
                Notifications(type: 2),
                Notifications(type: 1),
                Notifications(type: 2),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            padding: EdgeInsets.symmetric(vertical: 2.0),
            decoration: BoxDecoration(
              color: Colors.grey[900]!.withOpacity(0.2),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 5.0),
                  child: Text(
                    "Yesterday",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Notifications(type: 2),
                Notifications(type: 2),
                Notifications(type: 1),
                Notifications(type: 1),
                Notifications(type: 2),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            padding: EdgeInsets.symmetric(vertical: 2.0),
            decoration: BoxDecoration(
              color: Colors.grey[900]!.withOpacity(0.2),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 5.0),
                  child: Text(
                    "Older",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Notifications(type: 2),
                Notifications(type: 2),
                Notifications(type: 1),
                Notifications(type: 1),
                Notifications(type: 2),
              ],
            ),
          ),
          // End of Page
          SizedBox(height: 200.0),
        ],
      ),
    );
  }
}
