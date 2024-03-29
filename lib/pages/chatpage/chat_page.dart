// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/config/config.dart';
import 'package:myallin1/pages/bottomsheets/accounts_list_bottom_sheet.dart';
import 'package:myallin1/pages/chatpage/chat_room_page.dart';
import 'package:myallin1/pages/chatpage/community_info_bottom_sheet.dart';
import 'package:myallin1/pages/chatpage/community_overview.dart';
import 'package:myallin1/pages/chatpage/createCommunityDialog.dart';
import 'package:myallin1/pages/chatpage/each_discovered_community.dart';
import 'package:myallin1/pages/components/chat_sidebar_buttons.dart';
import 'package:myallin1/pages/components/community_info_bars.dart';
import 'package:myallin1/pages/components/error_messages.dart';
import 'package:myallin1/pages/components/rounded_input_box.dart';

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
  List communities = [];
  List availableChats = [];
  List communityChat = [];
  String baseURL = Config.baseUrl;
  bool gettingChats = true;
  bool gettingCommunities = true;
  bool gettingCommunityChat = true;
  int currentChatPage = 1;
  List<Widget> eachCommunityWidget = [];
  bool discoveringCommunities = true;

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

  void getCommunities() async {
    var route =
        "$baseURL/community/getMyCommunities/" + widget.currentUser["username"];
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    dynamic resultsJSON = jsonDecode(results.body);
    communities = resultsJSON;
    gettingCommunities = false;
    setState(() {});
  }

  void getCommunitiesPolling() async {
    Timer.periodic(
      Duration(seconds: 5),
      (timer) {
        getCommunities();
      },
    );
  }

  void getCommunityChat(String chosenCommunity) async {
    gettingCommunityChat = true;
    setState(() {});

    var route =
        "$baseURL/community/getCommunityChat/" + widget.currentUser["username"];
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    dynamic resultsJSON = jsonDecode(results.body);
    communityChat = resultsJSON;

    gettingCommunityChat = false;
    setState(() {});
  }

  void leaveCommunity() async {
    var chosenCommunityObjectUsername = chosenCommunityObject["username"];
    gettingCommunities = true;
    chosenCommunity = "";
    chosenCommunityObject = {};
    currentChatPage = 1;
    setState(() {});

    var route = "$baseURL/community/leaveCommunity/" +
        chosenCommunityObjectUsername +
        "/" +
        widget.currentUser["username"];
    var url = Uri.parse(route);
    await http.get(url);

    getCommunities();
  }

  void deleteCommunity() async {
    var chosenCommunityObjectUsername = chosenCommunityObject["username"];
    gettingCommunities = true;
    chosenCommunity = "";
    chosenCommunityObject = {};
    currentChatPage = 1;
    setState(() {});
    var route = "$baseURL/community/deleteCommunity/" +
        chosenCommunityObjectUsername +
        "/" +
        widget.currentUser["username"];
    var url = Uri.parse(route);
    await http.get(url);

    getCommunities();
  }

  void communityInfoBottomSheet(title, information, communityObject) {
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
      builder: (context) => CommunityInfoBottomSheet(
        title: title,
        information: information,
        banner: communityObject["bannerPic"],
      ),
    );
  }

  void createNewCommunityBottomSheet() {
    showModalBottomSheet(
      // backgroundColor: Color.fromARGB(255, 18, 18, 18),
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
      builder: (context) {
        return CreateCommunityDialog(
          createNewCommunity: createNewCommunity,
          currentUser: widget.currentUser,
        );
      },
    );
  }

  void createNewCommunity(Map newCommunity) async {
    var route = "$baseURL/community/createCommunity";

    var url = Uri.parse(route);
    var jsonFormat = jsonEncode(newCommunity);
    var result = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonFormat,
    );

    // chosenCommunity = newCommunity["username"];
    // chosenCommunityObject = newCommunity;
    // currentChatPage = 2;
    // setState(() {});
    getCommunityChat(chosenCommunity);
    getCommunities();
  }

  void discoverCommunities() async {
    var route = "$baseURL/community/discoverCommunities";
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    dynamic resultsJSON = jsonDecode(results.body);
    List discoveredCommunities = resultsJSON;
    for (var eachCommunity in discoveredCommunities)
      eachCommunityWidget.add(
        GestureDetector(
          onTap: () {
            chosenCommunity = eachCommunity["username"];
            chosenCommunityObject = eachCommunity;
            currentChatPage = 2;
            getCommunityChat(chosenCommunity);
            setState(() {});
          },
          child: EachDiscoveredCommunity(
            community: eachCommunity,
          ),
        ),
      );
    print(discoveredCommunities);
    discoveringCommunities = false;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChats();
    getChatsPolling();
    getCommunities();
    getCommunitiesPolling();
    discoverCommunities();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // communities = [
    //   {
    //     "fullname": "NASA",
    //     "username": "nasa",
    //     "bio": "Go Beyond!",
    //     "profilepic":
    //         "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/NASA_logo.svg/2449px-NASA_logo.svg.png",
    //     "banner":
    //         "https://64.media.tumblr.com/719ddcf66d9a9542cd7549f9f04d2b91/tumblr_p2rwrtsRw71w5jef7o9_1280.png",
    //     "members": 864613,
    //   },
    //   {
    //     "fullname": "Mr.Beast",
    //     "username": "mrbeast",
    //     "bio": "Featables?",
    //     "profilepic":
    //         "https://i.pinimg.com/736x/fb/dc/f4/fbdcf4b9742a55e3434de52b6cba87fb.jpg",
    //     "banner":
    //         "https://pbs.twimg.com/media/EjQAPfdXsAE6KNZ?format=jpg&name=large",
    //     "members": 13831361,
    //   },
    //   {
    //     "fullname": "Open AI",
    //     "username": "openai",
    //     "bio": "Opensource AI Projects",
    //     "profilepic":
    //         "https://openai.com/content/images/2022/05/openai-avatar.png",
    //     "banner":
    //         "https://miro.medium.com/max/1400/1*qPao_uBbHlzHIzOL7ejI8w.png",
    //     "members": 1246,
    //   },
    //   {
    //     "fullname": "Tesla",
    //     "username": "tesla",
    //     "bio": "Smart Electric Vehicles",
    //     "profilepic":
    //         "https://storage.googleapis.com/webdesignledger.pub.network/WDL/12f213e1-t1.jpg",
    //     "banner":
    //         "https://cdn.motor1.com/images/mgl/WPOoO/s3/travel-retail-norway-places-order-for-tesla-semi.jpg",
    //     "members": 6421,
    //   },
    //   {
    //     "fullname": "DHMIS",
    //     "username": "DHMIS",
    //     "bio": "Think Different",
    //     "profilepic":
    //         "https://i.pinimg.com/originals/1b/5b/fe/1b5bfe2395ba2cb78523b660bb9597da.jpg",
    //     "banner":
    //         "https://ic.c4assets.com/brands/dont-hug-me-im-scared/0e3d3efa-ed95-482e-9b95-32c2cd32b9bc.jpg?interpolation=progressive-bicubic&output-format=jpeg&output-quality=90{&resize}",
    //     "members": 23143,
    //   },
    //   {
    //     "fullname": "Google",
    //     "username": "google",
    //     "bio": "Search Anything",
    //     "profilepic":
    //         "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/480px-Google_%22G%22_Logo.svg.png",
    //     "banner":
    //         "https://storage.googleapis.com/gd-wagtail-prod-assets/original_images/Design-Guide-IO_3X2.png",
    //     "members": 46812,
    //   },
    //   {
    //     "fullname": "Veritasium",
    //     "username": "veritasium",
    //     "bio": "The Element of Truth",
    //     "profilepic":
    //         "https://static.wikia.nocookie.net/youtube/images/7/7d/Veritasium_Italia.jpg/revision/latest?cb=20210909083234",
    //     "banner":
    //         "https://c10.patreonusercontent.com/4/patreon-media/p/campaign/70092/ca593903846542c7b6c49d9f3f5b5751/eyJ3IjoxOTIwLCJ3ZSI6MX0%3D/1.jpg?token-time=1675468800&token-hash=RLtZPK8FKNzWOuK6CrN4oCIODjFyqKVp8qIXJkcrfPk%3D",
    //     "members": 246842,
    //   },
    //   {
    //     "fullname": "Boston Dynamics",
    //     "username": "bostondynamics",
    //     "bio": "Robots helping Humans",
    //     "profilepic":
    //         "https://res.cloudinary.com/crunchbase-production/image/upload/c_lpad,h_256,w_256,f_auto,q_auto:eco,dpr_1/v1478269890/yeffwbmsn7bmg1gwesrk.png",
    //     "banner":
    //         "https://www.rightpoint.com/-/media/boston%20dynamics%20case%20study%20banner.png",
    //     "members": 4676,
    //   },
    //   {
    //     "fullname": "Godot",
    //     "username": "godot",
    //     "bio": "Think Different",
    //     "profilepic":
    //         "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Godot_icon.svg/2048px-Godot_icon.svg.png",
    //     "banner":
    //         "https://user-images.githubusercontent.com/1103897/34840206-e7adbb50-f6c9-11e7-84bc-08e4b7d9b661.png",
    //     "members": 16834,
    //   },
    //   {
    //     "fullname": "Void Pet",
    //     "username": "voidpet",
    //     "bio": "A feelings game",
    //     "profilepic":
    //         "https://assets.change.org/photos/3/fq/bv/dqFQbvEvLeEketH-800x450-noPad.jpg",
    //     "banner": "https://voidpet.com/ogimage.png",
    //     "members": 46842,
    //   },
    //   {
    //     "fullname": "Serenity OS",
    //     "username": "serenityos",
    //     "bio": "Vintage Linux OS",
    //     "profilepic":
    //         "https://avatars.githubusercontent.com/u/50811782?s=200&v=4",
    //     "banner": "https://i.ytimg.com/vi/puTsBKAQzk4/maxresdefault.jpg",
    //     "members": 1342,
    //   },
    //   {
    //     "fullname": "Flutter",
    //     "username": "flutter",
    //     "bio": "Build Apps Fast",
    //     "profilepic":
    //         "https://res.cloudinary.com/teepublic/image/private/s--lxNXHPN3--/c_fit,g_north_west,h_840,w_679/co_ffffff,e_outline:40/co_ffffff,e_outline:inner_fill:1/co_ffffff,e_outline:40/co_ffffff,e_outline:inner_fill:1/co_bbbbbb,e_outline:3:1000/c_mpad,g_center,h_1260,w_1260/b_rgb:eeeeee/c_limit,f_jpg,h_630,q_90,w_630/v1585726530/production/designs/8796655_0.jpg",
    //     "banner":
    //         "https://mobiosolutions.com/wp-content/uploads/2020/07/Group-3.png",
    //     "members": 7315,
    //   },
    //   {
    //     "fullname": "The Simpsons",
    //     "username": "thesimpsons",
    //     "bio": "Think Different",
    //     "profilepic":
    //         "https://m.media-amazon.com/images/M/MV5BYjFkMTlkYWUtZWFhNy00M2FmLThiOTYtYTRiYjVlZWYxNmJkXkEyXkFqcGdeQXVyNTAyODkwOQ@@._V1_FMjpg_UX1000_.jpg",
    //     "banner":
    //         "https://static.posters.cz/image/1300/affiches-et-posters/the-simpsons-stars-i8081.jpg",
    //     "members": 612134,
    //   },
    //   {
    //     "fullname": "Apple",
    //     "username": "apple",
    //     "bio": "Think Different",
    //     "profilepic":
    //         "https://1000logos.net/wp-content/uploads/2016/10/apple-emblem.jpg",
    //     "banner":
    //         "https://www.applestore.pk/wp-content/uploads/2020/03/iPhone-11-Pro-Inner-Banner-1920-X-710-Website.jpg",
    //     "members": 46842,
    //   },
    // ];
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
                      // Chats
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
                      SizedBox(height: 4.0),

                      Divider(
                        color: Colors.grey[700]!,
                        indent: 20.0,
                        endIndent: 20.0,
                        height: 25.0,
                      ),
                      // Community List
                      gettingCommunities == true
                          ? Container(
                              height: 400.0,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircularProgressIndicator(
                                    color: Colors.grey[700]!,
                                    strokeWidth: 1.0,
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                for (var eachCommunity in communities)
                                  GestureDetector(
                                    onTap: () {
                                      chosenCommunity =
                                          eachCommunity["username"];
                                      chosenCommunityObject = eachCommunity;
                                      currentChatPage = 2;
                                      getCommunityChat(chosenCommunity);
                                      setState(() {});
                                    },
                                    child: ChatSidebarButton(
                                      netPic: eachCommunity["profilePic"],
                                      radius: chosenCommunity ==
                                              eachCommunity["username"]
                                          ? 100.0
                                          : 10.0,
                                      borderColor: chosenCommunity ==
                                              eachCommunity["username"]
                                          ? Colors.greenAccent
                                          : Colors.transparent,
                                    ),
                                  ),
                              ],
                            ),
                      communities.isEmpty == false
                          ? Column(
                              children: [
                                SizedBox(height: 5.0),
                                Divider(
                                  color: Colors.grey[700]!,
                                  indent: 20.0,
                                  endIndent: 20.0,
                                  height: 25.0,
                                ),
                              ],
                            )
                          : Container(),

                      // Discover Communities
                      GestureDetector(
                        onTap: () {
                          currentChatPage = 3;
                          chosenCommunity = " ";
                          setState(() {});
                        },
                        child: ChatSidebarButton(
                          icon: Ionicons.compass_outline,
                          iconColor: Colors.deepPurpleAccent,
                          radius: 100.0,
                        ),
                      ),

                      // Create New Community
                      GestureDetector(
                        onTap: () {
                          createNewCommunityBottomSheet();
                        },
                        child: ChatSidebarButton(
                          icon: Icons.add,
                          iconColor: Colors.greenAccent,
                          radius: 100.0,
                        ),
                      ),
                      SizedBox(height: 200.0),
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
                                    strokeWidth: 1.0,
                                  ),
                                  SizedBox(height: 15.0),
                                  Text(
                                    "Getting Chats",
                                    style: TextStyle(
                                      color: Colors.grey[800]!,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              child: chats.length <= 1
                                  ? Column(
                                      children: [
                                        // Saved Messages
                                        for (var eachChat in chats)
                                          eachChat["username"] ==
                                                  widget.currentUser["username"]
                                              ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatRoomPage(
                                                          currentUsername:
                                                              widget.currentUser[
                                                                  "username"],
                                                          chatObject: eachChat,
                                                          savedMessages: true,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    // width: double.infinity,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                            SizedBox(
                                                                width: 5.0),
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
                                                          Ionicons
                                                              .pencil_outline,
                                                          size: 18.0,
                                                          color: Colors.blue,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                        SizedBox(height: 10.0),
                                        ErrorMessages(
                                          title: "There are no chats yet",
                                          body:
                                              "Start a conversation by clicking on the bottom right button and choosing a friend from the list.",
                                          color: Colors.grey[500]!,
                                          marginHorizontal: 30.0,
                                          height: 130.0,
                                        ),
                                      ],
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
                                              ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatRoomPage(
                                                          currentUsername:
                                                              widget.currentUser[
                                                                  "username"],
                                                          chatObject: eachChat,
                                                          savedMessages: true,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    // width: double.infinity,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.0),
                                                    padding:
                                                        EdgeInsets.symmetric(
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
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                            SizedBox(
                                                                width: 5.0),
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
                                                          Ionicons
                                                              .pencil_outline,
                                                          size: 18.0,
                                                          color: Colors.blue,
                                                        ),
                                                      ],
                                                    ),
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
                : currentChatPage == 2
                    ? Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.85,
                          // width: MediaQuery.of(context).size.height * 0.85,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            image: DecorationImage(
                              image: NetworkImage(
                                chosenCommunityObject["bannerPic"],
                              ),
                              fit: BoxFit.cover,
                              opacity: 0.04,
                            ),
                          ),

                          child: gettingCommunities == true
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
                                        "Getting Communities",
                                        style: TextStyle(
                                          color: Colors.grey[700]!,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListView(
                                  children: [
                                    CommunityOverview(
                                      community: chosenCommunityObject,
                                      communityInfoBottomSheet:
                                          communityInfoBottomSheet,
                                      leaveCommunity: leaveCommunity,
                                      currentUser: widget.currentUser,
                                      deleteCommunity: deleteCommunity,
                                      communityChat: communityChat,
                                      gettingCommunityChat:
                                          gettingCommunityChat,
                                    ),
                                  ],
                                ),
                        ),
                      )
                    :
                    // Discover Communities
                    discoveringCommunities == true
                        ? Expanded(
                            child: Container(
                              height: 300.0,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.grey[300]!,
                                  strokeWidth: 1.0,
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5.0),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 12.0),
                                  child: Text(
                                    "Discover Communities ...",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  // color: Colors.blue,
                                  height: MediaQuery.of(context).size.height,
                                  child: ListView(
                                    children: [
                                      Container(
                                        // color: Colors.grey[900],
                                        // width: 00.0,
                                        // width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        child: GridView.count(
                                          primary: true,
                                          shrinkWrap: true,
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.8,
                                          children: eachCommunityWidget,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
          ],
        ),
      ],
    );
  }
}
