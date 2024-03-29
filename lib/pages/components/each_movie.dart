import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EachMovie extends StatefulWidget {
  const EachMovie({
    super.key,
    required this.movieObject,
  });

  final dynamic movieObject;

  @override
  State<EachMovie> createState() => _EachMovieState();
}

class _EachMovieState extends State<EachMovie> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
      // padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        // image: DecorationImage(
        //   image: NetworkImage("https://image.tmdb.org/t/p/original" +
        //       widget.movieObject["backdrop_path"]),
        //   fit: BoxFit.cover,
        //   opacity: 0.2,
        // ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.grey[900]!.withOpacity(0.4),
              borderRadius: BorderRadius.all(
                Radius.circular(8.5),
              ),
              // borderRadius: BorderRadius.all(
              //   Radius.elliptical(
              //     20.0,
              //     50.0,
              //   ),
              // ),
            ),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey[700]!,
                    strokeWidth: 2.0,
                  ),
                ),
                Hero(
                  tag: "https://image.tmdb.org/t/p/original" +
                      widget.movieObject["poster_path"],
                  child: CachedNetworkImage(
                    width: 200.0,
                    height: 280.0,
                    fit: BoxFit.cover,
                    imageUrl: "https://image.tmdb.org/t/p/original" +
                        widget.movieObject["poster_path"],
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
                //               Image.network(
                //     "https://image.tmdb.org/t/p/original" +
                //         widget.movieObject["poster_path"],
                //     width: 200.0,
                //     height: 280.0,
                //     fit: BoxFit.cover,
                //   ),
              ],
            ),
          ),
          // SizedBox(height: 4.0),
          // Container(
          //   height: 20.0,
          //   width: 150.0,
          //   child: FittedBox(
          //     fit: BoxFit.scaleDown,
          //     child: Text(
          //       widget.movieObject["title"] ?? widget.movieObject["name"],
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 12.0,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
