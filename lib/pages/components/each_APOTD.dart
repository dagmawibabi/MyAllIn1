import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EachAPOTD extends StatefulWidget {
  const EachAPOTD({super.key, required this.aPOTDObj, this.tag = "null,"});

  final Map aPOTDObj;
  final String tag;

  @override
  State<EachAPOTD> createState() => _EachAPOTDState();
}

class _EachAPOTDState extends State<EachAPOTD> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[900]!,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        image: DecorationImage(
          opacity: 0.1,
          image: NetworkImage(
            widget.aPOTDObj["url"],
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.aPOTDObj["hdurl"].toString() == "null"
              ? Container()
              : Center(
                  child: Container(
                    width: 120.0,
                    height: 150.0,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    child: Hero(
                      tag: widget.tag == "null"
                          ? widget.aPOTDObj["title"]
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
          Expanded(
            child: Container(
              height: 140.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.aPOTDObj["title"],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  // SizedBox(height: 10.0),
                  Text(
                    widget.aPOTDObj["explanation"],
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[400]!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    widget.aPOTDObj["date"],
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[600]!,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 13.0,
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: ElevatedButton(
                  //         style: ButtonStyle(
                  //           backgroundColor: MaterialStateProperty.all(
                  //             Colors.white,
                  //           ),
                  //         ),
                  //         onPressed: () {},
                  //         child: Text(
                  //           "Read More",
                  //           style: TextStyle(
                  //             color: Colors.black,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
