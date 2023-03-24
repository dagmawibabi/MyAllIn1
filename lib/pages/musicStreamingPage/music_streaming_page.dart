import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:myallin1/pages/musicStreamingPage/album_songs_list_page.dart';
import 'package:myallin1/pages/musicStreamingPage/artists_container.dart';
import 'package:myallin1/pages/musicStreamingPage/music_player_page.dart';

class MusicStreamingPage extends StatefulWidget {
  const MusicStreamingPage({super.key});

  @override
  State<MusicStreamingPage> createState() => _MusicStreamingPageState();
}

class _MusicStreamingPageState extends State<MusicStreamingPage> {
  var random = Random();
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
  Widget build(BuildContext context) {
    List songs = [
      {
        "category": "Top Picks",
        "list": [
          {
            "albumArt":
                "https://i.pinimg.com/564x/4c/bf/0d/4cbf0d47d10aece806dd01d5476e68cb.jpg",
            "artist": "Doja Cat",
            "title": "Need To Know",
            "link": "Singles/Need To Know.mp3",
          },
          {
            "albumArt":
                "https://yt3.googleusercontent.com/ytc/AL5GRJWXnexiQPLcJJgH325leZdKYwzMuRXyoR0qUB1RyQ=s900-c-k-c0x00ffffff-no-rj",
            "artist": "Chelina",
            "title": "Sai Bai",
            "link": "Singles/Sai Bai.mp3",
          },
          {
            "albumArt":
                "https://upload.wikimedia.org/wikipedia/en/thumb/9/9d/Ed_Sheeran_Afire_Love.jpg/220px-Ed_Sheeran_Afire_Love.jpg",
            "artist": "Ed Sheeran",
            "title": "Afire Love",
            "link": "Singles/Afire Love.mp3",
          },
          {
            "albumArt":
                "https://i.scdn.co/image/ab67616d0000b2730d1f3930676c34a23dbf5c46",
            "artist": "Sam Smith",
            "title": "Forgive Myself",
            "link": "Singles/Forgive Myself.m4a",
          },
          {
            "albumArt":
                "https://i.pinimg.com/564x/bc/9d/de/bc9ddeaae3e3d5b8b464570db27dd7c2.jpg",
            "artist": "Eminem",
            "title": "Tone Deaf",
            "link": "Singles/Tone Deaf.m4a",
          },
        ]
      },
      {
        "category": "Artists",
        "list": [
          {
            "albumArt":
                "https://dawitgetachew.org/wp-content/uploads/2022/12/photo_2021-09-13-19.23.04.jpeg",
            "artist": "Dawit Getachew",
            "title": "Dive",
            "link": "https://modest-carson-3aa7ad.netlify.app/Latch.mp3",
          },
          {
            "albumArt":
                "https://i.pinimg.com/564x/50/2e/d9/502ed91c545ae284c5f73394ca486be4.jpg",
            "artist": "Billie Eilish",
            "title": "Almost Gone",
            "link": "https://modest-carson-3aa7ad.netlify.app/Latch.mp3",
          },
          {
            "albumArt":
                "https://worshipleader.com/wp-content/uploads/2022/04/Website-Post-Size-86.png",
            "artist": "Hillsong United",
            "title": "Latch",
            "link": "https://modest-carson-3aa7ad.netlify.app/Latch.mp3",
          },
          {
            "albumArt":
                "https://i.pinimg.com/564x/3c/e1/b3/3ce1b39c09a992d01fe47834b4bb0867.jpg",
            "artist": "J Cole",
            "title": "Born Sinner",
            "link": "https://modest-carson-3aa7ad.netlify.app/Latch.mp3",
          },
          {
            "albumArt":
                "https://i.pinimg.com/564x/56/43/6d/56436d2345a5f74ceef0fb8e4dff441d.jpg",
            "artist": "Lauren Daigle",
            "title": "Next To Me",
            "link": "https://modest-carson-3aa7ad.netlify.app/Latch.mp3",
          },
        ]
      },
      {
        "category": "Albums",
        "list": [
          {
            "artist": "Dermot Kennedy",
            "album": "Sonder",
            "albumArt":
                "https://i.pinimg.com/736x/83/a1/36/83a136a8018fb9b7101425972b946684.jpg",
            "songs": [
              "01. Already Gone.mp3",
              "02. Something to Someone.mp3",
              "03. Kiss Me.mp3",
              "04. Dreamer.mp3",
              "05. Innocence and Sadness.mp3",
              "06. Divide.mp3",
              "07. Homeward.mp3",
              "08. One Life.mp3",
              "09. Better Days.mp3",
              "10. Already Gone.mp3",
              "11. Blossom.mp3",
            ],
          },
          {
            "albumArt":
                "https://m.media-amazon.com/images/W/IMAGERENDERING_521856-T1/images/I/916R9qiMCOL._AC_SL1500_.jpg",
            "artist": "Imagine Dragons",
            "album": "Evolve",
            "songs": [
              "01. On Top Of The World.flac",
              "02. Machine.flac",
              "03. Whatever It Takes.flac",
              "04. Battle Cry.flac",
              "05. It's Time.flac",
              "06. Next To Me.flac",
              "07. Not Today.flac",
              "08. Radioactive.flac",
              "09. Warriors.flac",
              "10. I Bet My Life.flac",
              "11. Gold.flac",
              "12. Shots.flac",
              "13. Natural.flac",
              "14. Monster.flac",
              "15. Zero.flac",
              "16. Walking The Wire.flac",
              "17. Demons.flac",
              "18. Believer.flac",
              "19. Thunder.flac",
              "20. Bleeding Out.flac",
              "21. Bad Liar.flac",
              "22. Dancing In The Dark.flac",
            ],
          },
          {
            "albumArt":
                "https://equatemagazine.com/wp-content/uploads/2021/06/Anna_MVinay014D-small-crop-scaled.jpg",
            "artist": "Anne Leone",
            "album": "Wandered Away",
            "songs": [
              "My Soul I.mp3",
              "I Never Really.mp3",
              "Wandered Away.mp3",
              "If You Only.mp3",
              "Into the Cold.mp3",
            ],
          },
          {
            "albumArt":
                "https://i.pinimg.com/564x/01/fb/3b/01fb3bc44975e76849ca5fb01b4f599c.jpg",
            "artist": "AJR",
            "album": "Neotheatre",
            "songs": [
              "01. Already Gone.mp3",
              "02. Something to Someone.mp3",
              "03. Kiss Me.mp3",
              "04. Dreamer.mp3",
              "05. Innocence and Sadness.mp3",
              "06. Divide.mp3",
              "07. Homeward.mp3",
              "08. One Life.mp3",
              "09. Better Days.mp3",
              "10. Already Gone.mp3",
              "11. Blossom.mp3",
            ],
          },
        ]
      },
      {
        "category": "New Songs",
        "list": [
          {
            "albumArt":
                "https://i.pinimg.com/564x/53/0a/44/530a440adccba906b1abcc3dc49fb5c5.jpg",
            "artist": "The Lumineers",
            "title": "Sleep On The Floor",
            "link": "Singles/Sleep On The Floor.mp3",
          },
          {
            "albumArt":
                "https://i.pinimg.com/564x/83/0f/0d/830f0dbe0e228fc42372a7d27ab7715f.jpg",
            "artist": "Hozier",
            "title": "Cherry Wine",
            "link": "Singles/Cherry Wine.mp3",
          },
          {
            "albumArt":
                "https://i.pinimg.com/564x/66/c7/a0/66c7a0bb70d5e5dc9ce72ae6f736787a.jpg",
            "artist": "Boyce Avenue",
            "title": "Flowers",
            "link": "https://modest-carson-3aa7ad.netlify.app/Latch.mp3",
          },
          {
            "albumArt":
                "https://i.pinimg.com/564x/b1/35/ac/b135acaf2410c48b8829ff7c14612258.jpg",
            "artist": "M83",
            "title": "Wait",
            "link": "https://modest-carson-3aa7ad.netlify.app/Latch.mp3",
          },
          {
            "albumArt":
                "https://i.pinimg.com/564x/d5/cd/7f/d5cd7f2b5cdb99a9545c1eb443b39eee.jpg",
            "artist": "Hans Zimmer",
            "title": "Interstellar",
            "link": "https://modest-carson-3aa7ad.netlify.app/Latch.mp3",
          },
          {
            "albumArt":
                "https://i.pinimg.com/564x/0c/83/23/0c8323cb26424ebd3b278d57f1f0e72d.jpg",
            "artist": "Justin Bieber",
            "title": "Love Me",
            "link": "https://modest-carson-3aa7ad.netlify.app/Latch.mp3",
          },
        ]
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Philomena Music"),
      ),
      body: ListView(
        children: [
          for (var eachCategory in songs)
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10.0,
                    ),
                    child: Text(
                      eachCategory["category"],
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    height: 200.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        for (var eachSong in eachCategory["list"])
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            child: eachCategory["category"]
                                        .toString()
                                        .toLowerCase() ==
                                    "artists"
                                ? ArtistsContainer(
                                    artistsData: eachSong,
                                  )
                                : eachCategory["category"]
                                            .toString()
                                            .toLowerCase() ==
                                        "new songs"
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (builder) =>
                                                  MusicPlayerPage(
                                                musicData: eachSong,
                                                isPlaylist: false,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 300.0,
                                              height: 150.0,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  20.0,
                                                ),
                                              ),
                                              child: Image.network(
                                                eachSong["albumArt"]!,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(height: 5.0),
                                            Text(
                                              eachSong["title"]!,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              eachSong["artist"]!,
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : eachCategory["category"]
                                                .toString()
                                                .toLowerCase() ==
                                            "albums"
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (builder) =>
                                                      AlbumSongsListPage(
                                                    musicData: eachSong,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    Container(
                                                      width: 150.0,
                                                      height: 150.0,
                                                      margin: EdgeInsets.only(
                                                        left: 5.0,
                                                        top: 5.0,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.accents[
                                                            random.nextInt(
                                                                Colors.accents
                                                                    .length)],
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(
                                                            10.0,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 150.0,
                                                      height: 150.0,
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      decoration: BoxDecoration(
                                                        color: Colors.black,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(
                                                            10.0,
                                                          ),
                                                        ),
                                                      ),
                                                      child: Image.network(
                                                        eachSong["albumArt"]!,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5.0),
                                                Text(
                                                  eachSong["album"]!,
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  eachSong["artist"]!,
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey[500],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (builder) =>
                                                      MusicPlayerPage(
                                                    musicData: eachSong,
                                                    isPlaylist: false,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: 150.0,
                                                  height: 150.0,
                                                  child: Image.network(
                                                    eachSong["albumArt"]!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                SizedBox(height: 5.0),
                                                Text(
                                                  eachSong["title"]!,
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  eachSong["artist"]!,
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.grey[500],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}
