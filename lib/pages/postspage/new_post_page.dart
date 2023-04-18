// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/config/config.dart';
import 'package:myallin1/pages/bottomsheets/content_upload_option_bottom_sheet.dart';
import 'package:myallin1/pages/components/profile_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({
    super.key,
    required this.currentUser,
    required this.newPostFunction,
    required this.uploadPostFunction,
  });

  final Map currentUser;
  final Function newPostFunction;
  final Function uploadPostFunction;

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  TextEditingController postContentController = TextEditingController();
  bool isPosting = false;
  bool imageSelected = false;
  bool videoSelected = false;
  dynamic imageFile;
  dynamic imageName;
  dynamic fileName;
  bool isGeneratingVideoThumbnail = false;

  bool isNSFW = false;
  bool isHidden = false;
  bool isSpoiler = false;
  bool isGore = false;

  void pickImage(imageFromGallery, imageFromCamera, videoFromGallery,
      videoFromCamera) async {
    // // Pick multiple images
    // final List<XFile>? images =
    //     await _picker.pickMultiImage();

    final ImagePicker _picker = ImagePicker();

    if (imageFromGallery == true) {
      // Pick an image
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        requestFullMetadata: true,
      );
      imageFile = await image?.readAsBytes();
      // imageFile = image?.path;
      imageName = image?.name;
      imageSelected = true;
      videoSelected = false;
      setState(() => {});
    } else if (imageFromCamera == true) {
      // Capture a photo
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      imageFile = await image?.readAsBytes();
      imageName = image?.name;
      imageSelected = true;
      videoSelected = false;
      setState(() => {});
    } else if (videoFromGallery == true) {
      // Pick a video
      final XFile? image = await _picker.pickVideo(source: ImageSource.gallery);
      imageFile = await image?.readAsBytes();
      imageName = image?.name;
      imageSelected = false;
      videoSelected = true;
      await videoThumbnail(image?.path);
      setState(() => {});
    } else if (videoFromCamera == true) {
      // Capture a video
      final XFile? image = await _picker.pickVideo(source: ImageSource.camera);
      imageFile = await image?.readAsBytes();
      imageName = image?.name;
      imageSelected = false;
      videoSelected = true;
      await videoThumbnail(image?.path);
      setState(() => {});
    }
  }

  void contentOptionBottomSheet(String source) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 0),
      constraints: BoxConstraints(
        // minHeight: MediaQuery.of(context).size.height * 0.6,
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) => ContentUploadOptionsBottomSheet(
        source: source,
        pickImageFunction: pickImage,
      ),
    );
  }

  Future<void> videoThumbnail(videoPath) async {
    if (videoSelected == true) {
      isGeneratingVideoThumbnail = true;
      setState(() {});

      fileName = await VideoThumbnail.thumbnailData(
        video: videoPath,
        imageFormat: ImageFormat.JPEG,
        // maxWidth: 128,
        quality: 100,
      );

      isGeneratingVideoThumbnail = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Post",
        ),
        actions: [
          isPosting == true
              ? Container(
                  width: 80.0,
                  height: 20.0,
                  // color: Colors.amber,
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 26.0),
                  child: CircularProgressIndicator(
                    color: Colors.grey[400]!,
                    strokeWidth: 2.0,
                  ),
                )
              : Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    border: Border.all(
                      color: Colors.grey[800]!,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      isPosting = true;
                      setState(() {});
                      Map newPostObject = {
                        "fullname": widget.currentUser["fullname"],
                        "username": widget.currentUser["username"],
                        "content": postContentController.text.trim(),
                        "gore": isGore,
                        "hidden": isHidden,
                        "spoiler": isSpoiler,
                        "nsfw": isNSFW,
                      };

                      if (videoSelected == true) {
                        await widget.uploadPostFunction(
                          newPostObject,
                          imageFile,
                          imageName,
                          false,
                        );
                      } else if (imageSelected == true) {
                        await widget.uploadPostFunction(
                          newPostObject,
                          imageFile,
                          imageName,
                          true,
                        );
                      } else {
                        await widget.newPostFunction(
                          newPostObject,
                        );
                      }

                      isPosting = false;
                      setState(() {});
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Post",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
        ],
      ),
      body: ListView(
        children: [
          // Profile Bar
          Container(
            // color: Colors.grey[900],
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: ProfileBar(
              profile: widget.currentUser,
              widget: Container(),
            ),
          ),
          // Text Field
          Container(
            height: 250.0,
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: Colors.grey[900]!.withOpacity(0.5),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: TextField(
              controller: postContentController,
              maxLength: 2000,
              maxLines: 100,
              enabled: isPosting == true ? false : true,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: InputBorder.none,
                hintText: "What would you like to post",
                counterStyle: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            ),
          ),
          // Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900]!.withOpacity(0.5),
                  border: Border.all(
                    color: Colors.grey[800]!,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Ionicons.camera_outline,
                      ),
                      onPressed: () {
                        // pickImage(false, true, false, false);
                        contentOptionBottomSheet("camera");
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Ionicons.image_outline,
                      ),
                      onPressed: () {
                        contentOptionBottomSheet("gallery");
                        // pickImage(true, false, false, false);
                      },
                    ),
                    // IconButton(
                    //   icon: Icon(
                    //     Ionicons.videocam_outline,
                    //   ),
                    //   onPressed: () {
                    //     pickImage(false, false, true, false);
                    //   },
                    // ),
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.video_camera_back_outlined,
                    //   ),
                    //   onPressed: () {
                    //     pickImage(false, false, false, true);
                    //   },
                    // ),

                    // Hidden
                    Container(
                      decoration: isHidden == false
                          ? BoxDecoration()
                          : BoxDecoration(
                              color: Colors.lightBlueAccent.withOpacity(0.05),
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                            ),
                      child: IconButton(
                        icon: Icon(
                          Ionicons.eye_off_outline,
                          color: Colors.lightBlueAccent,
                        ),
                        onPressed: () {
                          isHidden = !isHidden;
                          setState(() {});
                        },
                      ),
                    ),
                    // NSFW
                    Container(
                      decoration: isNSFW == false
                          ? BoxDecoration()
                          : BoxDecoration(
                              color: Colors.redAccent.withOpacity(0.05),
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                      child: IconButton(
                        icon: Icon(
                          Ionicons.warning_outline,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          isNSFW = !isNSFW;
                          setState(() {});
                        },
                      ),
                    ),
                    // Spoiler
                    Container(
                      decoration: isSpoiler == false
                          ? BoxDecoration()
                          : BoxDecoration(
                              color: Colors.orangeAccent.withOpacity(0.05),
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.orangeAccent,
                                ),
                              ),
                            ),
                      child: IconButton(
                        icon: Icon(
                          Icons.announcement_outlined,
                          color: Colors.orangeAccent,
                        ),
                        onPressed: () {
                          isSpoiler = !isSpoiler;
                          setState(() {});
                        },
                      ),
                    ),
                    // Gore
                    // IconButton(
                    //   icon: Icon(
                    //     Ionicons.warning_outline,
                    //   ),
                    //   onPressed: () {},
                    // ),
                  ],
                ),
              ),
            ],
          ), // Images
          SizedBox(height: 15.0),
          // imageSelected == true
          //     ? Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: [
          //           Stack(
          //             alignment: Alignment.topRight,
          //             children: [
          //               Container(
          //                 clipBehavior: Clip.hardEdge,
          //                 margin: EdgeInsets.only(left: 20.0, right: 15.0),
          //                 padding: EdgeInsets.all(10.0),
          //                 width: 350.0,
          //                 height: 350.0,
          //                 decoration: BoxDecoration(
          //                   color: Colors.grey[900]!.withOpacity(0.2),
          //                   borderRadius: BorderRadius.all(
          //                     Radius.circular(20.0),
          //                   ),
          //                 ),
          //                 child: Image.memory(
          //                   imageFile,
          //                   fit: BoxFit.contain,
          //                 ),
          //               ),
          //               Container(
          //                 decoration: BoxDecoration(
          //                   color: Colors.black,
          //                   borderRadius: BorderRadius.all(
          //                     Radius.circular(100.0),
          //                   ),
          //                 ),
          //                 child: IconButton(
          //                   onPressed: () {
          //                     // imageSelected = !imageSelected;
          //                     imageSelected = false;
          //                     videoSelected = false;

          //                     imageFile = null;
          //                     setState(() {});
          //                   },
          //                   icon: Icon(
          //                     Icons.remove_circle_outline,
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       )
          //     : Container(),

          videoSelected == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          margin: EdgeInsets.only(left: 20.0, right: 15.0),
                          padding: EdgeInsets.all(10.0),
                          width: 350.0,
                          height: 350.0,
                          decoration: BoxDecoration(
                            color: Colors.grey[900]!.withOpacity(0.2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: Image.memory(
                            fileName,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100.0),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // imageSelected = !imageSelected;
                              imageSelected = false;
                              videoSelected = false;
                              imageFile = null;
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.remove_circle_outline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
