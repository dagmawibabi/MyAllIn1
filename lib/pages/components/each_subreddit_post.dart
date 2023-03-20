import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../imageViewerPage/image_viewer_page.dart';

class EachSubredditPost extends StatefulWidget {
  const EachSubredditPost({
    super.key,
    required this.subredditPost,
  });

  final dynamic subredditPost;

  @override
  State<EachSubredditPost> createState() => _EachSubredditPostState();
}

class _EachSubredditPostState extends State<EachSubredditPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        // color: Colors.grey[900]!.withOpacity(0.2),
        color: Colors.deepOrange.withOpacity(0.02),
        border: Border.all(
          color: Colors.deepOrange.withOpacity(0.2),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.deepOrange.withOpacity(0.5),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Icon(
                      Ionicons.logo_reddit,
                      color: Colors.deepOrange,
                      size: 25.0,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "u/" + widget.subredditPost["author"].toString(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 3.0),
                      // subreddit_name_prefixed
                      Text(
                        widget.subredditPost["subreddit_name_prefixed"]
                            .toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey[300]!,
                        ),
                      ),
                      // Text(
                      //   DateTime.fromMicrosecondsSinceEpoch(
                      //           (widget.subredditPost["created_utc"].toInt()),
                      //           isUtc: true)
                      //       .toString(),
                      //   style: TextStyle(
                      //     color: Colors.grey[200]!,
                      //     fontSize: 10.0,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  widget.subredditPost["over_18"] == false
                      ? Container()
                      : Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.subredditPost["over_18"] == true
                                  ? Colors.deepOrange.withOpacity(0.5)
                                  : Colors.black.withOpacity(0.0),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: Text(
                            widget.subredditPost["over_18"] == true
                                ? "NSFW"
                                : "",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: widget.subredditPost["over_18"] == true
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        ),
                  SizedBox(height: 5.0),
                  widget.subredditPost["spoiler"] == false
                      ? Container()
                      : Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.subredditPost["spoiler"] == true
                                  ? Colors.yellow.withOpacity(0.5)
                                  : Colors.black.withOpacity(0.0),
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: Text(
                            widget.subredditPost["spoiler"] == true
                                ? "SPOILER"
                                : "",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: widget.subredditPost["spoiler"] == true
                                  ? Colors.yellow
                                  : Colors.white,
                            ),
                          ),
                        ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Text(
            widget.subredditPost["title"],
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 15.0),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageViewerPage(
                    isNetworkImage: true,
                    networkImage: widget.subredditPost["url"],
                    title: "u/" + widget.subredditPost["author"].toString(),
                  ),
                ),
              );
            },
            child: Container(
              height: 350.0,
              width: double.infinity,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.subredditPost["url"],
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: Colors.deepOrange,
                    strokeWidth: 1.0,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error_outline,
                ),
              ),
            ),
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(
                    Ionicons.arrow_up_outline,
                    size: 18.0,
                    color: Colors.deepOrange,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    widget.subredditPost["ups"].toString(),
                    style: TextStyle(
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Ionicons.arrow_down_outline,
                    size: 18.0,
                    color: Colors.lightBlue,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    widget.subredditPost["downs"].toString(),
                    style: TextStyle(
                      color: Colors.lightBlue,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Ionicons.repeat_outline,
                    size: 18.0,
                    color: Colors.tealAccent,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    widget.subredditPost["num_crossposts"].toString(),
                    style: TextStyle(
                      color: Colors.tealAccent,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Ionicons.trophy_outline,
                    size: 17.0,
                    color: Colors.yellow,
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    widget.subredditPost["total_awards_received"].toString(),
                    style: TextStyle(
                      color: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 5.0),
        ],
      ),
    );
  }
}
