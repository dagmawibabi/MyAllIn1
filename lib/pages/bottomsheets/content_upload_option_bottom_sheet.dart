import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/pages/components/rounded_icon_labeled_button.dart';

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
                            GestureDetector(
                              onTap: () async {
                                await widget.pickImageFunction(
                                  false,
                                  true,
                                  false,
                                  false,
                                );
                                Navigator.pop(context);
                              },
                              child: Container(
                                child: RoundedIconLabeledButton(
                                  icon: Ionicons.camera_outline,
                                  label: "Take a Picture",
                                  color: Colors.white,
                                  padding: 14.0,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await widget.pickImageFunction(
                                  false,
                                  false,
                                  false,
                                  true,
                                );
                                Navigator.pop(context);
                              },
                              child: Container(
                                child: RoundedIconLabeledButton(
                                  icon: Ionicons.videocam_outline,
                                  label: "Capture a Video",
                                  color: Colors.white,
                                  padding: 14.0,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await widget.pickImageFunction(
                                  true,
                                  false,
                                  false,
                                  false,
                                );
                                Navigator.pop(context);
                              },
                              child: Container(
                                child: RoundedIconLabeledButton(
                                  icon: Ionicons.image_outline,
                                  label: "Pick a Picture",
                                  color: Colors.white,
                                  padding: 14.0,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await widget.pickImageFunction(
                                  false,
                                  false,
                                  true,
                                  false,
                                );
                                Navigator.pop(context);
                              },
                              child: Container(
                                child: RoundedIconLabeledButton(
                                  icon: Icons.video_camera_back_outlined,
                                  label: "Choose a Video",
                                  color: Colors.white,
                                  padding: 14.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
