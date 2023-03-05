import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/components/rounded_input_box.dart';

class CreateCommunityDialog extends StatefulWidget {
  const CreateCommunityDialog({
    super.key,
    required this.currentUser,
    required this.createNewCommunity,
  });

  final Map currentUser;
  final Function createNewCommunity;

  @override
  State<CreateCommunityDialog> createState() => _CreateCommunityDialogState();
}

class _CreateCommunityDialogState extends State<CreateCommunityDialog> {
  TextEditingController communityNameController = TextEditingController();
  TextEditingController communityUsernameController = TextEditingController();
  TextEditingController communityBioController = TextEditingController();
  bool isCreating = false;
  void createCommunity() async {
    isCreating = true;
    setState(() {});
    Map newCommunity = {
      "name": communityNameController.text.trim(),
      "username": communityUsernameController.text.toLowerCase().trim(),
      "bio": communityBioController.text.toLowerCase().trim(),
      "private": false,
      "owner": widget.currentUser["username"],
    };
    await widget.createNewCommunity(newCommunity);
    isCreating = false;
    setState(() {});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 500.0,
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Color.fromARGB(255, 18, 18, 18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Container(
                child: Text(
                  "Create Community",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(left: 18.0, bottom: 5.0),
              child: Text(
                "Title",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
            RoundedInputBox(
              hintText: "title",
              hintTextColor: Colors.grey,
              suffixIcon: Icons.abc,
              suffixIconColor: Colors.grey[400],
              controller: communityNameController,
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(left: 18.0, bottom: 5.0),
              child: Text(
                "Username",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
            RoundedInputBox(
              hintText: "community (without the @ )",
              hintTextColor: Colors.grey,
              suffixIcon: Ionicons.link_outline,
              suffixIconColor: Colors.grey[400],
              controller: communityUsernameController,
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(left: 18.0, bottom: 5.0),
              child: Text(
                "Bio",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
            RoundedInputBox(
              hintText: "Welcome to our community...",
              hintTextColor: Colors.grey,
              suffixIcon: Ionicons.pencil_sharp,
              suffixIconColor: Colors.grey[400],
              controller: communityBioController,
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 14.0),
                      margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Pick Profile Picture",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 14.0),
                      margin: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Pick Header Picture",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(23.0),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.pink,
                    Colors.greenAccent,
                    Colors.blueAccent,
                  ],
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  createCommunity();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: isCreating == true ? 8.0 : 14.0),
                  margin: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: Center(
                    child: isCreating == true
                        ? SizedBox(
                            height: 30.0,
                            width: 30.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 1.0,
                              color: Colors.lightBlue,
                            ),
                          )
                        : Text(
                            "CREATE",
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       style: ButtonStyle(
            //         fixedSize: MaterialStateProperty.all(
            //           Size(200.0, 40.0),
            //         ),
            //         backgroundColor: MaterialStateProperty.all(
            //           Colors.lightBlue,
            //         ),
            //       ),
            //       onPressed: () {},
            //       child: Text(
            //         "Create",
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
