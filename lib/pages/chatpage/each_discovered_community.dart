import 'package:flutter/material.dart';

class EachDiscoveredCommunity extends StatefulWidget {
  const EachDiscoveredCommunity({
    super.key,
    required this.community,
  });

  final Map community;

  @override
  State<EachDiscoveredCommunity> createState() =>
      _EachDiscoveredCommunityState();
}

class _EachDiscoveredCommunityState extends State<EachDiscoveredCommunity> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(top: 2.0, left: 0.0, right: 0.0),
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.pink,
            Colors.blueAccent,
            Colors.greenAccent,
          ],
        ),
      ),
      child: Container(
        height: 200.0,
        margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          // color: Colors.red,
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          image: DecorationImage(
            image: NetworkImage(
              widget.community["profilePic"],
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(bottom: 5.0, left: 8.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.grey[900]!.withOpacity(1.0),
                    Colors.grey[900]!.withOpacity(0.5),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.community["name"].toString(),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "@" + widget.community["username"].toString(),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[300]!,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
