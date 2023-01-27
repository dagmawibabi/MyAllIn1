import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ChatSidebarButton extends StatefulWidget {
  const ChatSidebarButton({
    super.key,
    this.bottomPadding = 5.0,
    this.iconColor = Colors.white,
    this.backgroundColor = Colors.grey,
    this.radius = 10.0,
    this.netPic = " ",
    this.borderColor = Colors.transparent,
    this.icon = Ionicons.chatbox_ellipses_outline,
  });

  final double bottomPadding;
  final Color iconColor;
  final Color backgroundColor;
  final double radius;
  final String netPic;
  final Color borderColor;
  final IconData icon;

  @override
  State<ChatSidebarButton> createState() => _ChatSidebarButtonState();
}

class _ChatSidebarButtonState extends State<ChatSidebarButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 10),
      curve: ElasticInCurve(),
      child: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
        decoration: BoxDecoration(
          color: widget.borderColor != Colors.transparent
              ? Colors.black
              : widget.borderColor, // widget.borderColor.withOpacity(0.1),
          border: Border(
            left: BorderSide(
              color: widget.borderColor != Colors.transparent
                  ? widget.borderColor
                  : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Container(
          height: 48.0,
          width: 54.0,
          margin: EdgeInsets.only(bottom: widget.bottomPadding),
          decoration: BoxDecoration(
            color: widget.backgroundColor == Colors.grey
                ? Colors.grey[900]!
                : widget.backgroundColor,
            // border: Border.all(
            //     color: widget.borderColor,
            //     width: 2.0,
            //     ),
            borderRadius: BorderRadius.all(
              Radius.circular(widget.radius),
            ),
          ),
          child: widget.netPic != " "
              ? Container(
                  width: 30.0,
                  height: 30.0,
                  // margin: EdgeInsets.all(15.0),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(widget.radius),
                    ),
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.netPic,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: Colors.grey[800]!,
                      strokeWidth: 2.0,
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error_outline,
                    ),
                  ),
                  // Image.network(
                  //   widget.netPic,
                  //   fit: BoxFit.cover,
                  // ),
                )
              : Icon(
                  widget.icon,
                  size: 28.0,
                  color: widget.iconColor,
                ),
        ),
      ),
    );
  }
}
