import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class AlbumsContainer extends StatefulWidget {
  const AlbumsContainer({
    super.key,
    required this.currentAlbum,
  });

  final Map currentAlbum;

  @override
  State<AlbumsContainer> createState() => _AlbumsContainerState();
}

class _AlbumsContainerState extends State<AlbumsContainer> {
  Color randomContainerColor =
      Colors.accents[Random().nextInt(Colors.accents.length)];

  Future<Color> getImagePalette() async {
    ImageProvider imageProvider = NetworkImage(
      widget.currentAlbum["albumArt"]!,
    );
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            FutureBuilder(
              future: getImagePalette(),
              builder: (context, snapshot) => Container(
                width: 150.0,
                height: 150.0,
                margin: EdgeInsets.only(
                  left: 4.0,
                  top: 4.0,
                ),
                decoration: BoxDecoration(
                  color: snapshot.data == null
                      ? randomContainerColor.withOpacity(0.4)
                      : snapshot.data?.withOpacity(0.6),
                  // color:
                  //     Colors.accents[Random().nextInt(Colors.accents.length)],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                      spreadRadius: 5.0,
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10.0,
                    ),
                  ),
                ),
              ),
            ),
            FutureBuilder(
              future: getImagePalette(),
              builder: (context, snapshot) => Container(
                width: 150.0,
                height: 150.0,
                margin: EdgeInsets.only(
                  left: 8.0,
                  top: 8.0,
                ),
                decoration: BoxDecoration(
                  color: snapshot.data == null
                      ? randomContainerColor.withOpacity(0.6)
                      : snapshot.data?.withOpacity(0.4),
                  // color:
                  //     Colors.accents[Random().nextInt(Colors.accents.length)],
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10.0,
                    ),
                  ),
                ),
              ),
            ),
            Hero(
              tag: widget.currentAlbum["albumArt"]!,
              child: Container(
                width: 150.0,
                height: 150.0,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10.0,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 10.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                ),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.currentAlbum["albumArt"]!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: Colors.white,
                      strokeWidth: 1.0,
                    ),
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.error_outline,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5.0),
        Text(
          widget.currentAlbum["album"]!,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white,
          ),
        ),
        Text(
          widget.currentAlbum["artist"]!,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }
}
