import 'package:flutter/material.dart';

class CommunityInfoBar extends StatefulWidget {
  const CommunityInfoBar({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.trailingIcon,
  });

  final IconData leadingIcon;
  final String title;
  final IconData trailingIcon;

  @override
  State<CommunityInfoBar> createState() => _CommunityInfoBarState();
}

class _CommunityInfoBarState extends State<CommunityInfoBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.5),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  widget.leadingIcon,
                ),
              ),
              Text(
                widget.title,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              widget.trailingIcon,
            ),
          ),
        ],
      ),
    );
  }
}
