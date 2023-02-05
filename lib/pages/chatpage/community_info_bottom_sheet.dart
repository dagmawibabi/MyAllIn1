import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CommunityInfoBottomSheet extends StatefulWidget {
  const CommunityInfoBottomSheet({
    super.key,
    required this.title,
    required this.information,
    required this.banner,
  });

  final String title;
  final String information;
  final String banner;

  @override
  State<CommunityInfoBottomSheet> createState() =>
      _CommunityInfoBottomSheetState();
}

class _CommunityInfoBottomSheetState extends State<CommunityInfoBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

              Container(
                height: MediaQuery.of(context).size.height * 0.7,
                child: ListView(
                  children: [
                    // Title
                    Column(
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Text(
                        //   widget.information,
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: 15.0),

                    // Banner and Content
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.8,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      padding: EdgeInsets.only(bottom: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[900]!,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Banner
                          Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              // color: Colors.grey[850]!,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.pink,
                                  Colors.greenAccent,
                                  Colors.blueAccent,
                                ],
                              ),
                            ),
                            child: Container(
                              height: 200.0,
                              width: double.infinity,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                // color: Colors.grey[850]!,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.pink,
                                    Colors.blueAccent,
                                  ],
                                ),
                              ),
                              child: Image.network(
                                widget.banner,
                                fit: BoxFit.cover,
                                width: 200.0,
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),

                          // Content
                          widget.title == "Introduction"
                              ? Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Welcome to our community",
                                        // textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10.0),
                                      Text(
                                        "This's the official philomena community of Google. You can access resources and news about all of Google's products. You can network and meet all kinds of people from the google community all around the world",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          height: 1.3,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),

                          widget.title == "Rules"
                              ? Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "1. No NSFW content",
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            "Don't post sexually explicit, gory or anything NSFW content in this community.",
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              height: 1.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15.0),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "2. No hateful content",
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            "You should be nice and inclusive and kind with the content you post and the interactions you form.",
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              height: 1.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15.0),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "3. Post source or link of your content",
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            "You should always post and tag references you used for the content you produce",
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              height: 1.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15.0),
                                  ],
                                )
                              : Container(),

                          widget.title == "FAQ"
                              ? Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "1. What is this group about?",
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            "Welcome to the official philomena community group of Google. You can access resources and news about all of Google's products. You can network and meet all kinds of incredibly people from the google community all around the world",
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              height: 1.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12.0),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "2. What is this group about?",
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            "Welcome to the official philomena community group of Google. You can access resources and news about all of Google's products. You can network and meet all kinds of incredibly people from the google community all around the world",
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              height: 1.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 12.0),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "3. What is this group about?",
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4.0),
                                          Text(
                                            "Welcome to the official philomena community group of Google. You can access resources and news about all of Google's products. You can network and meet all kinds of incredibly people from the google community all around the world",
                                            // textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.0,
                                              height: 1.3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),

                          SizedBox(height: 20.0),

                          // CTAs
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              children: [
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
                                          widget.title == "Introduction"
                                              ? "Browse"
                                              : widget.title == "Rules"
                                                  ? "I Agree"
                                                  : "Ask a Question",
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
