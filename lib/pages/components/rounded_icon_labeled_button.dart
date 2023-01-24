import 'package:flutter/material.dart';

class RoundedIconLabeledButton extends StatefulWidget {
  const RoundedIconLabeledButton({
    super.key,
    this.isLoading = false,
    required this.icon,
    required this.label,
    required this.color,
    this.size = 100,
    this.padding = 10.0,
    this.hasBorder = true,
  });

  final bool isLoading;
  final IconData icon;
  final String label;
  final Color color;
  final double size;
  final double padding;
  final bool hasBorder;

  @override
  State<RoundedIconLabeledButton> createState() =>
      _RoundedIconLabeledButtonState();
}

class _RoundedIconLabeledButtonState extends State<RoundedIconLabeledButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.all(widget.isLoading == true ? 7.5 : widget.padding),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 18, 18, 18),
              border: Border.all(
                color: widget.hasBorder == true
                    ? widget.color
                    : Colors.transparent,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  100.0,
                ),
              ),
            ),
            child: widget.isLoading == true
                ? Container(
                    child: CircularProgressIndicator(
                      color: widget.color,
                      strokeWidth: 2.0,
                    ),
                  )
                : Icon(
                    widget.icon,
                    size: 30.0,
                    color: widget.color,
                  ),
          ),
          SizedBox(height: 10.0),
          Text(
            widget.label,
            style: TextStyle(
              color: widget.color,
            ),
          ),
        ],
      ),
    );
  }
}
