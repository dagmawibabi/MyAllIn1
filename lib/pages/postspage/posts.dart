// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/config/config.dart';
import 'package:myallin1/pages/commentspage/comments_page.dart';
import 'package:myallin1/pages/components/profile_bar.dart';
import 'package:myallin1/pages/imageViewerPage/image_viewer_page.dart';
import 'package:myallin1/pages/likeslistpage/likes_list_page.dart';
import 'package:http/http.dart' as http;
import 'package:myallin1/pages/postspage/post_tags.dart';
import 'package:myallin1/pages/profilepage/others_profile_page.dart';
import 'package:myallin1/pages/videoPlayerPage/video_player_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../components/small_pfp.dart';
import '../profilepage/profilepage.dart';

class Posts extends StatefulWidget {
  const Posts({
    super.key,
    this.borderRadius = 2.0,
    this.showPic = false,
    this.interactions = true,
    required this.post,
    required this.currentUser,
    this.extended = false,
    this.clickable = true,
    this.postOptions,
    this.getFeed,
    this.deletePost,
  });

  final double borderRadius;
  final bool showPic;
  final bool interactions;
  final Map post;
  final Map currentUser;
  final bool extended;
  final bool clickable;
  final dynamic postOptions;
  final dynamic getFeed;
  final dynamic deletePost;

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  dynamic _previewData;
  bool gotLinkPreview = false;

  String baseURL = Config.baseUrl;
  bool isHidden = false;
  bool isNSFW = false;
  bool isSpoiler = false;
  bool isBookmarked = false;
  String? fileName = " ";
  bool isGeneratingVideoThumbnail = false;

