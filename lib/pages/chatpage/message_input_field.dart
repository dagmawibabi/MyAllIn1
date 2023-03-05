import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MessageInputField extends StatefulWidget {
  const MessageInputField({
    super.key,
    this.textController,
    this.attachFunction,
    this.sendFunction,
    this.hintText = "Type message ...",
    this.backgroundColor = Colors.black,
    this.showAttachIcon = true,
    this.maxLines = 1,
    this.sendFunctionLoading = false,
  });

  final dynamic textController;
  final dynamic attachFunction;
  final dynamic sendFunction;
  final String hintText;
  final Color backgroundColor;
  final bool showAttachIcon;
  final bool sendFunctionLoading;
  final int maxLines;

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  @override
  Widget build(BuildContext context) {
    return // Input Box
        Container(
      // margin: EdgeInsets.only(left: 30.0),
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      decoration: BoxDecoration(
        color: widget.backgroundColor == Colors.black
            ? Color.fromARGB(255, 18, 18, 18)
            : widget.backgroundColor,
        // border: Border.all(
        //   color: Colors.grey[850]!,
        // ),
        borderRadius: BorderRadius.all(Radius.circular(0.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              widget.showAttachIcon == true
                  ? IconButton(
                      onPressed: () async {
                        await widget.attachFunction();
                      },
                      icon: Icon(
                        Ionicons.attach_outline,
                      ),
                    )
                  : Container(
                      width: 10.0,
                    ),
              Container(
                width: widget.showAttachIcon == true ? 310.0 : 352.0,
                // height: 35.0,
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: widget.backgroundColor == Colors.black
                      ? Color.fromARGB(255, 18, 18, 18)
                      : widget.backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: TextField(
                  controller: widget.textController,
                  minLines: widget.maxLines,
                  maxLines: 10,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: Colors.grey[500]!,
                    ),
                  ),
                ),
              ),
            ],
          ),
          widget.sendFunctionLoading == true
              ? Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CircularProgressIndicator(
                      color: Colors.grey[200]!,
                      strokeWidth: 1.0,
                    ),
                  ),
                )
              : IconButton(
                  onPressed: () async {
                    await widget.sendFunction();
                  },
                  icon: Icon(
                    Ionicons.paper_plane_outline,
                  ),
                ),
        ],
      ),
    );
  }
}
