// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myallin1/config/config.dart';
import 'package:myallin1/pages/notificationpage/notifications.dart';
import 'package:http/http.dart' as http;

class NotificationPage extends StatefulWidget {
  const NotificationPage({
    super.key,
    this.currentUser,
  });

  final dynamic currentUser;

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String baseURL = Config.baseUrl;
  bool notificationLoading = true;
  List notifications = [];

  void getNotifications() async {
    // notificationLoading = true;
    // setState(() {});

    var notificationRequest = {
      "username": widget.currentUser["username"],
    };
    var route = "$baseURL/notifications/getNotifications";
    var url = Uri.parse(route);
    var jsonFormat = jsonEncode(notificationRequest);
    var notificationsRaw = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonFormat,
    );
    notifications = jsonDecode(notificationsRaw.body);
    notifications = notifications.reversed.toList();
    notificationLoading = false;
    setState(() {});
  }

  void readAllNotifications() async {
    var route = "$baseURL/notifications/readAllNotifications/" +
        widget.currentUser["username"];
    var url = Uri.parse(route);
    await http.get(url);
    getNotifications();
  }

  void readNotifications(notificationID) async {
    var readNotification = {
      "notificationID": notificationID,
    };
    var route = "$baseURL/notifications/readNotifications";
    var url = Uri.parse(route);
    var jsonFormat = jsonEncode(readNotification);
    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonFormat,
    );
    getNotifications();
  }

  // Get Feed Polling
  void getNotificationPolling() async {
    Timer.periodic(Duration(seconds: 1), (time) {
      getNotifications();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotificationPolling();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
        ),
        actions: [
          IconButton(
            onPressed: () {
              readAllNotifications();
            },
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
            child: notificationLoading
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.grey[500],
                          strokeWidth: 2.0,
                        ),
                        SizedBox(height: 25.0),
                        Text(
                          "Getting Notifications",
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  )
                : notifications.length == 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 100.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You have no notifications",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, top: 2.0, bottom: 5.0),
                            child: Text(
                              "Recent",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                          for (var eachNotification in notifications)
                            GestureDetector(
                              onTap: () =>
                                  {readNotifications(eachNotification["_id"])},
                              child: Notifications(
                                type: 0,
                                notificationObject: eachNotification,
                              ),
                            ),
                        ],
                      ),
          ),

          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
          //   padding: EdgeInsets.symmetric(vertical: 5.0),
          //   decoration: BoxDecoration(
          //     color: Colors.grey[900]!.withOpacity(0.2),
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(20.0),
          //     ),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Padding(
          //         padding:
          //             const EdgeInsets.only(left: 20.0, top: 2.0, bottom: 5.0),
          //         child: Text(
          //           "Today",
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 16.0,
          //           ),
          //         ),
          //       ),
          //       Notifications(type: 1),
          //       Notifications(type: 2),
          //       Notifications(type: 1),
          //       Notifications(type: 2),
          //     ],
          //   ),
          // ),

          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
          //   padding: EdgeInsets.symmetric(vertical: 2.0),
          //   decoration: BoxDecoration(
          //     color: Colors.grey[900]!.withOpacity(0.2),
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(20.0),
          //     ),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Padding(
          //         padding:
          //             const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 5.0),
          //         child: Text(
          //           "Yesterday",
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 16.0,
          //           ),
          //         ),
          //       ),
          //       Notifications(type: 2),
          //       Notifications(type: 2),
          //       Notifications(type: 1),
          //       Notifications(type: 1),
          //       Notifications(type: 2),
          //     ],
          //   ),
          // ),

          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
          //   padding: EdgeInsets.symmetric(vertical: 2.0),
          //   decoration: BoxDecoration(
          //     color: Colors.grey[900]!.withOpacity(0.2),
          //     borderRadius: BorderRadius.all(
          //       Radius.circular(20.0),
          //     ),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Padding(
          //         padding:
          //             const EdgeInsets.only(left: 20.0, top: 10.0, bottom: 5.0),
          //         child: Text(
          //           "Older",
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 16.0,
          //           ),
          //         ),
          //       ),
          //       Notifications(type: 2),
          //       Notifications(type: 2),
          //       Notifications(type: 1),
          //       Notifications(type: 1),
          //       Notifications(type: 2),
          //     ],
          //   ),
          // ),

          // End of Page
          SizedBox(height: 200.0),
        ],
      ),
    );
  }
}
