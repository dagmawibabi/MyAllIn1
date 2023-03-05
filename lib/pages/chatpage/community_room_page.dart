import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/config/config.dart';
import 'package:myallin1/pages/chatpage/each_text.dart';
import 'package:myallin1/pages/chatpage/message_input_field.dart';
import 'package:myallin1/pages/components/small_pfp.dart';
import 'package:http/http.dart' as http;

class CommunityRoomPage extends StatefulWidget {
  const CommunityRoomPage({
    super.key,
    required this.currentUser,
    required this.community,
    required this.communityChat,
    required this.gettingCommunityChat,
  });

  final Map community;
  final Map currentUser;
  final List communityChat;
  final bool gettingCommunityChat;

  @override
  State<CommunityRoomPage> createState() => _CommunityRoomPageState();
}

class _CommunityRoomPageState extends State<CommunityRoomPage> {
  TextEditingController textController = TextEditingController();
  String baseURL = Config.baseUrl;
  List communityChat = [];
  bool gettingCommunityChat = true;

  void getCommunityChat() async {
    var route =
        "$baseURL/community/getCommunityChat/" + widget.community["username"];
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    dynamic resultsJSON = jsonDecode(results.body);
    communityChat = resultsJSON;

    gettingCommunityChat = false;
    setState(() {});
  }

  void getCommunityChatPolling() async {
    Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        getCommunityChat();
      },
    );
  }

  void sendCommunityChat() async {
    var route = "$baseURL/community/sendCommunityChat";
    var newTextObject = {
      "from": widget.currentUser["username"],
      "community": widget.community["username"],
      "forwardedFrom": "",
      "content": textController.text.toString().trim(),
    };
    textController.clear();

    var url = Uri.parse(route);
    var jsonFormat = jsonEncode(newTextObject);
    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonFormat,
    );

    getCommunityChat();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCommunityChat();
    getCommunityChatPolling();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              width: 38.0,
              height: 38.0,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              child: Image.network(
                widget.community["profilePic"],
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.community["name"].toString(),
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  "members " + widget.community["members"].length.toString(),
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey[600]!,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert_outlined,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.835,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  widget.community["bannerPic"],
                ),
                fit: BoxFit.cover,
                opacity: 0.4,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(
                // color: Colors.red,
                child: Column(
                  children: [
                    for (var eachChat in communityChat)
                      EachText(
                        textObject: eachChat,
                        currentUsername: widget.currentUser["username"],
                        editTexts: false,
                        editTextsChange: () {},
                      ),
                    // Text(
                    //   eachChat["content"].toString(),
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          MessageInputField(
            textController: textController,
            sendFunction: sendCommunityChat,
          ),
        ],
      ),
    );
  }
}
