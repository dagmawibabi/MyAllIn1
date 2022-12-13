// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../components/rounded_search_input_box.dart';
import 'chats.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Start of Page
        SizedBox(height: 8.0),
        RoundedSearchInputBox(),

        Chats(),
        Chats(),
        Chats(),
        Chats(),
        Chats(),
        Chats(),
        Chats(),

        // End of Page
        SizedBox(height: 200.0),
      ],
    );
  }
}
