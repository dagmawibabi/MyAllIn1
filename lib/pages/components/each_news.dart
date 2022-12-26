import 'package:flutter/material.dart';

class EachNews extends StatefulWidget {
  const EachNews({
    super.key,
    this.newsObject,
  });

  final dynamic newsObject;

  @override
  State<EachNews> createState() => _EachNewsState();
}

class _EachNewsState extends State<EachNews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey[900]!.withOpacity(0.4),
        border: Border.all(
          color: Colors.grey[900]!,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.newsObject["urlToImage"],
          ),
          SizedBox(height: 10.0),
          Text(
            widget.newsObject["title"],
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Divider(
            color: Colors.grey[850],
          ),
          Text(
            widget.newsObject["description"],
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 5.0),
          Divider(
            color: Colors.grey[850],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${widget.newsObject["source"]["name"]}",
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              Text(
                "${widget.newsObject["publishedAt"].toString().substring(11, 19)}",
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
              Text(
                "${widget.newsObject["publishedAt"].toString().substring(0, 10)}",
                style: TextStyle(
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
