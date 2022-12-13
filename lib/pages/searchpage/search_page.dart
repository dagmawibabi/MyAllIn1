// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../chatpage/chats.dart';
import '../components/rounded_search_input_box.dart';
import '../postspage/posts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
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
                    margin:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
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
                    margin:
                        EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: Text(
                  "Posts",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Posts(
                borderRadius: 20.0,
                post: {
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
              ),
              Posts(
                borderRadius: 20.0,
                post: {
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
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
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
    );
  }
}
