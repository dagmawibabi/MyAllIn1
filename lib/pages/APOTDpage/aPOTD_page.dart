import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/imageViewerPage/image_viewer_page.dart';

class APOTDPage extends StatefulWidget {
  const APOTDPage({
    super.key,
    required this.aPOTDObj,
    this.tag = "null",
  });

  final Map aPOTDObj;
  final String tag;

  @override
  State<APOTDPage> createState() => _APOTDPageState();
}

class _APOTDPageState extends State<APOTDPage> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          widget.aPOTDObj["date"],
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              isFavorite = !isFavorite;
              setState(() {});
            },
            icon: Icon(
              isFavorite == true
                  ? Ionicons.bookmark
                  : Ionicons.bookmark_outline,
              size: 20.0,
              color: isFavorite == true ? Colors.yellow : Colors.white,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            // height: MediaQuery.of(context).size.height,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
              maxHeight: MediaQuery.of(context).size.height * 1.5,
            ),
            width: 500.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                opacity: 0.1,
                image: NetworkImage(
                  widget.aPOTDObj["url"],
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10.0),

                  // Image
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageViewerPage(
                            isNetworkImage: true,
                            networkImage: widget.aPOTDObj["hdurl"].toString(),
                            title: widget.aPOTDObj["title"].toString(),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      child: Hero(
                        tag: widget.tag == "null"
                            ? widget.aPOTDObj["title"].toString()
                            : widget.tag,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: widget.aPOTDObj["hdurl"],
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: Colors.grey[400]!,
                              strokeWidth: 1.0,
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error_outline,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),

                  // Title and Explanation
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.aPOTDObj["title"].toString() == "null"
                            ? Container()
                            : Text(
                                widget.aPOTDObj["title"].toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        SizedBox(height: 6.0),
                        widget.aPOTDObj["copyright"].toString() == "null"
                            ? Container()
                            : Text(
                                "By " + widget.aPOTDObj["copyright"].toString(),
                                style: TextStyle(
                                  color: Colors.grey[400]!,
                                  fontSize: 13.0,
                                ),
                              ),
                        SizedBox(height: 20.0),
                        widget.aPOTDObj["explanation"].toString() == "null"
                            ? Container()
                            : Text(
                                widget.aPOTDObj["explanation"].toString(),
                                style: TextStyle(
                                  color: Colors.grey[200]!,
                                  fontSize: 15.0,
                                  height: 1.4,
                                ),
                              ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                  ),

                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
