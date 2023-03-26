import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ArtistsContainer extends StatefulWidget {
  const ArtistsContainer({
    super.key,
    required this.artistsData,
  });

  final Map artistsData;

  @override
  State<ArtistsContainer> createState() => _ArtistsContainerState();
}

class _ArtistsContainerState extends State<ArtistsContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150.0,
          height: 150.0,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500.0),
          ),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: widget.artistsData["albumArt"]!,
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
        SizedBox(height: 10.0),
        Text(
          widget.artistsData["artist"]!,
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
