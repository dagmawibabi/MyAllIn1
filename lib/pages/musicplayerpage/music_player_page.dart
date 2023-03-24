import 'dart:math';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:marquee/marquee.dart';
import 'package:myallin1/pages/components/music_list_bottom_sheet.dart';
import 'package:path/path.dart' as p;

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({
    super.key,
    required this.audioPlayer,
    required this.deviceMusicList,
    required this.loadDeviceMusicFile,
    required this.getDeviceAudioFiles,
    required this.changeMusicTitle,
    required this.currentSong,
    required this.albumArt,
  });

  final AssetsAudioPlayer audioPlayer;
  final List deviceMusicList;
  final Function loadDeviceMusicFile;
  final Function getDeviceAudioFiles;
  final Function changeMusicTitle;
  final String currentSong;
  final String albumArt;

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  bool isMusicPlaying = false;
  bool isFullScreen = true;
  String currentSong = "";

  ScrollController listViewController = ScrollController(
    initialScrollOffset: 50.0,
  );

  void localChangedMusicTitle(String title) {
    currentSong = title;
    setState(() {});
  }

  void deviceMusicListBottomSheet() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      // backgroundColor: Colors.black,
      builder: (context) {
        return MusicListBottomSheet(
          deviceMusicList: widget.deviceMusicList,
          loadDeviceMusicFile: widget.loadDeviceMusicFile,
          getDeviceAudioFiles: widget.getDeviceAudioFiles,
          changeMusicTitle: widget.changeMusicTitle,
          localChangedMusicTitle: localChangedMusicTitle,
          currentSong: currentSong,
        );
      },
    );
  }

  final assetsAudioPlayer = AssetsAudioPlayer();
  void streamMusic() async {
    // https://modest-carson-3aa7ad.netlify.app/Latch.mp3

    try {
      await assetsAudioPlayer.open(
        Audio.network("https://modest-carson-3aa7ad.netlify.app/Latch.mp3"),
      );
    } catch (t) {
      //mp3 unreachable
      print("some error");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localChangedMusicTitle(widget.currentSong);
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
            decoration: isFullScreen == true
                ? BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: NetworkImage(widget.albumArt),
                      fit: BoxFit.cover,
                      opacity: 0.6,
                    ),
                  )
                : BoxDecoration(
                    // color: Colors.grey[900]!,
                    ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back Button
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_outlined,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            isFullScreen = !isFullScreen;
                            setState(() {});
                          },
                          icon: Icon(
                            isFullScreen == true
                                ? Icons.fullscreen_exit
                                : Icons.fullscreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60.0),

                  // Album Art
                  Hero(
                    tag: "musicAlbumArt",
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      child: Image.network(
                        widget.albumArt,
                        width: isFullScreen == true ? 360.0 : 310.0,
                      ),
                    ),
                  ),

                  SizedBox(height: 10.0),

                  // Controlls
                  Container(
                    height: 300.0,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        isFullScreen == true
                            ? Spacer()
                            : SizedBox(height: 30.0),
                        Container(
                          padding: isFullScreen == true
                              ? EdgeInsets.only(left: 25.0, right: 15.0)
                              : EdgeInsets.only(left: 55.0, right: 45.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 30.0,
                                    width: isFullScreen == true ? 240.0 : 200.0,
                                    child: Marquee(
                                      text: currentSong,
                                      style: TextStyle(
                                        fontSize:
                                            isFullScreen == true ? 20.0 : 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      blankSpace: 80.0,
                                      velocity: 30.0,
                                      numberOfRounds: 3,
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  //   Text(
                                  //     "Anne Leone",
                                  //     style: TextStyle(
                                  //       color: Colors.grey[500]!,
                                  //       fontSize: isFullScreen == true ? 16.0 : 14.0,
                                  //     ),
                                  //   ),
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Ionicons.heart_outline,
                                      size: 26.0,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      deviceMusicListBottomSheet();
                                    },
                                    icon: Icon(
                                      Icons.playlist_play_rounded,
                                      size: 30.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        // Seeker
                        Container(
                          width: isFullScreen == true ? double.infinity : 350.0,
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
                          width: isFullScreen == true ? double.infinity : 350.0,
                          height: 20.0,
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: StreamBuilder(
                            stream: widget.audioPlayer.currentPosition,
                            builder: (context, asyncSnapshot) {
                              Duration duration = asyncSnapshot.data!;
                              var a = widget.audioPlayer.current.length;
                              // print(a);
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                          padding: isFullScreen == true
                              ? EdgeInsets.symmetric(horizontal: 25.0)
                              : EdgeInsets.symmetric(horizontal: 45.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  widget.audioPlayer.play();
                                },
                                icon: Icon(
                                  Ionicons.shuffle,
                                  size: isFullScreen == true ? 30.0 : 25.0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      widget.audioPlayer.play();
                                    },
                                    icon: Icon(
                                      Icons.skip_previous,
                                      size: isFullScreen == true ? 40.0 : 35.0,
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  GestureDetector(
                                    onTap: () {
                                      print("here");
                                      // streamMusic();
                                      assetsAudioPlayer.stop();
                                      // setState(() {});
                                      // isMusicPlaying =
                                      //     widget.audioPlayer.isPlaying.value;
                                      // widget.audioPlayer.isPlaying.value
                                      //     ? widget.audioPlayer.pause()
                                      //     : widget.audioPlayer.play();
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
                                        isMusicPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        size:
                                            isFullScreen == true ? 40.0 : 35.0,
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
                                      size: isFullScreen == true ? 40.0 : 35.0,
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
                                  size: isFullScreen == true ? 30.0 : 25.0,
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
            ),
          ),
        ],
      ),
    );
  }
}
