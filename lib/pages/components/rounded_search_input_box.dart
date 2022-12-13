// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class RoundedSearchInputBox extends StatefulWidget {
  const RoundedSearchInputBox({super.key});

  @override
  State<RoundedSearchInputBox> createState() => _RoundedSearchInputBoxState();
}

class _RoundedSearchInputBoxState extends State<RoundedSearchInputBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0.0, right: 5.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Ionicons.search_outline,
            color: Colors.white,
          ),
          suffixIcon: Icon(
            Ionicons.paper_plane_outline,
            color: Colors.white,
          ),
          hintText: "Search",
          hintStyle: TextStyle(
            color: Colors.white,
          ),
        ),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
