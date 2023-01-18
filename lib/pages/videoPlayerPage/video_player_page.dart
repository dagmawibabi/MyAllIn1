import 'package:flutter/material.dart';
import 'package:myallin1/pages/videoPlayerPage/video_controllers.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({
    super.key,
    required this.networkVideo,
    required this.title,
  });

  final String networkVideo;
  final String title;

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;

  bool isVideoLoading = true;
  bool isFullScreen = false;

  void initVideo() async {
    _controller = VideoPlayerController.network(widget.networkVideo)
      ..initialize().then(
        (_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          isVideoLoading = false;
          _controller.setLooping(true);
          _controller.play();
          setState(() {});
        },
      );
  }

  void abd() async {
    _controller.setLooping(true);
  }

  @override
  void initState() {
    super.initState();
    initVideo();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.pause();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isFullScreen == true
        ? Scaffold(
            body: isVideoLoading == true
                ? Container(
                    width: 400.0,
                    height: 400.0,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.grey[400]!,
                            strokeWidth: 2.0,
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            "Streaming Video",
                            style: TextStyle(
                              color: Colors.grey[700]!,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                      setState(() {});
                    },
                    onDoubleTap: () {
                      isFullScreen = !isFullScreen;
                      setState(() {});
                    },
                    onLongPressStart: (value) {
                      isFullScreen = true;
                      setState(() {});
                    },
                    onLongPressEnd: (value) {
                      isFullScreen = false;
                      setState(() {});
                    },
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 19.0),
                        child: _controller.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              )
                            : Container(),
                      ),
                    ),
                  ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                widget.title.toString(),
              ),
            ),
            body: isVideoLoading == true
                ? Container(
                    width: 400.0,
                    height: 400.0,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: Colors.grey[400]!,
                            strokeWidth: 2.0,
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            "Streaming Video",
                            style: TextStyle(
                              color: Colors.grey[700]!,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _controller.value.isPlaying
                              ? _controller.pause()
                              : _controller.play();
                          setState(() {});
                        },
                        onDoubleTap: () {
                          isFullScreen = !isFullScreen;
                          setState(() {});
                        },
                        onLongPressStart: (value) {
                          isFullScreen = true;
                          setState(() {});
                        },
                        onLongPressEnd: (value) {
                          isFullScreen = false;
                          setState(() {});
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: _controller.value.isInitialized
                                  ? AspectRatio(
                                      aspectRatio:
                                          _controller.value.aspectRatio,
                                      child: VideoPlayer(_controller),
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 5.0),
                isVideoLoading == true
                    ? Container(
                        width: 100.0,
                        height: 60.0,
                      )
                    : Container(
                        // color: Colors.grey[700]!.withOpacity(0.8),
                        // height: 80.0,
                        width: 320.0,
                        margin: EdgeInsets.only(left: 5.0),
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 18, 18, 18),
                            border: Border.all(color: Colors.grey[850]!),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: VideoControllers(
                            controller: _controller,
                            // duration: duration,
                          ),
                          // FutureBuilder(
                          //   future: _controller.position,
                          //   // stream: _controller.position.asStream(),
                          //   builder: (context, asyncSnapshot) {
                          //     _controller.notifyListeners();
                          //     Duration duration = asyncSnapshot.data!;
                          //     print(asyncSnapshot);
                          //     return VideoControllers(
                          //       controller: _controller,
                          //       duration: duration,
                          //     );
                          //   },
                          // ),
                        ),
                      ),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[850]!),
                    borderRadius: BorderRadius.all(
                      Radius.circular(100.0),
                    ),
                  ),
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      });
                    },
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Container videoController(Duration duration) {
    return Container(
      // width: 200.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text(
              (duration.inSeconds ~/ 60).toString().padLeft(2, '0') +
                  ":" +
                  ((duration.inSeconds % 60).toInt())
                      .toString()
                      .padLeft(2, "0"),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          Container(
            width: 210.0,
            child: Slider(
              value: duration.inSeconds.toDouble(),
              min: 0,
              max: _controller.value.duration.inSeconds.toDouble(),
              activeColor: Colors.grey[300],
              onChanged: (change) => {
                _controller.seekTo(
                  Duration(
                    seconds: change.toInt(),
                  ),
                ),
                setState(() => {})
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Text(
              (_controller.value.duration.inSeconds ~/ 60)
                      .toString()
                      .padLeft(2, '0') +
                  ":" +
                  ((_controller.value.duration.inSeconds % 60).toInt())
                      .toString()
                      .padLeft(2, "0"),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
