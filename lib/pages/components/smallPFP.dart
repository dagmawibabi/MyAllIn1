// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SmallPFP extends StatefulWidget {
  const SmallPFP({super.key, this.size = 40.0});

  final double size;

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
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(100.0),
        ),
      ),
      child: Image.asset(
        "assets/images/me.jpg",
        width: widget.size,
        height: widget.size,
        fit: BoxFit.cover,
      ),
    );
  }
}
