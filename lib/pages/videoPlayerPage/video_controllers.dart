import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoControllers extends StatefulWidget {
  const VideoControllers({
    super.key,
    required this.controller,
    // required this.duration,
  });

  final VideoPlayerController controller;
  // final Duration duration;

  @override
  State<VideoControllers> createState() => _VideoControllersState();
}

class _VideoControllersState extends State<VideoControllers> {
  dynamic curPosition = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.controller.removeListener(() {});
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(
      () => {
        curPosition = widget.controller.value.position.inSeconds,
        setState((() {}))
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.controller.position,
        // stream: null,
        builder: (context, snapshot) {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    // widget.controller.value.position.inSeconds.toDouble().toString(),
                    (widget.controller.value.position.inSeconds ~/ 60)
                            .toString()
                            .padLeft(2, '0') +
                        ":" +
                        ((widget.controller.value.position.inSeconds % 60)
                                .toInt())
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
                    value: curPosition
                        .toDouble(), //widget.duration.inSeconds.toDouble(),
                    min: 0,
                    max: widget.controller.value.duration.inSeconds.toDouble(),
                    activeColor: Colors.grey[300],
                    onChanged: (change) async {
                      curPosition = change.toInt();
                      await widget.controller.seekTo(
                        Duration(
                          seconds: change.toInt(),
                        ),
                      );
                      setState(() => {});
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    (widget.controller.value.duration.inSeconds ~/ 60)
                            .toString()
                            .padLeft(2, '0') +
                        ":" +
                        ((widget.controller.value.duration.inSeconds % 60)
                                .toInt())
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
        });
  }
}
