// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LikesListPage extends StatefulWidget {
  const LikesListPage({super.key});

  @override
  State<LikesListPage> createState() => _LikesListPageState();
}

class _LikesListPageState extends State<LikesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Likes",
        ),
      ),
    );
  }
}
