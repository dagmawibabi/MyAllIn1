// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/config/config.dart';
import 'package:myallin1/pages/bottomsheets/accounts_list_bottom_sheet.dart';
import 'package:myallin1/pages/chatpage/chat_room_page.dart';
import 'package:myallin1/pages/components/chat_sidebar_buttons.dart';
import 'package:myallin1/pages/components/community_info_bars.dart';
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
  String chosenCommunity = "";
  Map chosenCommunityObject = {};
  List chats = [];
  List communities = [
    {
      "fullname": "Open AI",
      "username": "openai",
      "bio": "Opensource AI Projects",
      "profilepic":
          "https://openai.com/content/images/2022/05/openai-avatar.png",
      "banner": "https://miro.medium.com/max/1400/1*qPao_uBbHlzHIzOL7ejI8w.png",
      "members": 1246,
    },
    {
      "fullname": "Tesla",
      "username": "tesla",
      "bio": "Smart Electric Vehicles",
      "profilepic":
          "https://storage.googleapis.com/webdesignledger.pub.network/WDL/12f213e1-t1.jpg",
      "banner":
          "https://cdn.motor1.com/images/mgl/WPOoO/s3/travel-retail-norway-places-order-for-tesla-semi.jpg",
      "members": 6421,
    },
    {
      "fullname": "Google",
      "username": "google",
      "bio": "Search Anything",
      "profilepic":
          "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/480px-Google_%22G%22_Logo.svg.png",
      "banner":
          "https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/Design-Guide-IO_3X2.png",
      "members": 46812,
    },
    {
      "fullname": "Flutter",
      "username": "flutter",
      "bio": "Build Apps Fast",
      "profilepic":
          "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png",
      "banner":
          "https://mobiosolutions.com/wp-content/uploads/2020/07/Group-3.png",
      "members": 7315,
    },
    {
      "fullname": "Boston Dynamics",
      "username": "bostondynamics",
      "bio": "Robots helping Humans",
      "profilepic":
          "https://res.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco,dpr_1/v1478269890/yeffwbmsn7bmg1gwesrk.png",
      "banner":
          "https://www.rightpoint.com/-/media/boston%20dynamics%20case%20study%20banner.png",
      "members": 4676,
    },
    {
      "fullname": "Apple",
      "username": "apple",
      "bio": "Think Different",
      "profilepic": "https://wallpaperaccess.com/full/213588.jpg",
      "banner":
          "https://www.applestore.pk/wp-content/uploads/2020/03/iPhone-11-Pro-Inner-Banner-1920-X-710-Website.jpg",
      "members": 46842,
    },
  ];
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

  void communityInfoBottomSheet(title, information) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 0),
      constraints: BoxConstraints(
        // minHeight: MediaQuery.of(context).size.height * 0.6,
        maxHeight: (MediaQuery.of(context).size.height * 0.8),
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) => Container(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: ListView(
            children: [
              // Back Button
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[900]!,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                information,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
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
        // SizedBox(height: 15.0),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Side Bar
            Container(
              height: MediaQuery.of(context).size.height * 0.85,
              width: 70.0,
              decoration: BoxDecoration(
                color: Color.fromARGB(150, 18, 18, 18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              // color: Colors.grey[900]!.withOpacity(0.3),
              child: ListView(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 10.0),
                      GestureDetector(
                        onTap: () {
                          currentChatPage = 1;
                          chosenCommunity = " ";
                          setState(() {});
                        },
                        child: ChatSidebarButton(
                          bottomPadding: 0,
                          iconColor: currentChatPage == 1
                              ? Colors.black
                              : Colors.white,
                          backgroundColor: currentChatPage == 1
                              ? Colors.blueAccent
                              : Colors.grey,
                          radius: currentChatPage == 1 ? 100.0 : 10.0,
                          // borderColor: currentChatPage == 1
                          //     ? Colors.blueAccent
                          //     : Colors.transparent,
                        ),
                      ),
                      Divider(
                        color: Colors.grey[700]!,
                        indent: 20.0,
                        endIndent: 20.0,
                        height: 25.0,
                      ),
                      for (var eachCommunity in communities)
                        GestureDetector(
                          onTap: () {
                            chosenCommunity = eachCommunity["username"];
                            chosenCommunityObject = eachCommunity;
                            currentChatPage = 2;
                            setState(() {});
                          },
                          child: ChatSidebarButton(
                            netPic: eachCommunity["profilepic"],
                            radius: chosenCommunity == eachCommunity["username"]
                                ? 100.0
                                : 10.0,
                            borderColor:
                                chosenCommunity == eachCommunity["username"]
                                    ? Colors.greenAccent
                                    : Colors.transparent,
                          ),
                        ),
                      ChatSidebarButton(
                        icon: Icons.add,
                        radius: 100.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            currentChatPage == 1
                // Private Chats
                ? Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.85,
                      color: Colors.grey[900]!.withOpacity(0.14),
                      child: gettingChats == true
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
                              child: chats.length <= 1
                                  ? ErrorMessages(
                                      title: "There are no chats yet",
                                      body:
                                          "Start a conversation by clicking on the bottom right button and choosing a friend from the list.",
                                      color: Colors.grey[500]!,
                                      marginHorizontal: 40.0,
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8.0),

                                        // Search
                                        RoundedSearchInputBox(
                                          textEditingController:
                                              searchTextController,
                                        ),
                                        SizedBox(height: 10.0),

                                        // Saved Messages
                                        for (var eachChat in chats)
                                          eachChat["username"] ==
                                                  widget.currentUser["username"]
                                              ? Container(
                                                  // width: double.infinity,
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.0,
                                                      horizontal: 10.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[900]!
                                                        .withOpacity(0.2),
                                                    border: Border.all(
                                                      color: Colors.blue
                                                          .withOpacity(0.1),
                                                    ),
                                                    // color: Colors.blue
                                                    //     .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10.0),
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .bookmark_outline,
                                                            size: 20.0,
                                                            color: Colors.blue,
                                                          ),
                                                          SizedBox(width: 5.0),
                                                          Text(
                                                            "Saved Messages",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Icon(
                                                        Ionicons.pencil_outline,
                                                        size: 18.0,
                                                        color: Colors.blue,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                        SizedBox(height: 10.0),

                                        // Chats
                                        for (var eachChat in chats)
                                          eachChat["username"] !=
                                                  widget.currentUser["username"]
                                              ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                                  child: Chats(
                                                    chatObject: eachChat,
                                                    currentUsername:
                                                        widget.currentUser[
                                                            "username"],
                                                    backgroundColor:
                                                        Colors.grey[900]!,
                                                    currentUser:
                                                        widget.currentUser,
                                                  ),
                                                )
                                              : Container(),
                                      ],
                                    ),
                            ),
                    ),
                  )

                // Communities
                : Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.85,
                      // width: MediaQuery.of(context).size.height * 0.85,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        image: DecorationImage(
                          image: NetworkImage(
                            chosenCommunityObject["profilepic"],
                          ),
                          fit: BoxFit.cover,
                          opacity: 0.02,
                        ),
                      ),

                      child: ListView(
                        children: [
                          Column(
                            children: [
                              Column(
                                children: [
                                  // Header
                                  Container(
                                    // height: 200.0,
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    clipBehavior: Clip.hardEdge,

                                    decoration: BoxDecoration(
                                      color: Colors.grey[850]!,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        // Banner
                                        Container(
                                          height: 180.0,
                                          width: double.infinity,
                                          child: Image.network(
                                            chosenCommunityObject["banner"],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        // Community Name
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.0, horizontal: 20.0),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20.0),
                                              bottomRight:
                                                  Radius.circular(20.0),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 250.0,
                                                    clipBehavior: Clip.hardEdge,
                                                    decoration: BoxDecoration(),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          chosenCommunityObject[
                                                              "fullname"],
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14.0,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        SizedBox(width: 4.0),
                                                        Expanded(
                                                          child: Text(
                                                            "@" +
                                                                chosenCommunityObject[
                                                                    "username"],
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .grey[500]!,
                                                              fontSize: 12.0,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 3.0),
                                                  Text(
                                                    chosenCommunityObject[
                                                        "bio"],
                                                    style: TextStyle(
                                                      color: Colors.grey[300]!,
                                                      fontSize: 13.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Icon(
                                                Icons.public_outlined,
                                                size: 22.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Members
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 2.0),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[900]!.withOpacity(0.5),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.group_outlined,
                                            ),
                                            SizedBox(width: 10.0),
                                            Text(
                                              "Members",
                                              style: TextStyle(
                                                color: Colors.grey[300]!,
                                                fontSize: 15.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          chosenCommunityObject["members"]
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.lightBlue,
                                            fontSize: 15.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8.0),

                                  // FAQ HELP GENERAL
                                  GestureDetector(
                                    onTap: () {
                                      var commName =
                                          chosenCommunityObject["fullname"];
                                      var intro = "Welcome to  $commName!";
                                      communityInfoBottomSheet(
                                          "Introduction", intro);
                                    },
                                    child: CommunityInfoBar(
                                      leadingIcon: Ionicons.book_outline,
                                      title: "Introduction",
                                      trailingIcon:
                                          Icons.keyboard_arrow_right_outlined,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      var commName =
                                          chosenCommunityObject["fullname"];
                                      var intro = "Welcome to  $commName!";
                                      communityInfoBottomSheet("Rules", intro);
                                    },
                                    child: CommunityInfoBar(
                                      leadingIcon: Ionicons.warning_outline,
                                      title: "Rules",
                                      trailingIcon:
                                          Icons.keyboard_arrow_right_outlined,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      var commName =
                                          chosenCommunityObject["fullname"];
                                      var intro = "Welcome to  $commName!";
                                      communityInfoBottomSheet("FAQ", intro);
                                    },
                                    child: CommunityInfoBar(
                                      leadingIcon: Icons.question_mark_outlined,
                                      title: "FAQ",
                                      trailingIcon:
                                          Icons.keyboard_arrow_right_outlined,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20.0),

                              // Leave or Join
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 10.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.redAccent.withOpacity(0.8),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Ionicons.log_out_outline,
                                          ),
                                          SizedBox(width: 5.0),
                                          Text(
                                            "Leave",
                                            style: TextStyle(
                                              color: Colors.grey[300]!,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10.0),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 10.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.greenAccent.withOpacity(0.8),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Ionicons.log_in_outline,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 5.0),
                                          Text(
                                            "Browse",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
