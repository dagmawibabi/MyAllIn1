// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SmallPFP extends StatefulWidget {
  const SmallPFP({
    super.key,
    this.size = 40.0,
    this.pic = "null",
    this.netpic = "null",
  });

  final double size;
  final String pic;
  final String netpic;

  @override
  State<SmallPFP> createState() => _SmallPFPState();
}

class _SmallPFPState extends State<SmallPFP> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      clipBehavior: Clip.hardEdge,
      // padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        // color: Colors.red,
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(1000.0),
        ),
      ),
      child: widget.pic != "null"
          ? Image.asset(
              widget.pic,
              width: widget.size,
              height: widget.size,
              fit: BoxFit.cover,
            )
          : CachedNetworkImage(
              width: widget.size,
              height: widget.size,
              fit: BoxFit.cover,
              imageUrl: widget.netpic,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                value: downloadProgress.progress,
                color: Colors.grey[800]!,
                strokeWidth: 2.0,
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.error_outline,
              ),
            ),
      //  Image.network(
      //           widget.netpic,
      //           width: widget.size,
      //           height: widget.size,
      //           fit: BoxFit.cover,
      //         ),
    );
  }
}
