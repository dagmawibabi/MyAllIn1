import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ContentUploadOptionsBottomSheet extends StatefulWidget {
  const ContentUploadOptionsBottomSheet({
    super.key,
    required this.source,
    required this.pickImageFunction,
  });

  final String source;
  final Function pickImageFunction;

  @override
  State<ContentUploadOptionsBottomSheet> createState() =>
      _ContentUploadOptionsBottomSheetState();
}

class _ContentUploadOptionsBottomSheetState
    extends State<ContentUploadOptionsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        // height: 100.0,
        decoration: BoxDecoration(
          color: Colors.grey[900]!.withOpacity(0.1),
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: ListView(
          children: [
            Column(
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
                SizedBox(height: 100.0),

                // Options
                Container(
                    child: widget.source == "camera"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[900]!,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          await widget.pickImageFunction(
                                            false,
                                            true,
                                            false,
                                            false,
                                          );
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Ionicons.camera_outline,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "Take a Picture",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[900]!,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          await widget.pickImageFunction(
                                            false,
                                            false,
                                            false,
                                            true,
                                          );
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Ionicons.videocam_outline,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "Capture a Video",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[900]!,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          await widget.pickImageFunction(
                                            true,
                                            false,
                                            false,
                                            false,
                                          );
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Ionicons.image_outline,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "Pick a Picture",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[900]!,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                      ),
                                      child: IconButton(
                                        onPressed: () async {
                                          await widget.pickImageFunction(
                                            false,
                                            false,
                                            true,
                                            false,
                                          );
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.video_camera_back_outlined,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      "Choose a Video",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
