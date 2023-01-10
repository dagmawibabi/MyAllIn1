import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_downloader/image_downloader.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailBottomSheet extends StatefulWidget {
  const MovieDetailBottomSheet({
    super.key,
    required this.movieObject,
    required this.isSeries,
  });

  final Map movieObject;
  final bool isSeries;

  @override
  State<MovieDetailBottomSheet> createState() => _MovieDetailBottomSheetState();
}

class _MovieDetailBottomSheetState extends State<MovieDetailBottomSheet> {
  Map movieDetails = {};
  bool moviesLoading = true;
  bool isDownloading = false;
  bool isDownloadDone = false;

  void getMovieDetails() async {
    var url = "https://api.themoviedb.org/3/movie/" +
        widget.movieObject["id"].toString() +
        "?api_key=38d6559cd7b9ccdd0dd57ccca36e49fb&language=en-US";
    var uri = Uri.parse(url);
    var result = await http.get(uri);
    dynamic resultJSON = jsonDecode(result.body);
    movieDetails = resultJSON;
    moviesLoading = false;
    setState(() {});
  }

  void downloadMoviePoster(String url) async {
    isDownloading = true;
    setState(() {});
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(url);
      if (imageId == null) {
        return;
      }

      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
      isDownloading = false;
      isDownloadDone = true;
      setState(() {});
    } on PlatformException catch (error) {
      print("error");
      isDownloading = false;
      isDownloadDone = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.isSeries == false ? getMovieDetails() : () {};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        image: DecorationImage(
          image: NetworkImage("https://image.tmdb.org/t/p/original" +
              widget.movieObject["backdrop_path"]),
          fit: BoxFit.cover,
          // opacity: 0.2,
        ),
      ),
      child: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: ListView(
              children: [
                // Movie Poster
                Stack(
                  children: [
                    Image.network(
                      "https://image.tmdb.org/t/p/original" +
                          widget.movieObject["poster_path"],
                      // height: 550.0,
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                    ),
                    Container(
                      // padding: EdgeInsets.all(0.0),
                      // decoration: BoxDecoration(
                      //   color: Colors.black.withOpacity(0.4),
                      //   borderRadius: BorderRadius.only(
                      //     // topRight: Radius.circular(100.0),
                      //     // bottomLeft: Radius.circular(100.0),
                      //     bottomRight: Radius.circular(30.0),
                      //   ),
                      // ),
                      child: Row(
                        // mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(0.0),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.4),
                              borderRadius: BorderRadius.only(
                                // topRight: Radius.circular(100.0),
                                // bottomLeft: Radius.circular(100.0),
                                bottomRight: Radius.circular(30.0),
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
                          Container(
                            child: isDownloading == true
                                ? Container(
                                    width: 45.0,
                                    height: 46.0,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 12.0),
                                    child: CircularProgressIndicator(
                                      color: Colors.grey[400]!,
                                      strokeWidth: 3.0,
                                    ),
                                  )
                                : Container(
                                    padding: EdgeInsets.only(left: 8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.4),
                                      borderRadius: BorderRadius.only(
                                        // topRight: Radius.circular(100.0),
                                        // bottomLeft: Radius.circular(100.0),
                                        bottomLeft: Radius.circular(30.0),
                                      ),
                                    ),
                                    child: isDownloadDone == true
                                        ? IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.download_done_outlined,
                                            ),
                                          )
                                        : IconButton(
                                            onPressed: () {
                                              downloadMoviePoster(
                                                  "https://image.tmdb.org/t/p/original" +
                                                      widget.movieObject[
                                                          "poster_path"]);
                                            },
                                            icon: Icon(
                                              Icons.download_outlined,
                                            ),
                                          ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Movie Details
                Container(
                  // height: 500.0,
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    top: 20.0,
                    bottom: 100.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.8),
                    // borderRadius: BorderRadius.only(
                    //   topLeft: Radius.circular(20.0),
                    //   topRight: Radius.circular(20.0),
                    // ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Movie Title
                      Text(
                        widget.isSeries == true
                            ? widget.movieObject["name"].toString()
                            : widget.movieObject["title"].toString(),
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 14.0),

                      // Movie Runtime Release Date Rating and Language
                      Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Row(
                          mainAxisAlignment: widget.isSeries == true
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.spaceBetween,
                          children: [
                            moviesLoading == true
                                ? Container()
                                : Row(
                                    children: [
                                      Icon(
                                        Icons.timer_outlined,
                                        size: 18.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        movieDetails["runtime"].toString() +
                                            " mins",
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                            Row(
                              children: [
                                Icon(
                                  Ionicons.calendar_outline,
                                  size: 18.0,
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  widget.isSeries == true
                                      ? widget.movieObject["first_air_date"]
                                      : widget.movieObject["release_date"]
                                          .toString(),
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            widget.isSeries == true
                                ? SizedBox(width: 30.0)
                                : Container(),
                            Row(
                              children: [
                                Icon(
                                  Icons.volunteer_activism_outlined,
                                  size: 18.0,
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  widget.movieObject["vote_average"].toString(),
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                              ],
                            ),
                            widget.isSeries == true
                                ? SizedBox(width: 30.0)
                                : Container(),
                            Row(
                              children: [
                                Icon(
                                  Ionicons.language_outline,
                                  size: 18.0,
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  widget.movieObject["original_language"]
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),

                      // Movie Genres
                      moviesLoading == true
                          ? Container()
                          : Container(
                              height: 30.0,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  Row(
                                    children: [
                                      for (var genre in movieDetails["genres"])
                                        Container(
                                          margin: EdgeInsets.only(right: 10.0),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20.0,
                                            vertical: 6.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.orangeAccent,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(100.0),
                                            ),
                                          ),
                                          child: Text(
                                            genre["name"].toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                      widget.isSeries == true
                          ? SizedBox(height: 0.0)
                          : SizedBox(height: 20.0),

                      // Movie Tagline
                      movieDetails["tagline"] != "" && widget.isSeries == false
                          ? Column(
                              children: [
                                Container(
                                  // width: 300.0,
                                  child: Text(
                                    movieDetails["tagline"].toString(),
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0),
                              ],
                            )
                          : Container(),

                      // Movie Description
                      Text(
                        widget.movieObject["overview"],
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          height: 1.4,
                        ),
                      ),
                      SizedBox(height: 20.0),

                      // Movie Runtime Release Date Rating and Language
                      moviesLoading == true
                          ? Container()
                          : Container(
                              padding: EdgeInsets.only(right: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.attach_money,
                                        size: 18.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        "Budget:  \$" +
                                            movieDetails["budget"].toString(),
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.0),
                                  Row(
                                    children: [
                                      Icon(
                                        Ionicons.cash_outline,
                                        size: 18.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Text(
                                        "Revenue:  \$" +
                                            movieDetails["revenue"].toString(),
                                        style: TextStyle(
                                          color: Colors.grey[400],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25.0),
                                ],
                              ),
                            ),

                      // Movie Production Company
                      moviesLoading == true
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movieDetails["production_companies"].length >
                                          1
                                      ? "Production Companies"
                                      : "Production Company",
                                  style: TextStyle(
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  height: 50.0,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Row(
                                        children: [
                                          for (var genre in movieDetails[
                                              "production_companies"])
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 10.0, bottom: 10.0),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 6.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.cyanAccent,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(100.0),
                                                ),
                                              ),
                                              child: Text(
                                                genre["name"].toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15.0),
                              ],
                            ),

                      // Movie Production Country
                      moviesLoading == true
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movieDetails["production_countries"].length >
                                          1
                                      ? "Production Countries"
                                      : "Production Country",
                                  style: TextStyle(
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  height: 50.0,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Row(
                                        children: [
                                          for (var genre in movieDetails[
                                              "production_countries"])
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 10.0, bottom: 10.0),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 6.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.tealAccent,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(100.0),
                                                ),
                                              ),
                                              child: Text(
                                                genre["name"].toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.0),
                              ],
                            ),

                      // Series Production Country
                      widget.isSeries == false
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.movieObject["origin_country"].length >
                                          1
                                      ? "Origin Countries"
                                      : "Origin Country",
                                  style: TextStyle(
                                    color: Colors.grey[200],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  height: 50.0,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      Row(
                                        children: [
                                          for (var originCountry in widget
                                              .movieObject["origin_country"])
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: 10.0, bottom: 10.0),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 6.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.tealAccent,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(100.0),
                                                ),
                                              ),
                                              child: Text(
                                                originCountry.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                      SizedBox(height: 20.0),

                      // Visit Homepage
                      moviesLoading == true
                          ? Container()
                          : Container(
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(
                                    Size(double.infinity, 50.0),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.black.withOpacity(0.5),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.open_in_new,
                                      color: Colors.lightBlue,
                                    ),
                                    SizedBox(width: 8.0),
                                    Text(
                                      "Visit Homepage",
                                      style: TextStyle(
                                        color: Colors.lightBlue,
                                      ),
                                    ),
                                  ],
                                ),
                                onPressed: () {
                                  var movieHomePage =
                                      Uri.parse(movieDetails["homepage"]);
                                  launchUrl(movieHomePage);
                                },
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
