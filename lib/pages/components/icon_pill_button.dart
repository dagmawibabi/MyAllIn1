import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class IconPillButton extends StatefulWidget {
  const IconPillButton({
    super.key,
    this.chosen = false,
    this.icon = Icons.abc,
    required this.label,
    this.chosenColor = Colors.white,
    this.backgroundColor = Colors.black,
    this.border = 0.0,
    this.boldLabel = false,
    this.iconOff = false,
  });

  final bool chosen;
  final IconData icon;
  final String label;
  final Color chosenColor;
  final Color backgroundColor;
  final double border;
  final bool boldLabel;
  final bool iconOff;

  @override
  State<IconPillButton> createState() => _IconPillButtonState();
}

class _IconPillButtonState extends State<IconPillButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: widget.chosen == true
            ? widget.chosenColor
            : widget.backgroundColor == Colors.black
                ? Colors.grey[900]!.withOpacity(0.4)
                : widget.backgroundColor,
        border: Border.all(
          color: widget.border != 0.0
              ? Colors.white.withOpacity(0.4)
              : Colors.transparent,
          width: widget.border,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.iconOff == true
              ? Container()
              : Icon(
                  widget.icon,
                  size: 18.0,
                  color: widget.chosen == true ? Colors.black : Colors.white,
                ),
          SizedBox(width: 8.0),
          Text(
            widget.label,
            style: TextStyle(
              color: widget.chosen == true ? Colors.black : Colors.white,
              fontWeight:
                  widget.boldLabel ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
