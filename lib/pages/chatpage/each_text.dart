import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class EachText extends StatefulWidget {
  const EachText({
    super.key,
    required this.textObject,
    required this.currentUsername,
    required this.editTexts,
    required this.editTextsChange,
  });

  final Map textObject;
  final String currentUsername;
  final bool editTexts;
  final Function editTextsChange;

  @override
  State<EachText> createState() => _EachTextState();
}

class _EachTextState extends State<EachText> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.editTexts == true ? {selected = !selected} : {selected = false};
        setState(() {});
      },
      onLongPress: () {
        selected = true;
        widget.editTextsChange();
        setState(() {});
      },
      child: Container(
        color: selected
            ? Colors.blue.withOpacity(0.1)
            : Colors.grey[900]!.withOpacity(0.001),
        child: Row(
          mainAxisAlignment: widget.textObject["from"] == widget.currentUsername
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: selected == true ? Colors.grey[500]! : Colors.grey[900]!,
                borderRadius:
                    widget.textObject["from"] == widget.currentUsername
                        ? BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          )
                        : BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
              ),
              child: Column(
                crossAxisAlignment:
                    widget.textObject["from"] == widget.currentUsername
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.textObject["content"],
                    style: TextStyle(
                      color: selected == true ? Colors.black : Colors.white,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        DateTime.fromMillisecondsSinceEpoch(
                                widget.textObject["dateTime"])
                            .toString()
                            .substring(11, 16),
                        style: TextStyle(
                          color: selected == true
                              ? Colors.black
                              : Colors.grey[500]!,
                          fontSize: 10.0,
                        ),
                      ),
                      widget.textObject["from"] == widget.currentUsername
                          ? Row(
                              children: [
                                SizedBox(width: 4.0),
                                widget.textObject["seen"].contains(
                                            widget.textObject["to"]) ==
                                        true
                                    // Seen Text
                                    ? Padding(
                                        padding: EdgeInsets.only(bottom: 2.8),
                                        child: Icon(
                                          Ionicons.eye_outline,
                                          size: 14.0,
                                          color: selected == true
                                              ? Colors.black
                                              : Colors.grey[600]!,
                                        ),
                                      )
                                    // Unseen Text
                                    : Padding(
                                        padding: EdgeInsets.only(bottom: 2.8),
                                        child: Icon(
                                          Ionicons.eye_off_outline,
                                          size: 14.0,
                                          color: selected == true
                                              ? Colors.black
                                              : Colors.grey[300]!,
                                        ),
                                      ),
                              ],
                            )
                          : Container(),
                    ],
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
