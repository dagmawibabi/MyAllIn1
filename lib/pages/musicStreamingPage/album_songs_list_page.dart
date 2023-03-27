import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myallin1/pages/musicStreamingPage/music_player_page.dart';

class AlbumSongsListPage extends StatefulWidget {
  const AlbumSongsListPage({
    super.key,
    required this.musicData,
    required this.streamMusic,
    required this.pauseOrPlay,
    required this.nextInPlaylist,
    required this.previousInPlaylist,
    required this.assetsAudioPlayer,
    required this.isMusicPlaying,
  });
  final Map musicData;
  final Function streamMusic;
  final Function pauseOrPlay;
  final Function nextInPlaylist;
  final Function previousInPlaylist;
  final AssetsAudioPlayer assetsAudioPlayer;
  final bool isMusicPlaying;

  @override
  State<AlbumSongsListPage> createState() => _AlbumSongsListPageState();
}

class _AlbumSongsListPageState extends State<AlbumSongsListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        body: Container(
          child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.97,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.musicData["albumArt"],
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.3,
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                  child: Column(
                    children: [
                      // SizedBox(height: 40.0),

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
                      SizedBox(height: 30.0),

                      // Album Art
                      Hero(
                        tag: widget.musicData["albumArt"],
                        child: Container(
                          width: 300.0,
                          height: 300.0,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(22.0),
                            ),
                          ),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: widget.musicData["albumArt"],
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: Colors.white,
                                strokeWidth: 1.0,
                              ),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error_outline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),

                      // Album Title
                      Container(
                        width: 300.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.musicData["album"],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  widget.musicData["artist"],
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MusicPlayerPage(
                                      musicData: widget.musicData,
                                      isPlaylist: true,
                                      currentSong: widget.musicData["songs"][0],
                                      streamMusic: widget.streamMusic,
                                      pauseOrPlay: widget.pauseOrPlay,
                                      nextInPlaylist: widget.nextInPlaylist,
                                      previousInPlaylist:
                                          widget.previousInPlaylist,
                                      assetsAudioPlayer:
                                          widget.assetsAudioPlayer,
                                      isMusicPlaying: widget.isMusicPlaying,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(6.0),
                                margin:
                                    EdgeInsets.only(bottom: 3.0, right: 2.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 53, 189, 25),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(200.0),
                                  ),
                                ),
                                child: Icon(
                                  Icons.play_arrow,
                                  color: Colors.black,
                                  size: 30.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 0.0),

                      Spacer(),

                      // Songs List
                      Container(
                        height: MediaQuery.of(context).size.height * 0.44,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.only(
                          //   topLeft: Radius.circular(20.0),
                          //   topRight: Radius.circular(20.0),
                          // ),
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
                          height: MediaQuery.of(context).size.height * 0.43,
                          margin: EdgeInsets.only(top: 2.0),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(),
                          child: ListView(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.44,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 18, 18, 18),
                                  // borderRadius: BorderRadius.only(
                                  //   topLeft: Radius.circular(22.0),
                                  //   topRight: Radius.circular(22.0),
                                  // ),

                                  // gradient: LinearGradient(
                                  //   begin: Alignment.topCenter,
                                  //   end: Alignment.bottomCenter,
                                  //   colors: [
                                  //     Colors.transparent,
                                  //     Colors.black,
                                  //   ],
                                  // ),
                                ),
                                child: ListView(
                                  children: [
                                    Column(
                                      children: [
                                        for (var eachSong
                                            in widget.musicData["songs"])
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MusicPlayerPage(
                                                    musicData: widget.musicData,
                                                    isPlaylist: true,
                                                    currentSong: eachSong,
                                                    streamMusic:
                                                        widget.streamMusic,
                                                    pauseOrPlay:
                                                        widget.pauseOrPlay,
                                                    nextInPlaylist:
                                                        widget.nextInPlaylist,
                                                    previousInPlaylist: widget
                                                        .previousInPlaylist,
                                                    assetsAudioPlayer: widget
                                                        .assetsAudioPlayer,
                                                    isMusicPlaying:
                                                        widget.isMusicPlaying,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: 50.0,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5.0,
                                                  vertical: 2.0),
                                              decoration: BoxDecoration(
                                                // gradient: LinearGradient(
                                                //   begin: Alignment.centerLeft,
                                                //   end: Alignment.centerRight,
                                                //   colors: [
                                                //     Colors.black,
                                                //     Colors.transparent,
                                                //   ],
                                                // ),
                                                // borderRadius: BorderRadius.all(
                                                //   Radius.circular(10.0),
                                                // ),
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.grey[900]!
                                                        .withOpacity(0.2),
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    eachSong
                                                        .toString()
                                                        .substring(
                                                            0,
                                                            eachSong
                                                                .toString()
                                                                .lastIndexOf(
                                                                    ".")),
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: widget.musicData[
                                                                      "title"]
                                                                  .toString()
                                                                  .toLowerCase() ==
                                                              eachSong
                                                                  .toString()
                                                                  .toLowerCase()
                                                          ? Colors.greenAccent
                                                          : Colors.white,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.play_arrow,
                                                        color: widget.musicData[
                                                                        "title"]
                                                                    .toString()
                                                                    .toLowerCase() ==
                                                                eachSong
                                                                    .toString()
                                                                    .toLowerCase()
                                                            ? Colors.greenAccent
                                                            : Colors.white,
                                                      ),
                                                      // Icon(
                                                      //   Icons.more_vert_outlined,
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
