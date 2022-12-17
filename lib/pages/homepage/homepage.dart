// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/chatpage/chat_page.dart';
import 'package:myallin1/pages/components/small_pfp.dart';
import 'package:myallin1/pages/postspage/new_post_page.dart';
import 'package:myallin1/pages/postspage/posts_page.dart';
import 'package:myallin1/pages/profilepage/profilepage.dart';
import 'package:myallin1/pages/searchpage/search_page.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Globals
  String baseURL = "http://test.dagmawibabi.com/philomena";
  late TabController tabController;
  int pageIndex = 0;
  bool feedLoading = true;

  // Sample Data
  Map currentUser = {
    "username": "dagmawibabi",
    "fullname": "Dagmawi Babi",
    "profilepic": "assets/images/me.jpg",
    "posts": 96,
    "followers": 13548,
    "following": 465,
    "phone": "+251975124687",
    "email": "1babidagi@gmail.com",
    "bio": "Build, Break and Rebuild!",
  };
  List feed = [
    {
      "username": "DagmawiBabi",
      "fullname": "Dagmawi Babi",
      "profilepic": "assets/images/me.jpg",
      "likes": 1345,
      "comments": 945,
      "reposts": 342,
      "content":
          "Currently working on componentizing every element of this social media to make development easy and efficient.",
      "commentsList": [
        "1",
        "2",
        "3",
        "4",
        "5",
      ],
      "likers": [
        "11",
        "22",
        "33",
      ],
      "reposters": [
        "111",
        "222",
        "333",
        "444",
      ],
    },
    {
      "profilepic": "assets/images/me.jpg",
      "fullname": "Dagmawi Babi",
      "username": "DagmawiBabi",
      "likes": 1200,
      "comments": 864,
      "reposts": 256,
      "content":
          "This is the first  post in this new amazing social media that will take off. Trust me this is amazing. So gorgeous too.",
      "commentsList": [
        "1",
        "2",
        "3",
        "4",
        "5",
      ],
      "likers": [
        "11",
        "22",
        "33",
      ],
      "reposters": [
        "111",
        "222",
        "333",
        "444",
      ],
    },
    {
      "profilepic": "assets/images/me.jpg",
      "fullname": "Dagmawi Babi",
      "username": "DagmawiBabi",
      "likes": 1345,
      "comments": 945,
      "reposts": 342,
      "content":
          "This is the first  post in this new amazing social media that will take off. Trust me this is amazing. So gorgeous too.",
      "commentsList": [
        "1",
        "2",
        "3",
        "4",
        "5",
      ],
      "likers": [
        "11",
        "22",
        "33",
      ],
      "reposters": [
        "111",
        "222",
        "333",
        "444",
      ],
    },
    {
      "profilepic": "assets/images/me.jpg",
      "fullname": "Dagmawi Babi",
      "username": "DagmawiBabi",
      "likes": 1200,
      "comments": 864,
      "reposts": 256,
      "content":
          "This is the first  post in this new amazing social media that will take off. Trust me this is amazing. So gorgeous too.",
      "commentsList": [
        "1",
        "2",
        "3",
        "4",
        "5",
      ],
      "likers": [
        "11",
        "22",
        "33",
      ],
      "reposters": [
        "111",
        "222",
        "333",
        "444",
      ],
    },
  ];

  // Get Feed
  void getFeed() async {
    var route = "$baseURL/posts/getAllPosts";
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    dynamic resultJSON = jsonDecode(results.body);
    feed = resultJSON;
    feedLoading = false;
    setState(() {});
    // print(resultJSON);
  }

  // Get Feed Polling
  void getFeedPolling() async {
    Timer.periodic(Duration(seconds: 1), (time) {
      getFeed();
    });
  }

  // New Post
  void newPost(newPostObject) async {
    var route = "$baseURL/posts/newPost";
    var url = Uri.parse(route);
    // print(newPostObject);
    // print(jsonEncode(newPostObject));
    var jsonFormat = jsonEncode(newPostObject);
    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonFormat,
    );
    // dynamic resultJSON = jsonDecode(results.body);
    // print(results.body);
  }

  // initState
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.index = 1;
    tabController.addListener(() {
      pageIndex = tabController.index;
      setState(() {});
    });

    getFeedPolling();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, "profile");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      profile: currentUser,
                    ),
                  ),
                );
              },
              child: Hero(
                tag: "profilepic",
                child: Container(
                  padding: EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100.0),
                    ),
                  ),
                  child: SmallPFP(
                    size: 35.0,
                    pic: "assets/images/me.jpg",
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Text("Philomena"),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "notification");
            },
            icon: Icon(
              Icons.notifications_outlined,
            ),
          ),
          SizedBox(width: 15.0),
        ],
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.grey[600],
          tabs: [
            Tab(
              // icon: Icon(Icons.directions_transit),
              text: "Search",
            ),
            Tab(
              // icon: Icon(Icons.directions_car),
              text: "Feed",
            ),
            Tab(
              // icon: Icon(Icons.directions_transit),
              text: "Chats",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          // Search
          SearchPage(
            currentUser: currentUser,
          ),
          // Posts
          feedLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Column(
                      children: [
                        CircularProgressIndicator(
                          color: Colors.grey[500],
                          strokeWidth: 2.0,
                        ),
                        SizedBox(height: 25.0),
                        Text(
                          "Fetching Posts",
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Spacer(),
                    Spacer(),
                  ],
                )
              : PostsPage(
                  feed: feed,
                  currentUser: currentUser,
                ),
          // Chats
          ChatPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ProfileBar(
          //   profile: {
          //     "profilepic": widget.post["profilepic"],
          //     "fullname": widget.post["fullname"],
          //     "username": widget.post["username"],
          //   },
          // ),

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPostPage(
                currentUser: currentUser,
                newPostFunction: newPost,
              ),
            ),
          );
        },
        child: Icon(
          pageIndex == 0
              ? Ionicons.search_outline
              : pageIndex == 1
                  ? Ionicons.pencil_outline
                  : Ionicons.chatbox_outline,
        ),
      ),
    );
  }
}
