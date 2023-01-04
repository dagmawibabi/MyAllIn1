import 'package:flutter/material.dart';

class ChatDateDivider extends StatefulWidget {
  const ChatDateDivider({super.key, required this.dateTime});

  final dynamic dateTime;

  @override
  State<ChatDateDivider> createState() => _ChatDateDividerState();
}

class _ChatDateDividerState extends State<ChatDateDivider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
      margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.3),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Text(
        widget.dateTime.toString().substring(0, 10),
        style: TextStyle(
          color: Colors.grey[400]!,
          fontSize: 12.0,
        ),
      ),
    );
  }
}
