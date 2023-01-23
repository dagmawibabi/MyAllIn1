import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/config/config.dart';
import 'package:myallin1/pages/chatpage/chat_date_divider.dart';
import 'package:myallin1/pages/components/small_pfp.dart';
import 'package:http/http.dart' as http;
import 'each_text.dart';

class ChatRoomPage extends StatefulWidget {
  const ChatRoomPage({
    super.key,
    required this.currentUsername,
    required this.chatObject,
    this.savedMessages = false,
  });

  final String currentUsername;
  final Map chatObject;
  final bool savedMessages;

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  List texts = [];
  bool textsLoading = true;
  bool editTexts = false;
  List selectedTexts = [];
  TextEditingController textMessageController = TextEditingController();

  var baseURL = Config.baseUrl;

  // Get Texts
  void getTexts() async {
    var from = widget.currentUsername;
    var to = widget.chatObject["username"];

    var route = "$baseURL/privateChats/getPrivateChat/$from/$to";
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    dynamic resultJSON = jsonDecode(results.body);
    texts = resultJSON;
    // texts = resultJSON.reversed.toList();
    // print(texts);
    textsLoading = false;
    setState(() {});
  }

  // Get Texts Polling
  void getTextsPolling() async {
    Timer.periodic(Duration(seconds: 2), (time) {
      getTexts();
    });
  }

  // Send Texts
  void sendTexts(newTextObject) async {
    var route = "$baseURL/privateChats/sendPrivateMessage";

    var url = Uri.parse(route);
    var jsonFormat = jsonEncode(newTextObject);
    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonFormat,
    );

    textMessageController.clear();

