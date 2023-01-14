import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EachNews extends StatefulWidget {
  const EachNews({
    super.key,
    this.newsObject,
  });

  final dynamic newsObject;

  @override
  State<EachNews> createState() => _EachNewsState();
}

class _EachNewsState extends State<EachNews> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var newsHomePage = Uri.parse(widget.newsObject["url"]);
        launchUrl(newsHomePage);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.grey[900]!.withOpacity(0.4),
          border: Border.all(
            color: Colors.grey[900]!,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 5.0),
              child: Text(
                "${widget.newsObject["source"]["name"]}",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[200]!,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            widget.newsObject["urlToImage"] == "" ||
                    widget.newsObject["urlToImage"] == null
                ? Container()
                : Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.newsObject["urlToImage"],
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
                    //   widget.newsObject["urlToImage"],
                    // ),
                  ),

            SizedBox(height: 10.0),
            Text(
              widget.newsObject["title"],
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                height: 1.4,
              ),
            ),
            SizedBox(height: 10.0),
            widget.newsObject["description"] == "" ||
                    widget.newsObject["description"] == null
                ? Container()
                : Text(
                    widget.newsObject["description"],
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14.0,
                      height: 1.4,
                    ),
                  ),
            SizedBox(height: 10.0),
            // Published Date and Time
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${widget.newsObject["publishedAt"].toString().substring(11, 19)}",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  "${widget.newsObject["publishedAt"].toString().substring(0, 10)}",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
