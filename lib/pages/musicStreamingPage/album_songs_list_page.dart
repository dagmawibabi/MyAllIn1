import 'package:flutter/material.dart';
import 'package:myallin1/pages/musicStreamingPage/music_player_page.dart';

class AlbumSongsListPage extends StatefulWidget {
  const AlbumSongsListPage({
    super.key,
    required this.musicData,
  });
  final Map musicData;

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
                height: MediaQuery.of(context).size.height * 0.96,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.musicData["albumArt"],
                    ),
                    fit: BoxFit.cover,
                    opacity: 0.3,
                  ),
                ),
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
                    SizedBox(height: 50.0),

                    // Album Art
                    Container(
                      width: 300.0,
                      height: 300.0,
                      child: Image.network(
                        widget.musicData["albumArt"],
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10.0),

                    // Album Title
                    Container(
                      width: 300.0,
                      child: Column(
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
                    ),
                    SizedBox(height: 20.0),

                    Spacer(),

                    // Songs List
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      child: ListView(
                        children: [
                          Container(
                            // color: Colors.black,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.black,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            child: Column(children: [
                              for (var eachSong in widget.musicData["songs"])
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MusicPlayerPage(
                                          musicData: widget.musicData,
                                          isPlaylist: true,
                                          currentSong: eachSong,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: 50.0,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Colors.black,
                                          Colors.transparent,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          eachSong.toString().substring(
                                              0,
                                              eachSong
                                                  .toString()
                                                  .lastIndexOf(".")),
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ]),
                          ),
                        ],
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
