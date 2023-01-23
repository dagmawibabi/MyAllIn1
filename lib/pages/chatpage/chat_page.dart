// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myallin1/config/config.dart';

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
  // Sample Data
  List chats = [
    {
      "profilepic":
          "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTc5OTk2ODUyMTMxNzM0ODcy/gettyimages-1229892983-square.jpg",
      "fullname": "Elon Musk",
      "username": "elongated",
    },
    {
      "profilepic":
          "https://static01.nyt.com/images/2021/05/17/business/14altGates-print/14Gates--top-mediumSquareAt3X.jpg",
      "fullname": "Bill Gates",
      "username": "billyboy",
    },
    {
      "profilepic":
          "https://assets.entrepreneur.com/content/3x2/2000/20150224165308-jeff-bezos-amazon.jpeg",
      "fullname": "Jeff Bezos",
      "username": "jeffyman",
    },
    {
      "profilepic":
          "https://media.vanityfair.com/photos/5d41c7688df537000832361b/4:3/w_2668,h_2001,c_limit/GettyImages-945005812.jpg",
      "fullname": "Mark Zuckerberg",
      "username": "repitilian",
    },
  ];

  String baseURL = Config.baseUrl;
  bool gettingChats = true;

  void getChats() async {
    var route =
        "$baseURL/privateChats/getChats/" + widget.currentUser["username"];
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    dynamic resultsJSON = jsonDecode(results.body);
    chats = resultsJSON;
    print(chats);
    gettingChats = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChats();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Start of Page
        SizedBox(height: 8.0),
        RoundedSearchInputBox(
          textEditingController: searchTextController,
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
                    for (var eachChat in chats)
                      Chats(
                        chatObject: eachChat,
                        currentUsername: widget.currentUser["username"],
                        savedMessages: widget.currentUser["username"] ==
                            eachChat["username"],
                      ),
                  ],
                ),
              ),

        // Chat List

        //

        // End of Page
        SizedBox(height: 200.0),
      ],
    );
  }
}
