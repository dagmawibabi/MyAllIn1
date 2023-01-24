// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/config/config.dart';
import 'package:myallin1/pages/bottomsheets/accounts_list_bottom_sheet.dart';
import 'package:myallin1/pages/chatpage/chat_room_page.dart';
import 'package:myallin1/pages/components/error_messages.dart';

import '../components/rounded_search_input_box.dart';
import 'package:http/http.dart' as http;

import 'chats.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.currentUser,
  });

  final Map currentUser;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController searchTextController = TextEditingController();
  List chats = [];
  List communities = [];
  List availableChats = [];
  String baseURL = Config.baseUrl;
  bool gettingChats = true;
  int currentChatPage = 1;

  void getChats() async {
    var route =
        "$baseURL/privateChats/getChats/" + widget.currentUser["username"];
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    dynamic resultsJSON = jsonDecode(results.body);
    chats = resultsJSON;
    gettingChats = false;
    setState(() {});
  }

  void getChatsPolling() async {
    Timer.periodic(
      Duration(seconds: 5),
      (timer) {
        getChats();
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChats();
    getChatsPolling();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 15.0),
        // Private Chats or Communities
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                currentChatPage = 1;
                setState(() {});
              },
              child: Container(
                width: 150.0,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                // margin: EdgeInsets.symmetric(vertical: 5.0),
                decoration: BoxDecoration(
                  color: currentChatPage == 1
                      ? Colors.lightBlueAccent
                      : Colors.grey[900]!.withOpacity(0.4),
                  // border: Border.all(
                  //   color: Colors.lightBlue.withOpacity(0.4),
                  // ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Ionicons.chatbox_ellipses_outline,
                      size: 18.0,
                      color: currentChatPage == 1 ? Colors.black : Colors.white,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      "Private Chats",
                      style: TextStyle(
                        color:
                            currentChatPage == 1 ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10.0),
            GestureDetector(
              onTap: () {
                currentChatPage = 2;
                setState(() {});
              },
              child: Container(
                width: 150.0,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                // margin: EdgeInsets.symmetric(vertical: 5.0),
                decoration: BoxDecoration(
                  color: currentChatPage == 2
                      ? Colors.lightGreenAccent
                      : Colors.grey[900]!.withOpacity(0.4),
                  // border: Border.all(
                  //   color: Colors.lightBlue.withOpacity(0.4),
                  // ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Ionicons.people_outline,
                      size: 18.0,
                      color: currentChatPage == 2 ? Colors.black : Colors.white,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      "Communities",
                      style: TextStyle(
                        color:
                            currentChatPage == 2 ? Colors.black : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        currentChatPage == 1
            ? chats.length <= 1
                ? Container(height: 15.0)
                : RoundedSearchInputBox(
                    textEditingController: searchTextController,
                  )
            : communities.length <= 1
                ? Container(height: 15.0)
                : RoundedSearchInputBox(
                    textEditingController: searchTextController,
                  ),

        // Saved Messages
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatRoomPage(
                  currentUsername: widget.currentUser["username"],
                  chatObject: {"username": widget.currentUser["username"]},
                  savedMessages: true,
                ),
              ),
            );
          },
          child: Container(
            color: Colors.blueAccent.withOpacity(0.05),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            margin: EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   color: Colors.blueAccent,
                        // ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(100.0),
                        ),
                      ),
                      child: Icon(
                        Icons.bookmark_border,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "Saved Messages",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Ionicons.pencil_outline,
                    color: Colors.white,
                    size: 18.0,
                  ),
                )
              ],
            ),
          ),
        ),

        gettingChats == true
            ? Container(
                height: 400.0,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.grey[700]!,
                      strokeWidth: 2.0,
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      "Getting Chats",
                      style: TextStyle(
                        color: Colors.grey[700]!,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                child: Column(
                  children: [
                    currentChatPage == 1
                        ? Container(
                            child: chats.length <= 1
                                ? ErrorMessages(
                                    title: "There are no chats yet",
                                    body:
                                        "Start a conversation by clicking on the bottom right button and choosing a friend from the list.",
                                    color: Colors.grey[500]!,
                                  )
                                : Column(children: [
                                    // Chats
                                    for (var eachChat in chats)
                                      eachChat["username"] !=
                                              widget.currentUser["username"]
                                          ? Chats(
                                              chatObject: eachChat,
                                              currentUsername: widget
                                                  .currentUser["username"],
                                              backgroundColor:
                                                  Colors.grey[900]!,
                                              currentUser: widget.currentUser,
                                            )
                                          : Container(),
                                  ]),
                          )
                        : Container(
                            child: communities.length <= 1
                                ? ErrorMessages(
                                    title: "You didn't join any community yet",
                                    body:
                                        "Start joining one of the available communities by clicking on the bottom right button.",
                                    color: Colors.grey[500]!,
                                  )
                                : Column(
                                    children: [
                                      // Communities
                                      for (var eachChat in communities)
                                        Chats(
                                          chatObject: eachChat,
                                          currentUsername:
                                              widget.currentUser["username"],
                                          backgroundColor: Colors.grey[900]!,
                                          currentUser: widget.currentUser,
                                        ),
                                    ],
                                  ),
                          ),
                  ],
                ),
              ),

        // Chat List

        // End of Page
        SizedBox(height: 200.0),
      ],
    );
  }
}
