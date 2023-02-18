import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EachBook extends StatefulWidget {
  const EachBook({super.key, required this.bookObject});

  final Map bookObject;

  @override
  State<EachBook> createState() => _EachBookState();
}

class _EachBookState extends State<EachBook> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: widget.bookObject["volumeInfo"]["imageLinks"] != null
          ? EdgeInsets.all(5.0)
          : EdgeInsets.symmetric(vertical: 12.0, horizontal: 2.0),
      decoration: widget.bookObject["volumeInfo"]["imageLinks"] != null
          ? BoxDecoration(
              border: Border.all(
                color: Colors.grey[900]!,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
              image: DecorationImage(
                opacity: 0.1,
                image: NetworkImage(
                  widget.bookObject["volumeInfo"]["imageLinks"]
                      ["smallThumbnail"],
                ),
                fit: BoxFit.cover,
              ),
            )
          : BoxDecoration(
              border: Border.all(
                color: Colors.grey[900]!,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
      child: Row(
        children: [
          widget.bookObject["volumeInfo"]["imageLinks"] != null
              ? Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[900]!,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  width: 120.0,
                  height: 170.0,
                  child: Hero(
                    tag: widget.bookObject["volumeInfo"]["imageLinks"]
                        ["thumbnail"],
                    child: CachedNetworkImage(
                      imageUrl: widget.bookObject["volumeInfo"]["imageLinks"]
                          ["thumbnail"],
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
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : Container(),
          SizedBox(width: 10.0),
          Container(
            height: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title and Author
                Container(
                  width: widget.bookObject["volumeInfo"]["imageLinks"] != null
                      ? 240.0
                      : 350.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.bookObject["volumeInfo"]["title"].toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      widget.bookObject["volumeInfo"]["authors"] != null
                          ? Column(
                              children: [
                                SizedBox(height: 5.0),
                                Container(
                                  width: widget.bookObject["volumeInfo"]
                                              ["imageLinks"] !=
                                          null
                                      ? 240.0
                                      : 350.0,
                                  child: Text(
                                    "by " +
                                        widget.bookObject["volumeInfo"]
                                                ["authors"][0]
                                            .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey[400]!,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),

                // Description
                widget.bookObject["volumeInfo"]["description"] != null
                    ? Container(
                        height:
                            widget.bookObject["volumeInfo"]["authors"] != null
                                ? 60.0
                                : 80.0,
                        width: widget.bookObject["volumeInfo"]["imageLinks"] !=
                                null
                            ? 240.0
                            : 350.0,
                        child: Text(
                          widget.bookObject["volumeInfo"]["description"]
                              .toString(),
                          maxLines:
                              widget.bookObject["volumeInfo"]["authors"] != null
                                  ? 3
                                  : 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[300],
                          ),
                        ),
                      )
                    : Container(
                        child: Text(
                          "No Description",
                          maxLines:
                              widget.bookObject["volumeInfo"]["authors"] != null
                                  ? 3
                                  : 4,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),

                // Pages and Language
                Container(
                  width: widget.bookObject["volumeInfo"]["imageLinks"] != null
                      ? 240.0
                      : 360.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.bookObject["volumeInfo"]["pageCount"]
                                .toString() +
                            " pages",
                        style: TextStyle(
                          color: Colors.grey[500]!,
                          fontSize: 12.5,
                        ),
                      ),
                      Text(
                        "Language: " +
                            widget.bookObject["volumeInfo"]["language"]
                                .toString(),
                        style: TextStyle(
                          color: Colors.grey[500]!,
                          fontSize: 12.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
