// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/chatpage/chat_page.dart';
import 'package:myallin1/pages/chatpage/chats.dart';
import 'package:myallin1/pages/components/rounded_search_input_box.dart';
import 'package:myallin1/pages/components/small_pfp.dart';
import 'package:myallin1/pages/postspage/posts.dart';
import 'package:myallin1/pages/postspage/posts_page.dart';
import 'package:myallin1/pages/searchpage/search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int pageIndex = 0;

  @override
  void initState() {
    // implement initState
    tabController = TabController(length: 3, vsync: this);
    tabController.index = 1;
    tabController.addListener(() {
      pageIndex = tabController.index;
      setState(() {});
    });
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
                Navigator.pushNamed(context, "profile");
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
                  child: SmallPFP(size: 35.0),
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
          SearchPage(),
          // Posts
          PostsPage(),
          // Chats
          ChatPage(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
