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
          child: Image.network(
            widget.artistsData["albumArt"]!,
            fit: BoxFit.cover,
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
