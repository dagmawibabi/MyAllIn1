import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({
    super.key,
    required this.audioPlayer,
  });

  final AssetsAudioPlayer audioPlayer;

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  bool isMusicPlaying = false;
  ScrollController listViewController = ScrollController(
    initialScrollOffset: 50.0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isMusicPlaying = widget.audioPlayer.isPlaying.value;
    return Scaffold(
      body: ListView(
        controller: listViewController,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: AssetImage("assets/images/INR.jpg"),
                fit: BoxFit.cover,
                opacity: 0.15,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.0),
                Row(
                  children: [
                    SizedBox(
                      width: 10.0,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_outlined,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.0),

                Hero(
                  tag: "musicAlbumArt",
                  child: Image.asset(
                    "assets/images/INR.jpg",
                    width: 360.0,
                  ),
                ),
                // SizedBox(height: 30.0),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "My Soul I",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            "Anne Leone",
                            style: TextStyle(
                              color: Colors.grey[500]!,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Ionicons.heart_outline,
                          size: 26.0,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                // Seeker
                Container(
                  width: double.infinity,
                  height: 32.0,
                  child: StreamBuilder(
                    stream: widget.audioPlayer.currentPosition,
                    builder: (context, asyncSnapshot) {
                      Duration duration = asyncSnapshot.data!;
                      var a = widget.audioPlayer.current.length;
                      // print(a);
                      return Container(
                        width: 250.0,
                        child: Slider(
                          value: duration.inSeconds.toDouble(),
                          min: 0,
                          max: 250,
                          activeColor: Colors.grey[300],
                          label: "20",
                          onChanged: (change) => {
                            widget.audioPlayer.seek(
                              Duration(
                                seconds: change.toInt(),
                              ),
                            ),
                          },
                        ),
                      );
                    },
                  ),
                ),
                // Current Postion and Duration
                Container(
                  width: double.infinity,
                  height: 20.0,
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: StreamBuilder(
                    stream: widget.audioPlayer.currentPosition,
                    builder: (context, asyncSnapshot) {
                      Duration duration = asyncSnapshot.data!;
                      var a = widget.audioPlayer.current.length;
                      // print(a);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            /*(duration.inSeconds ~/ 3600)
                                    .toString()
                                    .padLeft(2, '0') +
                                ":" + */
                            (duration.inSeconds ~/ 60)
                                    .toString()
                                    .padLeft(2, '0') +
                                ":" +
                                ((duration.inSeconds % 60).toInt())
                                    .toString()
                                    .padLeft(2, "0"),
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            /*(duration.inSeconds ~/ 3600)
                                    .toString()
                                    .padLeft(2, '0') +
                                ":" + */
                            (duration.inSeconds ~/ 60)
                                    .toString()
                                    .padLeft(2, '0') +
                                ":" +
                                ((duration.inSeconds % 60).toInt())
                                    .toString()
                                    .padLeft(2, "0"),
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                // Controls
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          widget.audioPlayer.play();
                        },
                        icon: Icon(
                          Ionicons.shuffle,
                          size: 30.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              widget.audioPlayer.play();
                            },
                            icon: Icon(
                              Icons.skip_previous,
                              size: 40.0,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () {
                              setState(() {});
                              isMusicPlaying =
                                  widget.audioPlayer.isPlaying.value;
                              widget.audioPlayer.isPlaying.value
                                  ? widget.audioPlayer.pause()
                                  : widget.audioPlayer.play();
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(100.0),
                                ),
                              ),
                              child: Icon(
                                isMusicPlaying ? Icons.pause : Icons.play_arrow,
                                size: 40.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          IconButton(
                            onPressed: () async {
                              print(widget.audioPlayer.isPlaying.value);
                              // widget.audioPlayer.pause();
                            },
                            icon: Icon(
                              Icons.skip_next,
                              size: 40.0,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          widget.audioPlayer.play();
                        },
                        icon: Icon(
                          Icons.replay_outlined,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
