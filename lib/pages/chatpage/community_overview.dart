import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/components/community_info_bars.dart';

class CommunityOverview extends StatefulWidget {
  const CommunityOverview({
    super.key,
    required this.community,
    required this.communityInfoBottomSheet,
    required this.leaveCommunity,
    required this.deleteCommunity,
    required this.currentUser,
  });

  final Map community;
  final Map currentUser;
  final dynamic communityInfoBottomSheet;
  final Function leaveCommunity;
  final Function deleteCommunity;

  @override
  State<CommunityOverview> createState() => _CommunityOverviewState();
}

class _CommunityOverviewState extends State<CommunityOverview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              // Header
              Container(
                // height: 200.0,
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.community["bannerPic"],
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: Colors.grey[800]!,
                            strokeWidth: 2.0,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error_outline,
                        ),
                      ),
                      // Image.network(
                      //   widget.community["banner"],
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    // Community Name
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 250.0,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(),
                                child: Row(
                                  children: [
                                    Text(
                                      widget.community["name"].toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(width: 4.0),
                                    Expanded(
                                      child: Text(
                                        "@" +
                                            widget.community["username"]
                                                .toString(),
                                        style: TextStyle(
                                          color: Colors.grey[500]!,
                                          fontSize: 12.0,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 3.0),
                              Text(
                                widget.community["bio"].toString(),
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
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900]!.withOpacity(0.5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      widget.community["members"].length.toString(),
                      style: TextStyle(
                        // color: Colors.lightBlue,
                        color: Colors.white,
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
                  var commName = widget.community["name"];
                  var intro = "Welcome to $commName!";
                  widget.communityInfoBottomSheet(
                      "Introduction", intro, widget.community);
                },
                child: CommunityInfoBar(
                  leadingIcon: Ionicons.book_outline,
                  title: "Introduction",
                  trailingIcon: Icons.keyboard_arrow_right_outlined,
                ),
              ),
              GestureDetector(
                onTap: () {
                  var commName = widget.community["name"];
                  var intro = "Welcome to $commName!";
                  widget.communityInfoBottomSheet(
                      "Rules", intro, widget.community);
                },
                child: CommunityInfoBar(
                  leadingIcon: Ionicons.warning_outline,
                  title: "Rules",
                  trailingIcon: Icons.keyboard_arrow_right_outlined,
                ),
              ),
              GestureDetector(
                onTap: () {
                  var commName = widget.community["lname"];
                  var intro = "Welcome to $commName!";
                  widget.communityInfoBottomSheet(
                      "FAQ", intro, widget.community);
                },
                child: CommunityInfoBar(
                  leadingIcon: Icons.question_mark_outlined,
                  title: "FAQ",
                  trailingIcon: Icons.keyboard_arrow_right_outlined,
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
                child: GestureDetector(
                  onTap: () async {
                    if (widget.community["owner"] ==
                        widget.currentUser["username"]) {
                      await widget.deleteCommunity();
                    } else {
                      await widget.leaveCommunity();
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 10.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.8),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          widget.community["owner"] ==
                                  widget.currentUser["username"]
                              ? Icons.delete_forever_outlined
                              : Ionicons.log_out_outline,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          widget.community["owner"] ==
                                  widget.currentUser["username"]
                              ? "Delete"
                              : "Leave",
                          style: TextStyle(
                            color: Colors.grey[300]!,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 10.0),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.greenAccent.withOpacity(0.8),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }
}
