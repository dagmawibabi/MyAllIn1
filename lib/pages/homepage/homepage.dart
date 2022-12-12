// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/chatpage/chats.dart';
import 'package:myallin1/pages/components/roundedSearchInputBox.dart';
import 'package:myallin1/pages/components/smallPFP.dart';
import 'package:myallin1/pages/homepage/posts.dart';

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
    // TODO: implement initState
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
          ListView(
            children: [
              RoundedSearchInputBox(),
              // Search Results
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                padding: EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900]!.withOpacity(0.4),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 5.0),
                      child: Text(
                        "Trending",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          margin: EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Image.asset(
                            "assets/images/me.jpg",
                            width: 180.0,
                          ),
                        ),
                        Container(
                          clipBehavior: Clip.hardEdge,
                          margin: EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Image.asset(
                            "assets/images/me.jpg",
                            width: 180.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900]!.withOpacity(0.4),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8.0),
                      child: Text(
                        "Posts",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Posts(borderRadius: 20.0),
                    Posts(borderRadius: 20.0),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900]!.withOpacity(0.4),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 8.0),
                      child: Text(
                        "Chats",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Chats(borderRadius: 20.0),
                    Chats(borderRadius: 20.0),
                  ],
                ),
              ),

              // End of Page
              SizedBox(height: 200.0),
            ],
          ),
          ListView(
            children: [
              // Start of Page
              SizedBox(height: 10.0),

              Posts(
                showPic: true,
              ),
              Posts(),
              Posts(),
              Posts(),
              Posts(),
              Posts(
                showPic: true,
              ),
              Posts(),
              Posts(),
              Posts(
                showPic: true,
              ),
              Posts(),
              Posts(),
              Posts(),
              // End of Page
              SizedBox(height: 200.0),
            ],
          ),
          ListView(
            children: [
              // Start of Page
              SizedBox(height: 8.0),
              RoundedSearchInputBox(),

              Chats(),
              Chats(),
              Chats(),
              Chats(),
              Chats(),
              Chats(),
              Chats(),
              // End of Page
              SizedBox(height: 200.0),
            ],
          )
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
