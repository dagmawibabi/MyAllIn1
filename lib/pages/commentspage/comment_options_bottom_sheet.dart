import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/components/rounded_icon_labeled_button.dart';

class CommentOptionsBottomSheet extends StatefulWidget {
  const CommentOptionsBottomSheet({
    super.key,
    required this.deleteComment,
    required this.commentObject,
  });

  final Function deleteComment;
  final Map commentObject;

  @override
  State<CommentOptionsBottomSheet> createState() =>
      _CommentOptionsBottomSheetState();
}

class _CommentOptionsBottomSheetState extends State<CommentOptionsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      padding: EdgeInsets.only(top: 2.0, left: 0.0, right: 0.0),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
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
        padding: EdgeInsets.only(top: 40.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Color.fromARGB(255, 18, 18, 18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RoundedIconLabeledButton(
              icon: Icons.report_gmailerrorred,
              label: "Report",
              color: Colors.yellowAccent,
            ),
            RoundedIconLabeledButton(
              icon: Ionicons.eye_off_outline,
              label: "Hide",
              color: Colors.orange,
            ),
            GestureDetector(
              onTap: () async {
                // isDeleting = true;
                // setState(() {});
                widget.deleteComment(widget.commentObject["_id"]);
                Navigator.pop(context);
              },
              child: RoundedIconLabeledButton(
                icon: Icons.delete_forever_outlined,
                label: "Delete",
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
