import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/config/config.dart';

class MusicPlayerPage extends StatefulWidget {
  const MusicPlayerPage({
    super.key,
    required this.musicData,
    required this.isPlaylist,
    this.currentSong = "",
  });

  final Map musicData;
  final bool isPlaylist;
  final String currentSong;

  @override
  State<MusicPlayerPage> createState() => _MusicPlayerPageState();
}

class _MusicPlayerPageState extends State<MusicPlayerPage> {
  String musicRoot = Config.musicLibraryRoot + "/";
  final assetsAudioPlayer = AssetsAudioPlayer();
  bool isMusicPlaying = true;
  bool isFavorite = false;
  List playlist = [];
  int playlistIndex = 0;

  void streamMusic() async {
    // https://modest-carson-3aa7ad.netlify.app/Latch.mp3
    try {
      if (widget.isPlaylist == false) {
        await assetsAudioPlayer.open(
          Audio.network(
            musicRoot + widget.musicData["link"],
          ),
        );
      } else {
        List<Audio> playlist = [];
        for (var eachSong in widget.musicData["songs"]) {
          playlist.add(
            Audio.network(
              musicRoot +
                  widget.musicData["artist"] +
                  "/" +
                  widget.musicData["album"] +
                  "/" +
                  eachSong,
            ),
          );
        }
        await assetsAudioPlayer.open(
          Playlist(
            audios: playlist,
          ),
          loopMode: LoopMode.playlist,
        );
        await assetsAudioPlayer.playlistPlayAtIndex(playlistIndex);
      }
    } catch (t) {
      print("some error");
    }
  }

  void pauseOrPlay() {
    if (isMusicPlaying == true) {
      assetsAudioPlayer.pause();
      isMusicPlaying = false;
    } else {
      assetsAudioPlayer.play();
      isMusicPlaying = true;
    }
    setState(() {});
  }

  void previousInPlaylist() async {
    playlistIndex--;
    if (playlistIndex < 0) {
      playlistIndex = playlist.length - 1;
    }
    setState(() {});
    await assetsAudioPlayer.stop();
    await assetsAudioPlayer.previous();
  }

  void nextInPlaylist() async {
    playlistIndex++;
    if (playlistIndex >= playlist.length) {
      playlistIndex = 0;
    }
    setState(() {});
    await assetsAudioPlayer.stop();
    await assetsAudioPlayer.next();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    assetsAudioPlayer.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playlist = widget.isPlaylist == true ? widget.musicData["songs"] : [];
    playlistIndex = widget.isPlaylist == true
        ? widget.musicData["songs"].indexOf(widget.currentSong)
        : 0;

    streamMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              widget.musicData["albumArt"],
            ),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Column(
            children: [
              SizedBox(height: 40.0),

              // Back Button
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
                    // IconButton(
                    //   onPressed: () {
                    //     isFullScreen = !isFullScreen;
                    //     setState(() {});
                    //   },
                    //   icon: Icon(
                    //     isFullScreen == true
                    //         ? Icons.fullscreen_exit
                    //         : Icons.fullscreen,
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 50.0),

              // Album Art
              Container(
                width: double.infinity,
                height: 360.0,
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Image.network(
                  widget.musicData["albumArt"],
                  fit: BoxFit.cover,
                ),
              ),

              // Title
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 300.0,
                          child: Text(
                            widget.isPlaylist == false
                                ? widget.musicData["title"]
                                : playlist[playlistIndex].toString().substring(
                                    0,
                                    playlist[playlistIndex].lastIndexOf(".")),
                            overflow: TextOverflow.ellipsis,
                            // assetsAudioPlayer.readingPlaylist!.current.path
                            //     .substring(
                            //         assetsAudioPlayer
                            //                 .readingPlaylist!.current.path
                            //                 .lastIndexOf("/") +
                            //             1,
                            //         assetsAudioPlayer.readingPlaylist!.current
                            //                 .path.length -
                            //             4)
                            //     .toString(),
                            // widget.isPlaylist == true
                            //     ? widget.currentSong
                            //         .substring(0, widget.currentSong.length - 4)
                            //     : widget.musicData["title"],
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          width: 300.0,
                          child: Text(
                            widget.musicData["artist"],
                            style: TextStyle(
                              color: Colors.grey[400],
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        isFavorite = !isFavorite;
                        setState(() {});
                      },
                      icon: Icon(
                        isFavorite == true
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 25.0,
                        color: isFavorite == true
                            ? Colors.greenAccent
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),

              // Seeker
              assetsAudioPlayer.builderCurrentPosition(
                builder: (context, duration) => Container(
                  width: double.infinity,
                  height: 32.0,
                  child: Slider(
                    value: assetsAudioPlayer.currentPosition.value.inSeconds
                        .toDouble(),
                    min: 0,
                    max: assetsAudioPlayer.current.valueOrNull == null
                        ? 100.0
                        : assetsAudioPlayer
                            .current.value!.audio.duration.inSeconds
                            .toDouble(),
                    activeColor: Colors.grey[300],
                    onChanged: (change) => {
                      assetsAudioPlayer.seek(
                        Duration(seconds: change.toInt()),
                      ),
                    },
                  ),
                ),
              ),
              // Container(
              //     width: double.infinity,
              //     height: 32.0,
              //     child: StreamBuilder(
              //       stream: assetsAudioPlayer.currentPosition,
              //       builder: (context, asyncSnapshot) {
              //         return Container(
              //           width: 250.0,
              //           child:
              //         );
              //       },
              //     )),

              // Current Postion and Duration
              assetsAudioPlayer.builderCurrentPosition(
                builder: (context, duration) => Container(
                  width: double.infinity,
                  height: 20.0,
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (duration.inSeconds ~/ 60).toString().padLeft(2, '0') +
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
                        assetsAudioPlayer.current.valueOrNull == null
                            ? "00:00"
                            : (assetsAudioPlayer.current.value!.audio.duration
                                            .inSeconds ~/
                                        60)
                                    .toString()
                                    .padLeft(2, '0') +
                                ":" +
                                ((assetsAudioPlayer.current.value!.audio
                                                .duration.inSeconds %
                                            60)
                                        .toInt())
                                    .toString()
                                    .padLeft(2, "0"),
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.0),

              // Controls
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Ionicons.shuffle,
                        size: 30.0,
                      ),
                    ),
                    Row(
                      children: [
                        widget.isPlaylist == false
                            ? Container()
                            : IconButton(
                                onPressed: () async {
                                  previousInPlaylist();
                                },
                                icon: Icon(
                                  Icons.skip_previous,
                                  size: 40.0,
                                ),
                              ),
                        SizedBox(width: 8.0),
                        assetsAudioPlayer.builderCurrentPosition(
                          builder: (context, duration) =>
                              assetsAudioPlayer.current.valueOrNull == null
                                  ? Container(
                                      padding: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        // color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                      ),
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                        color: Colors.white,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        pauseOrPlay();
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
                                          isMusicPlaying == true
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: Colors.black,
                                          size: 40.0,
                                        ),
                                      ),
                                    ),
                        ),
                        widget.isPlaylist == false
                            ? Container()
                            : IconButton(
                                onPressed: () async {
                                  nextInPlaylist();
                                },
                                icon: Icon(
                                  Icons.skip_next,
                                  size: 40.0,
                                ),
                              ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.replay_outlined,
                        size: 30.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