    getTexts();
  }

  void editTextsChange() {
    editTexts = !editTexts;
    setState(() {});
  }

  void addSelectedText(dynamic textObject) {
    selectedTexts.add(textObject);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTexts();
    getTextsPolling();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: widget.savedMessages == true
        //     ? Colors.blueAccent.withOpacity(0.2)
        //     : Theme.of(context).appBarTheme.backgroundColor,
        title: Row(
          children: [
            widget.savedMessages == true
                ? Container(
                    child: Icon(
                      Icons.bookmark_border_outlined,
                      color: Colors.lightBlueAccent,
                    ),
                  )
                : SmallPFP(
                    netpic: widget.chatObject["profilepic"],
                    size: 35.0,
                  ),
            SizedBox(width: 8.0),
            Text(
              widget.savedMessages == true
                  ? "Saved Messages"
                  : widget.chatObject["username"],
              style: TextStyle(
                fontSize: 18.0,
                color: widget.savedMessages == true
                    ? Colors.lightBlueAccent
                    : Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
              // editTexts = true;
              // setState(() {});
            },
            icon: Icon(
              Icons.edit_outlined,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert_outlined,
            ),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/INR.jpg"),
            fit: BoxFit.cover,
            opacity: 0.8,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: ListView(
            children: [
              // Space
              SizedBox(height: 10.0),

              // Custom App Bar
              // Padding(
              //   padding: EdgeInsets.only(right: 10.0, bottom: 5.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Row(
              //         children: [
              //           IconButton(
              //             onPressed: () {},
              //             icon: Icon(
              //               Icons.arrow_back,
              //             ),
              //           ),
              //           Text(
              //             widget.chatObject["username"],
              //             style: TextStyle(
              //               fontSize: 20.0,
              //               color: Colors.white,
              //             ),
              //           ),
              //         ],
              //       ),
              //       SmallPFP(
              //         pic: "assets/images/INR.jpg",
              //       ),
              //     ],
              //   ),
              // ),

              // Texts
              textsLoading == true
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.827,
                      width: double.infinity,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey[400]!,
                          strokeWidth: 2.0,
                        ),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.827,
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              // Space
                              SizedBox(height: 10.0),

                              texts.isEmpty == true
                                  ? Container(
                                      height: 400.0,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: 280.0,
                                            height: 280.0,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 20.0),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[900]!
                                                  .withOpacity(0.5),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20.0),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "No messages here yet",
                                                  style: TextStyle(
                                                    color: Colors.grey[200]!,
                                                  ),
                                                ),
                                                SizedBox(height: 10.0),
                                                SmallPFP(
                                                  netpic: widget
                                                      .chatObject["profilepic"],
                                                  size: 150.0,
                                                ),
                                                SizedBox(height: 10.0),
                                                Text(
                                                  "Type a message and send to start a conversation 👋",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.grey[400]!,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      child: Column(
                                        children: [
                                          for (var eachMessage in texts)
                                            EachText(
                                              textObject: eachMessage,
                                              currentUsername:
                                                  widget.currentUsername,
                                              editTexts: editTexts,
                                              editTextsChange: editTextsChange,
                                            ),

                                          // All Texts
                                          // for (var eachDateText in texts) ...[
                                          //   ChatDateDivider(
                                          //     dateTime: eachDateText["datetime"],
                                          //   ),
                                          //   for (var eachText
                                          //       in eachDateText["texts"])
                                          //     EachText(
                                          //       textObject: eachText,
                                          //       currentUsername:
                                          //           widget.currentUsername,
                                          //       editTexts: editTexts,
                                          //       editTextsChange: editTextsChange,
                                          //     ),
                                          // ],
                                        ],
                                      ),
                                    ),

                              // Space
                              SizedBox(height: 10.0),
                            ],
                          ),
                        ],
                      ),
                    ),

              // Input Box
              Container(
                // margin: EdgeInsets.only(left: 30.0),
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 18, 18, 18),
                  // border: Border.all(
                  //   color: Colors.grey[850]!,
                  // ),
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Ionicons.attach_outline,
                          ),
                        ),
                        Container(
                          width: 310.0,
                          // height: 35.0,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 0.0),
                          margin: EdgeInsets.symmetric(
                              horizontal: 0.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[900]!.withOpacity(0.4),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: TextField(
                            controller: textMessageController,
                            minLines: 1,
                            maxLines: 10,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type message ...",
                              hintStyle: TextStyle(
                                color: Colors.grey[500]!,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        var newTextObject = {
                          "from": widget.currentUsername,
                          "to": widget.chatObject["username"],
                          "forwardedFrom": "",
                          "content": textMessageController.text,
                        };
                        var tempTextObject = {
                          "from": widget.currentUsername,
                          "to": widget.chatObject["username"],
                          "forwardedFrom": "",
                          "content": textMessageController.text,
                          "seen": [widget.currentUsername],
                          "dateTime": DateTime.now().millisecondsSinceEpoch,
                        };
                        texts.add(tempTextObject);
                        setState(() {});
                        // print(widget.currentUsername);
                        // print(widget.chatObject);
                        sendTexts(newTextObject);
                      },
                      icon: Icon(
                        Ionicons.paper_plane_outline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: Container(
      //   // height: 50.0,
      //   width: double.infinity,
      //   child: Container(
      //     margin: EdgeInsets.only(left: 30.0),
      //     padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      //     decoration: BoxDecoration(
      //       color: Colors.grey[900],
      //       border: Border.all(
      //         color: Colors.grey[850]!,
      //       ),
      //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
      //     ),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Row(
      //           children: [
      //             IconButton(
      //               onPressed: () {},
      //               icon: Icon(
      //                 Ionicons.attach_outline,
      //               ),
      //             ),
      //             Container(
      //               width: 280.0,
      //               // height: 35.0,
      //               padding:
      //                   EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
      //               margin:
      //                   EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
      //               decoration: BoxDecoration(
      //                 color: Colors.grey[850]!.withOpacity(0.2),
      //                 borderRadius: BorderRadius.all(Radius.circular(20.0)),
      //               ),
      //               child: TextField(
      //                 minLines: 1,
      //                 maxLines: 10,
      //                 style: TextStyle(
      //                   color: Colors.white,
      //                 ),
      //                 decoration: InputDecoration(
      //                   border: InputBorder.none,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //         IconButton(
      //           onPressed: () {},
      //           icon: Icon(
      //             Ionicons.paper_plane_outline,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
