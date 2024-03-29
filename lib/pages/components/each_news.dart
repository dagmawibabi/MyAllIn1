import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myallin1/pages/imageViewerPage/image_viewer_page.dart';
import 'package:url_launcher/url_launcher.dart';

class EachNews extends StatefulWidget {
  const EachNews({
    super.key,
    this.newsObject,
    this.extended = true,
  });

  final dynamic newsObject;
  final bool extended;

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
        decoration: widget.newsObject["urlToImage"] == "" ||
                widget.newsObject["urlToImage"] == null
            ? BoxDecoration(
                color: Colors.grey[900]!.withOpacity(0.2),
                border: Border.all(
                  color: Colors.grey[900]!,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              )
            : BoxDecoration(
                color: Colors.grey[900]!.withOpacity(0.2),
                border: Border.all(
                  color: Colors.grey[900]!,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                image: DecorationImage(
                  opacity: 0.1,
                  image: NetworkImage(
                    widget.newsObject["urlToImage"],
                  ),
                  fit: BoxFit.cover,
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
                    child: GestureDetector(
                      onLongPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ImageViewerPage(
                              isNetworkImage: true,
                              networkImage: widget.newsObject["urlToImage"],
                              title: widget.newsObject["source"]["name"],
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: widget.newsObject["title"],
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
            SizedBox(height: widget.extended == true ? 10.0 : 0.0),
            widget.newsObject["description"] == "" ||
                    widget.newsObject["description"] == null
                ? Container()
                : Text(
                    widget.extended == true
                        ? widget.newsObject["description"]
                        : "",
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14.0,
                      height: widget.extended == true ? 1.4 : 0.0,
                    ),
                  ),
            SizedBox(height: widget.extended == true ? 10.0 : 0.0),
            // Published Date and Time
            widget.extended == false
                ? Container()
                : Row(
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
