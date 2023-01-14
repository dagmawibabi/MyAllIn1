// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myallin1/config/config.dart';
import 'package:myallin1/pages/bottomsheets/weather_bottom_sheet.dart';
import 'package:myallin1/pages/postspage/post_options_bottom_sheet.dart';
import 'package:myallin1/pages/postspage/posts.dart';
import 'package:http/http.dart' as http;

class PostsPage extends StatefulWidget {
  const PostsPage({
    super.key,
    required this.feed,
    required this.currentUser,
    required this.getFeed,
    required this.weatherData,
    required this.weatherLoading,
  });

  final List feed;
  final Map currentUser;
  final Function getFeed;
  final Map weatherData;
  final bool weatherLoading;

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  var baseURL = Config.baseUrl;

  // Delete Posts
  Future<void> deletePost(Map postObject) async {
    var deletePost = {
      "username": postObject["username"],
      "content": postObject["content"],
      "time": postObject["time"],
    };
    print(deletePost);
    var route = "$baseURL/posts/deletePost";
    var url = Uri.parse(route);
    var jsonFormat = jsonEncode(deletePost);
    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonFormat,
    );
    widget.getFeed();
  }

  // Post Options
  void postOptions(Map postObject, Map post) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 0),
      constraints: BoxConstraints(
        // minHeight: MediaQuery.of(context).size.height * 0.7,
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return PostOptions(
          deletePost: deletePost,
          postObject: postObject,
          currentUser: widget.currentUser,
          post: post,
        );
      },
    );
  }

  // Weather Details
  void weatherDetails() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 0),
      constraints: BoxConstraints(
        // minHeight: MediaQuery.of(context).size.height * 0.7,
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return WeatherBottomSheet(
          weatherData: widget.weatherData,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Start of Page
        SizedBox(height: 10.0),

        // Weather
        widget.weatherLoading == true
            ? Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      color: Colors.grey[800]!,
                      strokeWidth: 2.0,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Loading Weather Data",
                      style: TextStyle(
                        color: Colors.grey[700]!,
                      ),
                    ),
                  ],
                ),
              )
            : GestureDetector(
                onTap: () {
                  weatherDetails();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[900]!.withOpacity(0.01),
                    border: Border(
                      bottom: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Image and Current Weather
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 70.0,
                              width: 70.0,
                              padding: EdgeInsets.only(left: 10.0, right: 8.0),
                              child: Hero(
                                tag: "weatherIcon",
                                child: Image.network(
                                  "https:" +
                                      widget.weatherData["current"]["condition"]
                                          ["icon"],
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            Text(
                              widget.weatherData["current"]["condition"]["text"]
                                  .toString(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Max Min Avg Temp
                      Container(
                        width: 200.0,
                        // color: Colors.grey[900]!,
                        padding: EdgeInsets.only(right: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  widget.weatherData["forecast"]["forecastday"]
                                              [0]["day"]["mintemp_c"]
                                          .toString() +
                                      " °C",
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 3.0),
                                Text(
                                  "min",
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  widget.weatherData["current"]["temp_c"]
                                          .toString() +
                                      " °C",
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 3.0),
                                Text(
                                  "current",
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  widget.weatherData["forecast"]["forecastday"]
                                              [0]["day"]["maxtemp_c"]
                                          .toString() +
                                      " °C",
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 3.0),
                                Text(
                                  "max",
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

        SizedBox(height: 5.0),

        // widget.feed.map((item) => new Text(item)).toList());
        widget.feed.length == 0
            ? Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 200.0, horizontal: 60.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[900]!.withOpacity(0.4),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "There are no posts on your feed!",
                          style: TextStyle(
                            color: Colors.grey[700]!,
                          ),
                        ),
                        SizedBox(height: 15.0),
                        Text(
                          "Create your first post by clicking on the pencil icon on the bottom left corner.",
                          style: TextStyle(
                            color: Colors.grey[800]!,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Container(
                child: Column(
                  children: [
                    for (var eachPost in widget.feed)
                      Posts(
                        post: eachPost,
                        currentUser: widget.currentUser,
                        postOptions: postOptions,
                        getFeed: widget.getFeed,
                        deletePost: deletePost,
                      ),
                  ],
                ),
              ),

        // End of Page
        SizedBox(height: 200.0),
      ],
    );
  }
}
