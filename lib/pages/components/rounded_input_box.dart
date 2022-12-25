// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RoundedInputBox extends StatefulWidget {
  const RoundedInputBox({
    super.key,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIcon,
    this.suffixIconColor,
    this.hintText,
    this.hintTextColor,
    this.controller,
  });

  final dynamic prefixIcon;
  final dynamic prefixIconColor;
  final dynamic suffixIcon;
  final dynamic suffixIconColor;
  final dynamic hintText;
  final dynamic hintTextColor;
  final dynamic controller;

  @override
  State<RoundedInputBox> createState() => _RoundedInputBoxState();
}

class _RoundedInputBoxState extends State<RoundedInputBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0.0, left: 18.0, right: 5.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          // prefixIcon: widget.prefixIcon != null
          //     ? Icon(
          //         widget.prefixIcon,
          //         color: widget.prefixIconColor ?? Colors.white,
          //       )
          //     : Icon(
          //         Icons.abc,
          //         color: Colors.grey[900],
          //       ),
          suffixIcon: widget.suffixIcon != null
              ? Icon(
                  widget.suffixIcon,
                  color: widget.suffixIconColor ?? Colors.white,
                )
              : Icon(
                  Icons.abc,
                  color: Colors.grey[900],
                ),
          hintText: widget.hintText ?? "Search",
          hintStyle: TextStyle(
            color: widget.hintTextColor ?? Colors.white,
          ),
        ),
        style: TextStyle(
          color: widget.hintTextColor ?? Colors.white,
        ),
      ),
    );
  }
}
