import 'package:flutter/material.dart';

class ErrorMessages extends StatefulWidget {
  const ErrorMessages({
    super.key,
    required this.title,
    required this.body,
    required this.color,
  });

  final String title;
  final String body;
  final Color color;

  @override
  State<ErrorMessages> createState() => _ErrorMessagesState();
}

class _ErrorMessagesState extends State<ErrorMessages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 200.0, horizontal: 60.0),
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.4),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              color: widget.color,
            ),
          ),
          SizedBox(height: 12.0),
          Text(
            widget.body,
            style: TextStyle(
              color: widget.color.withAlpha(130),
            ),
          ),
        ],
      ),
    );
  }
}
