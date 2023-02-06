import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:photo_view/photo_view.dart';

import '../../config/config.dart';

class ImageViewerPage extends StatefulWidget {
  const ImageViewerPage({
    super.key,
    required this.isNetworkImage,
    this.networkImage,
    this.assetImage,
    this.title,
  });

  final bool isNetworkImage;
  final dynamic networkImage;
  final dynamic assetImage;
  final dynamic title;

  @override
  State<ImageViewerPage> createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  bool isDownloading = false;
  bool isDownloadDone = false;
  bool enableRotation = false;

  void downloadMoviePoster(String url) async {
    isDownloading = true;
    setState(() {});
    try {
      // Saved with this method.
      var imageId = await ImageDownloader.downloadImage(url);
      if (imageId == null) {
        return;
      }

      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
      isDownloading = false;
      isDownloadDone = true;
      setState(() {});
    } on PlatformException catch (error) {
      print("error");
      isDownloading = false;
      isDownloadDone = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title.toString(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              enableRotation = !enableRotation;
              setState(() {});
            },
            icon: Icon(
              Icons.rotate_90_degrees_ccw,
              color: enableRotation == true ? Colors.blue : Colors.white,
            ),
          ),
          isDownloading == true
              ? Container(
                  width: 45.0,
                  height: 46.0,
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                      strokeWidth: 1.0,
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(right: 8.0),
                  child: isDownloadDone == true
                      ? IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.download_done_outlined,
                            color: Colors.greenAccent,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            downloadMoviePoster(
                              widget.isNetworkImage == true
                                  ? widget.networkImage
                                  : widget.assetImage,
                            );
                          },
                          icon: Icon(
                            Icons.download_outlined,
                          ),
                        ),
                ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        primary: false,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height * 0.8,
                // clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[900]!.withOpacity(0.2),
                  // borderRadius: BorderRadius.circular(
                  //   20.0,
                  // ),
                ),
                alignment: Alignment.center,
                child: PhotoView(
                  tightMode: true,
                  enableRotation: enableRotation,
                  heroAttributes: PhotoViewHeroAttributes(
                    tag: widget.networkImage,
                  ),
                  backgroundDecoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  imageProvider: NetworkImage(
                    widget.networkImage,
                  ),
                  loadingBuilder: (context, event) => Container(
                    height: 400.0,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: event?.expectedTotalBytes!.toDouble(),
                        color: Colors.grey[800]!,
                        strokeWidth: 2.0,
                      ),
                    ),
                  ),
                ),
                // Hero(
                //   tag: widget.networkImage,
                // child: CachedNetworkImage(
                //   fit: BoxFit.contain,
                //   imageUrl: widget.networkImage,
                //   progressIndicatorBuilder:
                //       (context, url, downloadProgress) => Center(
                //     child: CircularProgressIndicator(
                //       value: downloadProgress.progress,
                //       color: Colors.grey[800]!,
                //       strokeWidth: 2.0,
                //     ),
                //   ),
                //   errorWidget: (context, url, error) => Icon(
                //     Icons.error_outline,
                //   ),
                // ),
                // ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
