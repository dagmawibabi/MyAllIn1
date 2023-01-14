import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PostTag extends StatefulWidget {
  const PostTag({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  State<PostTag> createState() => _PostTagState();
}

class _PostTagState extends State<PostTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        // color: Colors.redAccent.withOpacity(1),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            widget.icon,
            size: 16.0,
            color: widget.color,
          ),
          SizedBox(width: 5.0),
          Padding(
            padding: EdgeInsets.only(top: widget.text == "Spoiler" ? 0.0 : 0.0),
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: widget.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
