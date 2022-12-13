// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RepostListPage extends StatefulWidget {
  const RepostListPage({super.key});

  @override
  State<RepostListPage> createState() => _RepostListPageState();
}

class _RepostListPageState extends State<RepostListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reposts",
        ),
      ),
    );
  }
}
