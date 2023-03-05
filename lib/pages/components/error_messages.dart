import 'package:flutter/material.dart';

class ErrorMessages extends StatefulWidget {
  const ErrorMessages({
    super.key,
    required this.title,
    required this.body,
    required this.color,
    this.marginHorizontal = 60,
    this.marginVertical = 200.0,
    this.height = 100.0,
    this.backgroundColor = Colors.black,
  });

  final String title;
  final String body;
  final Color color;
  final Color backgroundColor;
  final double marginHorizontal;
  final double marginVertical;
  final double height;

  @override
  State<ErrorMessages> createState() => _ErrorMessagesState();
}

class _ErrorMessagesState extends State<ErrorMessages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: widget.width,
      height: widget.height,
      margin: EdgeInsets.symmetric(
          vertical: widget.marginVertical, horizontal: widget.marginHorizontal),
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: widget.backgroundColor == Colors.black
            ? Colors.grey[900]!.withOpacity(0.4)
            : widget.backgroundColor,
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
