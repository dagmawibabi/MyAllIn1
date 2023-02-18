import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/components/icon_pill_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../imageViewerPage/image_viewer_page.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key, required this.bookObject});

  final Map bookObject;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Container(
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
              child: Column(
                children: [
                  SizedBox(height: 10.0),

                  // Image
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
                          width: 250.0,
                          // height: 170.0,
                          child: Hero(
                            tag: widget.bookObject["volumeInfo"]["imageLinks"]
                                ["thumbnail"],
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ImageViewerPage(
                                      isNetworkImage: false,
                                      networkImage:
                                          widget.bookObject["volumeInfo"]
                                              ["imageLinks"]["thumbnail"],
                                      title: "Book Cover",
                                    ),
                                  ),
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl: widget.bookObject["volumeInfo"]
                                    ["imageLinks"]["thumbnail"],
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
                          ),
                        )
                      : Container(),
                  SizedBox(height: 15.0),

                  // Title and Author
                  Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.bookObject["volumeInfo"]["title"].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        widget.bookObject["volumeInfo"]["authors"] != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10.0),
                                  Text(
                                    widget.bookObject["volumeInfo"]["authors"]
                                            [0]
                                        .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey[400]!,
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0),

                  // Published By
                  Text(
                    "Pulisher: " +
                        widget.bookObject["volumeInfo"]["publisher"].toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[500]!,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 25.0),

                  // Pages Published Date and Language
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconPillButton(
                        icon: Ionicons.book_outline,
                        label: widget.bookObject["volumeInfo"]["pageCount"]
                            .toString(),
                        backgroundColor: Color.fromARGB(255, 152, 41, 7),
                      ),
                      IconPillButton(
                        icon: Ionicons.calendar_number_outline,
                        label: widget.bookObject["volumeInfo"]["publishedDate"]
                            .toString()
                            .substring(0, 7),
                        backgroundColor: Color.fromARGB(255, 155, 75, 0),
                      ),
                      IconPillButton(
                        icon: Ionicons.language_outline,
                        label: widget.bookObject["volumeInfo"]["language"]
                            .toString(),
                        backgroundColor: Color.fromARGB(255, 155, 75, 0),
                      ),
                    ],
                  ),
                  SizedBox(height: 25.0),

                  // Description
                  Text(
                    "About the book",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[300]!,
                      fontSize: 17.0,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      widget.bookObject["volumeInfo"]["description"].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 15.0,
                        height: 1.35,
                      ),
                    ),
                  ),
                  SizedBox(height: 45.0),

                  // Open
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                Size(20.0, 40.0),
                              ),
                            ),
                            onPressed: () {
                              var url = Uri.parse(widget
                                  .bookObject["volumeInfo"]["previewLink"]);
                              launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: Text(
                              "Open Preview",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
