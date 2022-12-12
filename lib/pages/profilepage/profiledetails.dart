// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({
    super.key,
    this.icon,
    this.label,
    this.content,
  });

  final dynamic icon;
  final dynamic label;
  final dynamic content;

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900]!.withOpacity(0.4),
          border: Border(
            bottom: BorderSide(
              color: Colors.grey[900]!,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  widget.icon,
                ),
              ),
            ),
            SizedBox(width: 5.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 2.0),
                Text(
                  widget.content,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