  // Like Displie Posts
  void likeDislikePosts(String postID) async {
    var postReq = {
      "postID": postID,
      "likedBy": widget.currentUser["username"],
    };
    var route = "$baseURL/interactions/likeDislikePosts";
    var url = Uri.parse(route);
    var jsonFormat = jsonEncode(postReq);
    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonFormat,
    );
    widget.getFeed();
  }

  void setTags() {
    isHidden = widget.post["hidden"];
    isNSFW = widget.post["nsfw"];
    isSpoiler = widget.post["spoiler"];
  }

  void videoThumbnail() async {
    if (widget.post["video"] != "" &&
        widget.post["video"] != " " &&
        widget.post["video"] != null &&
        widget.post["video"] != "null") {
      isGeneratingVideoThumbnail = true;
      setState(() {});

      fileName = await VideoThumbnail.thumbnailFile(
        video: Config.postImagesURL + widget.post["video"],
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
        quality: 100,
        // maxHeight: 64,
      );

      isGeneratingVideoThumbnail = false;
      setState(() {});
    }
  }

  void share(post) {
    var image = post["image"] != "" &&
            post["image"] != " " &&
            post["image"] != "null" &&
            post["image"] != null
        ? Config.postImagesURL + post["image"]
        : "";
    var video = post["video"] != "" &&
            post["video"] != " " &&
            post["video"] != "null" &&
            post["video"] != null
        ? Config.postImagesURL + post["video"]
        : "";
    Share.share(
      // post["image"].toString() +
      // "\n" +
      // post["video"].toString() +

      post["fullname"].toString() +
          "\n@" +
          post["username"].toString() +
          "\n\n" +
          post["content"].toString() +
          "\n" +
          image.toString() +
          "\n" +
          video.toString() +
          "\n\n" +
          DateTime.fromMillisecondsSinceEpoch(widget.post["time"])
              .toString()
              .substring(11, 16) +
          " • " +
          DateTime.fromMillisecondsSinceEpoch(widget.post["time"])
              .toString()
              .substring(0, 10),
      subject: post["content"],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoThumbnail();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.clickable == true
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommentsPage(
                    currentUser: widget.currentUser,
                    post: widget.post,
                  ),
                ),
              )
            : () {};
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        margin: EdgeInsets.only(bottom: 5.0),
        decoration: BoxDecoration(
          // color: Colors.grey[900]!.withOpacity(0.1),
          // border: Border.all(
          //   color: widget.post["spoiler"] == true
          //       ? Colors.orangeAccent
          //       : Colors.black,
          // ),
          border: Border(
            bottom: BorderSide(color: Colors.black),
          ),
          // borderRadius: BorderRadius.circular(
          //   widget.borderRadius,
          // ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // PFP Name Username
            // ProfileBar(
            //   profile: {
            //     "profilepic":
            //         "https://dagmawibabi.com/static/media/me.b4b941897136a2959e33.png", // widget.post["profilepic"],
            //     "fullname": widget.post["fullname"],
            //     "username": widget.post["username"],
            //   },
            //   postOptions: widget.postOptions,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // PFP Name Username
                GestureDetector(
                  onTap: () {
                    widget.post["username"] == widget.currentUser["username"]
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfilePage(
                                profile: widget.currentUser,
                              ),
                            ),
                          )
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OthersProfilePage(
                                fullname: widget.post["fullname"],
                                username: widget.post["username"],
                                profilepic:
                                    "https://dagmawibabi.com/static/media/me.b4b941897136a2959e33.png",
                                currentUser: widget.currentUser,
                              ),
                            ),
                          );
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 5.0),
                      // Profile Pic
                      SmallPFP(
                        netpic: widget.currentUser["profilepic"],
                        size: 40.0,
                      ),
                      SizedBox(width: 7.0),
                      // Name and Username
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.post["fullname"].toString(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey[200]!,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5.0),
                              Icon(
                                Icons.verified,
                                color: Colors.lightBlue,
                                size: 16.0,
                              ),
                            ],
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            "@" +
                                widget.post["username"]
                                    .toString()
                                    .toLowerCase(),
                            style: TextStyle(
                              fontSize: 13.5,
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Bookmark and More Post Options
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        isBookmarked = !isBookmarked;
                        setState(() {});
                      },
                      child: Icon(
                        isBookmarked == true
                            ? Ionicons.bookmark
                            : Ionicons.bookmark_outline,
                        size: 20.0,
                        color: isBookmarked == true
                            ? Colors.yellow
                            : Colors.grey[400]!,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        var postObject = {
                          "username":
                              widget.post["username"].toString().toLowerCase(),
                          "content": widget.post["content"],
                          "time": widget.post["time"].toString().toLowerCase(),
                        };
                        widget.postOptions(postObject, widget.post);
                      },
                      icon: Icon(
                        Icons.more_vert_outlined,
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: widget.post["hidden"] == false
                  ? widget.post["spoiler"] == false
                      ? widget.post["nsfw"] == false
                          ? 0.0
                          : 5.0
                      : 5.0
                  : 5.0,
            ),

            // Tags
            Container(
              padding: EdgeInsets.only(bottom: 4.0),
              decoration: BoxDecoration(
                // color: Colors.grey[900]!.withOpacity(0.5),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.post["nsfw"] == true
                      ? PostTag(
                          icon: Ionicons.warning_outline,
                          text: "NSFW",
                          color: Colors.redAccent,
                        )
                      : Container(),
                  widget.post["spoiler"] == true
                      ? PostTag(
                          icon: Icons.announcement_outlined,
                          text: "Spoiler",
                          color: Colors.orangeAccent,
                        )
                      : Container(),
                  widget.post["hidden"] == true
                      ? PostTag(
                          icon: Ionicons.eye_off_outline,
                          text: "Hidden",
                          color: Colors.lightBlueAccent,
                        )
                      : Container(),
                ],
              ),
            ),

            // Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.clickable == true
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommentsPage(
                                currentUser: widget.currentUser,
                                post: widget.post,
                              ),
                            ),
                          )
                        : () {};
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      // gradient: LinearGradient(
                      //   colors: [
                      //     Colors.grey[800]!,
                      //     Colors.grey[850]!
                      //     // Colors.redAccent.withOpacity(0.5),
                      //     // Colors.orangeAccent.withOpacity(0.5),
                      //     // Colors.lightBlueAccent.withOpacity(0.5),
                      //   ],
                      // ),
                    ),
                    child: Linkify(
                      onOpen: (link) {
                        var postedLink = Uri.parse(link.url);
                        launchUrl(postedLink,
                            mode: LaunchMode.externalApplication);
                      },
                      text: widget.extended == true
                          ? widget.post["content"].toString().trim()
                          : widget.post["hidden"] == false
                              ? widget.post["nsfw"] == false
                                  ? widget.post["spoiler"] == false
                                      ? widget.post["content"].toString().trim()
                                      : widget.post["content"]
                                          .toString()
                                          .trim()
                                          .replaceAll(RegExp(r" "), "X")
                                          .replaceAll(RegExp(r"[^X]"), "*")
                                          .replaceAll(RegExp(r"X"), " ")
                                  : widget.post["content"]
                                      .toString()
                                      .trim()
                                      .replaceAll(RegExp(r" "), "X")
                                      .replaceAll(RegExp(r"[^X]"), "*")
                                      .replaceAll(RegExp(r"X"), " ")
                              : widget.post["content"]
                                  .toString()
                                  .trim()
                                  .replaceAll(RegExp(r" "), "X")
                                  .replaceAll(RegExp(r"[^X]"), "*")
                                  .replaceAll(RegExp(r"X"), " "),
                      style: TextStyle(
                        fontSize: widget.extended == true ? 16.5 : 16.0,
                        color: widget.extended == true
                            ? Colors.grey[300]!
                            : widget.post["hidden"] == false
                                ? widget.post["nsfw"] == false
                                    ? widget.post["spoiler"] == false
                                        ? Colors.grey[300]!
                                        : Colors.grey[400]!
                                    : Colors.grey[400]!
                                : Colors.grey[400]!,
                        height: 1.4,
                      ),
                      linkStyle: TextStyle(
                        color: Colors.blueAccent,
                      ),
                      // child: Text(
                      // widget.extended == true
                      //     ? widget.post["content"].toString().trim()
                      //     : widget.post["hidden"] == false
                      //         ? widget.post["nsfw"] == false
                      //             ? widget.post["spoiler"] == false
                      //                 ? widget.post["content"].toString().trim()
                      //                 : widget.post["content"]
                      //                     .toString()
                      //                     .trim()
                      //                     .replaceAll(RegExp(r" "), "X")
                      //                     .replaceAll(RegExp(r"[^X]"), "*")
                      //                     .replaceAll(RegExp(r"X"), " ")
                      //             : widget.post["content"]
                      //                 .toString()
                      //                 .trim()
                      //                 .replaceAll(RegExp(r" "), "X")
                      //                 .replaceAll(RegExp(r"[^X]"), "*")
                      //                 .replaceAll(RegExp(r"X"), " ")
                      //         : widget.post["content"]
                      //             .toString()
                      //             .trim()
                      //             .replaceAll(RegExp(r" "), "X")
                      //             .replaceAll(RegExp(r"[^X]"), "*")
                      //             .replaceAll(RegExp(r"X"), " "),
                      // textAlign: TextAlign.start,
                      // maxLines: widget.extended == true ? 100 : 5,
                      // overflow: TextOverflow.ellipsis,
                      // style: TextStyle(
                      //   fontSize: widget.extended == true ? 16.5 : 16.0,
                      //   color: widget.extended == true
                      //       ? Colors.grey[300]!
                      //       : widget.post["hidden"] == false
                      //           ? widget.post["nsfw"] == false
                      //               ? widget.post["spoiler"] == false
                      //                   ? Colors.grey[300]!
                      //                   : Colors.grey[400]!
                      //               : Colors.grey[400]!
                      //           : Colors.grey[400]!,
                      //   height: 1.4,
                      // ),
                    ),
                  ),
                ),

                // Visibility(
                //   visible: gotLinkPreview,
                //   maintainAnimation: true,
                //   maintainState: true,
                //   maintainInteractivity: true,
                //   maintainSize: true,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.grey[900]!.withOpacity(0.4),
                //       borderRadius: BorderRadius.all(
                //         Radius.circular(10.0),
                //       ),
                //     ),
                //     child: LinkPreview(
                //       textStyle: TextStyle(
                //         color: Colors.white,
                //       ),
                //       headerStyle: TextStyle(
                //         color: Colors.white,
                //       ),
                //       enableAnimation: true,
                //       onPreviewDataFetched: (data) {
                //         if (data.title != null) {
                //           gotLinkPreview = true;
                //           _previewData = data;
                //           setState(() {});
                //         }
                //       },
                //       previewData:
                //           _previewData, // Pass the preview data from the state
                //       text: widget.extended == true
                //           ? widget.post["content"].toString().trim()
                //           : widget.post["hidden"] == false
                //               ? widget.post["nsfw"] == false
                //                   ? widget.post["spoiler"] == false
                //                       ? widget.post["content"].toString().trim()
                //                       : widget.post["content"]
                //                           .toString()
                //                           .trim()
                //                           .replaceAll(RegExp(r" "), "X")
                //                           .replaceAll(RegExp(r"[^X]"), "*")
                //                           .replaceAll(RegExp(r"X"), " ")
                //                   : widget.post["content"]
                //                       .toString()
                //                       .trim()
                //                       .replaceAll(RegExp(r" "), "X")
                //                       .replaceAll(RegExp(r"[^X]"), "*")
                //                       .replaceAll(RegExp(r"X"), " ")
                //               : widget.post["content"]
                //                   .toString()
                //                   .trim()
                //                   .replaceAll(RegExp(r" "), "X")
                //                   .replaceAll(RegExp(r"[^X]"), "*")
                //                   .replaceAll(RegExp(r"X"), " "),
                //       width: MediaQuery.of(context).size.width,
                //     ),
                //   ),
                // ),

                // Images
                widget.post["image"] == "" ||
                        widget.post["image"] == "null" ||
                        widget.post["image"] == null
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageViewerPage(
                                isNetworkImage: true,
                                networkImage: Config.postImagesURL +
                                    widget.post["image"].toString(),
                                title: widget.post["username"],
                              ),
                            ),
                          );
                          // widget.extended == false
                          //     ? Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => CommentsPage(
                          //             currentUser: widget.currentUser,
                          //             post: widget.post,
                          //           ),
                          //         ),
                          //       )
                          //     : Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => ImageViewerPage(
                          //             isNetworkImage: true,
                          //             networkImage: Config.postImagesURL +
                          //                 widget.post["image"].toString(),
                          //           ),
                          //         ),
                          //       );
                        },
                        child: Container(
                          width: 400.0,
                          height: 400.0,
                          clipBehavior: Clip.hardEdge,
                          margin: EdgeInsets.symmetric(vertical: 6.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[900]!.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius,
                            ),
                          ),
                          child: Hero(
                            tag: Config.postImagesURL +
                                widget.post["image"].toString(),
                            child: CachedNetworkImage(
                              fit: widget.extended == true
                                  ? BoxFit.contain
                                  : BoxFit.cover,
                              imageUrl: Config.postImagesURL +
                                  widget.post["image"].toString(),
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
                          ),
                          // Image.network(
                          //   Config.postImagesURL +
                          //       widget.post["image"].toString(),
                          // ),
                        ),
                      ),

                // Videos
                widget.post["video"] == "" ||
                        widget.post["video"] == "null" ||
                        widget.post["video"] == null
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoPlayerPage(
                                networkVideo: Config.postImagesURL +
                                    widget.post["video"].toString(),
                                title: widget.post["username"],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 400.0,
                          height: 400.0,
                          clipBehavior: Clip.hardEdge,
                          margin: EdgeInsets.symmetric(vertical: 6.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[900]!.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius,
                            ),
                          ),
                          child: isGeneratingVideoThumbnail == true
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.0,
                                  ),
                                )
                              : Stack(
                                  fit: StackFit.expand,
                                  alignment: Alignment.center,
                                  children: [
                                    Image.file(
                                      File(
                                        fileName.toString(),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[900]!
                                              .withOpacity(0.7),
                                          border: Border.all(
                                              color: Colors.grey[600]!),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(100.0),
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.play_arrow_outlined,
                                          size: 35.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
              ],
            ),
            SizedBox(height: 5.0),

            // Time
            Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Text(
                DateTime.fromMillisecondsSinceEpoch(widget.post["time"])
                        .toString()
                        .substring(11, 16) +
                    " • " +
                    DateTime.fromMillisecondsSinceEpoch(widget.post["time"])
                        .toString()
                        .substring(0, 10),
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey[700]!,
                ),
              ),
            ),

            // Interactions
            widget.interactions == false
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Like Comment Repost
                      Container(
                        width: 250.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Like Dislike
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    likeDislikePosts(widget.post["_id"]);
                                  },
                                  icon: Icon(
                                    widget.post["likers"].contains(
                                            widget.currentUser["username"])
                                        ? Ionicons.heart
                                        : Ionicons.heart_outline,
                                    size: 20.0,
                                    color: widget.post["likers"].contains(
                                            widget.currentUser["username"])
                                        ? Colors.pinkAccent
                                        : Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LikesListPage(
                                          likers: widget.post["likers"],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    widget.post["likes"].toString(),
                                    style: TextStyle(
                                      fontSize: 11.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(width: 4.0),

                            // Comments
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CommentsPage(
                                      currentUser: widget.currentUser,
                                      post: widget.post,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CommentsPage(
                                            currentUser: widget.currentUser,
                                            post: widget.post,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Icon(
                                      Ionicons.chatbubble_outline,
                                      color: Colors.white,
                                      size: 16.0,
                                    ),
                                  ),
                                  Text(
                                    widget.post["comments"].toString(),
                                    style: TextStyle(
                                      fontSize: 11.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: 4.0),

                            // Repost
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "repostslist");
                              },
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, "repostslist");
                                    },
                                    icon: Icon(
                                      Ionicons.repeat_outline,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                  ),
                                  Text(
                                    widget.post["reposts"].toString(),
                                    style: TextStyle(
                                      fontSize: 11.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Share
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // widget.postOptions();
                              share(widget.post);
                            },
                            icon: Icon(
                              Ionicons.share_social_outline,
                              size: 18.0,
                              color: Colors.white,
                            ),
                          ),
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: Icon(
                          //     Ionicons.share_outline,
                          //     size: 20.0,
                          //     color: Colors.white,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
