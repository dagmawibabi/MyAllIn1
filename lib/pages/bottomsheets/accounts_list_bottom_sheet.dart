import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myallin1/pages/chatpage/chats.dart';
import 'package:myallin1/pages/components/error_messages.dart';

class AccountsListBottomSheet extends StatefulWidget {
  const AccountsListBottomSheet({
    super.key,
    required this.listOfAccounts,
    required this.currentUser,
    required this.listTitle,
  });

  final List listOfAccounts;
  final Map currentUser;
  final String listTitle;

  @override
  State<AccountsListBottomSheet> createState() =>
      _AccountsListBottomSheetState();
}

class _AccountsListBottomSheetState extends State<AccountsListBottomSheet> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: ListView(
        children: [
          // Back Button
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900]!,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          //
          Container(
            width: double.infinity,
            // color: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                widget.listTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0),

          //
          widget.listOfAccounts.isEmpty == true
              ? Container(
                  child: ErrorMessages(
                    title: "No Accounts Here",
                    body: "There are currently no accounts here",
                    color: Colors.grey[400]!,
                  ),
                )
              : Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  // color: Colors.black,
                  child: Column(
                    children: [
                      for (var eachAccount in widget.listOfAccounts)
                        Container(
                          // color: Colors.grey[800]!,
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 0.0,
                          ),
                          child: Chats(
                            chatObject: eachAccount,
                            currentUsername: widget.currentUser["username"],
                            backgroundColor: Colors.grey[900]!,
                            currentUser: widget.currentUser,
                          ),
                        ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
