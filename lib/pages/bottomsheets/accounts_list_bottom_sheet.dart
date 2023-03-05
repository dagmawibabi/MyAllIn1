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
    return Container(
      height: 500.0,
      padding: EdgeInsets.only(top: 2.0, left: 0.0, right: 0.0),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Color.fromARGB(255, 10, 10, 10),
        ),
        child: ListView(
          children: [
            // Back Button
            // Row(
            //   children: [
            //     Container(
            //       decoration: BoxDecoration(
            //         color: Colors.grey[900]!,
            //         borderRadius: BorderRadius.only(
            //           topRight: Radius.circular(20.0),
            //           bottomRight: Radius.circular(20.0),
            //         ),
            //       ),
            //       child: IconButton(
            //         onPressed: () {
            //           Navigator.pop(context);
            //         },
            //         icon: Icon(
            //           Icons.arrow_back,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 20.0),
            // //
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.listTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.listOfAccounts.length.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

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
      ),
    );
  }
}
