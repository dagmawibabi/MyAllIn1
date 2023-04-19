import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myallin1/pages/musicStreamingPage/album_songs_list_page.dart';
import 'package:myallin1/pages/musicStreamingPage/albums_container.dart';
import 'package:myallin1/pages/musicStreamingPage/artists_container.dart';
import 'package:myallin1/pages/musicStreamingPage/music_player_page.dart';
import 'package:myallin1/pages/musicStreamingPage/podcast_details_page.dart';

class MusicStreamingPage extends StatefulWidget {
  const MusicStreamingPage({
    super.key,
    required this.streamMusic,
    required this.pauseOrPlay,
    required this.nextInPlaylist,
    required this.previousInPlaylist,
    required this.assetsAudioPlayer,
    required this.isMusicPlaying,
  });

  final Function streamMusic;
  final Function pauseOrPlay;
  final Function nextInPlaylist;
  final Function previousInPlaylist;
  final AssetsAudioPlayer assetsAudioPlayer;
  final bool isMusicPlaying;

  @override
  State<MusicStreamingPage> createState() => _MusicStreamingPageState();
}

class _MusicStreamingPageState extends State<MusicStreamingPage> {
  @override
  Widget build(BuildContext context) {
    List songs = [
      {
        "category": "Top Picks",
        "list": [
          {
            "albumArt": "https://i.ytimg.com/vi/T4ib_RJtMFk/sddefault.jpg",
            "artist": "Dawit Getachew",
            "title": "Enafkalew",
            "link": "Singles/Enafkalew.mp3",
          },
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
                "https://i.pinimg.com/564x/01/fb/3b/01fb3bc44975e76849ca5fb01b4f599c.jpg",
            "artist": "AJR",
            "title": "Neotheatre",
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
                "https://i.pinimg.com/564x/50/2e/d9/502ed91c545ae284c5f73394ca486be4.jpg",
            "artist": "Billie Eilish",
            "title": "Almost Gone",
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
            "artist": "Dawit Getachew",
            "albumArt":
                "https://dawitgetachew.org/wp-content/uploads/2022/12/photo_2021-09-13-19.23.04.jpeg",
            "album": "Aminhalew",
            "songs": [
              "Abet Fikreh.mp3",
              "Amelkihalehu.mp3",
              "Amnihalehu.mp3",
              "Ante Bicha.mp3",
              "Ante Kibre Neh.mp3",
              "Ante Melkam Neh.mp3",
              "Atsedeken.mp3",
              "Beki Neh.mp3",
              "Fiker.mp3",
              "Oh Nefse.mp3",
              "Semhin Ebarikalew.mp3",
              "Tilik Neh.mp3",
              "Tsegaw Bemnet Adinonal.mp3",
              "Ye Eyesus Menged.mp3",
              "Yimetal.mp3",
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
            "albumArt": "https://i.ytimg.com/vi/AfKd7aGCL7U/maxresdefault.jpg",
            "artist": "Boyce Avenue",
            "title": "Here Comes the Sun",
            "link": "Singles/Here Comes the Sun.mp3",
          },
          {
            "albumArt":
                "https://i.pinimg.com/564x/b1/35/ac/b135acaf2410c48b8829ff7c14612258.jpg",
            "artist": "M83",
            "title": "Wait",
            "link": "Singles/Wait.mp3",
          },
          {
            "albumArt":
                "https://i.pinimg.com/564x/d5/cd/7f/d5cd7f2b5cdb99a9545c1eb443b39eee.jpg",
            "artist": "Hans Zimmer",
            "title": "Cornfield Chase",
            "link": "Singles/Cornfield Chase.mp3",
          },
          {
            "albumArt":
                "https://static.wikia.nocookie.net/justin-bieber/images/c/c3/My_World.jpg/revision/latest?cb=20190604183838",
            "artist": "Justin Bieber",
            "title": "Love Me",
            "link": "Singles/Love Me.mp3",
          },
        ]
      },
    ];

    List podcasts = [
      {
        "title": "AASTU Nights",
        "coverArt":
            "https://www.dagmawibabi.com/userdata/media/AASTUNights.jpg",
        "episodes": [
          "EP 1 - Orientation.mp3",
          "EP 2 - Missing Professors.mp3",
        ],
        "producer": "Dream Intelligence",
        "description":
            "AASTU Nights. A funny horror podcast that feels like you're listening to the morning announcements of school. Where your host, that goes by the name THE HOST, talks about the latest news and events that are happening in AASTU. ",
      },
      {
        "title": "Welcome to Night Vale",
        "coverArt":
            "https://images.squarespace-cdn.com/content/v1/51e7119ae4b01c2e6a200e01/1424727843284-J00SH31WZZMAUM7Q2O0D/image-asset.png?format=750w",
        "episodes": [
          "1 - Pilot.mp3",
          "2 - Glow Cloud.mp3",
          "3 - A Story About You.mp3",
          "4 - The Man in the Tan Jacket.mp3",
          "5 - Faceless Old Woman.mp3",
        ],
        "producer": "Night Vale Presents",
        "description":
            "Welcome to Night Vale is a twice-monthly podcast in the style of community updates for the small desert town of Night Vale, featuring local weather, news, announcements from the Sheriff's Secret Police, mysterious lights in the night sky, dark hooded figures with unknowable powers, and cultural events. ",
      },
      {
        "title": "Lex Fridman Podcast",
        "coverArt":
            "https://upload.wikimedia.org/wikipedia/commons/5/50/Lex_Fridman_teaching_at_MIT_in_2018.png",
        "episodes": [
          "Sam Altman: OpenAI",
          "Guido Van Rossum: Python",
          "Jordan Peterson",
          "Elon Musk: Neural Link",
          "Bill Gates: Farming",
        ],
        "producer": "Lex Fridman",
        "description":
            "Conversations about the nature of intelligence, consciousness, love, and power. ",
      },
      {
        "title": "Waveform",
        "coverArt":
            "https://podcasts.voxmedia.com/perch/resources/21vmpn011waveformsocial3000x3000.png",
        "episodes": [
          "Introduction.mp3",
          "Porsche vs Tesla.mp3",
          "YouTube, Twitter and Apple.mp3",
          "Samsung Galaxy Note 10.mp3",
        ],
        "producer": "MKBHD",
        "description":
            "A tech podcast for the gadget lovers and tech heads among us from the mind of Marques Brownlee, better known as MKBHD. MKBHD has made a name for himself on YouTube reviewing everything from the newest smartphones to cameras to electric cars. ",
      },
      {
        "title": "The Alexandria Archives",
        "coverArt":
            "https://is4-ssl.mzstatic.com/image/thumb/Podcasts115/v4/91/ea/f3/91eaf3c6-c90f-435f-01e8-fc49fadd466c/mza_13449284485635254292.jpg/1200x1200bb.jpg",
        "episodes": [
          "Service Call",
          "House Painting On Halloween",
          "The Tunnels",
          "Echoes of Laughter",
          "Househunting",
          "Christmas with Kurz",
          "Initiation Night",
        ],
        "producer": "Nicole Jorge",
        "description": "The South's Answer to Miskatonic University.",
      },
      {
        "title": "DUST",
        "coverArt":
            "https://i.scdn.co/image/ab6765630000ba8a11233c4063f9c7b92e39c7aa",
        "episodes": [
          "Horizons",
          "Genborn",
          "Pendulum",
          "Sanctity",
          "Flight 008",
          "Seat 13F",
          "Chrysalis",
        ],
        "producer": "Gunpowder & Sky",
        "description":
            "DUST is the premier destination for immersive science fiction audio stories.",
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
                                                streamMusic: widget.streamMusic,
                                                pauseOrPlay: widget.pauseOrPlay,
                                                nextInPlaylist:
                                                    widget.nextInPlaylist,
                                                previousInPlaylist:
                                                    widget.previousInPlaylist,
                                                assetsAudioPlayer:
                                                    widget.assetsAudioPlayer,
                                                isMusicPlaying:
                                                    widget.isMusicPlaying,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Hero(
                                              tag: eachSong["albumArt"]!,
                                              child: Container(
                                                width: 300.0,
                                                height: 150.0,
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[900]!
                                                      .withOpacity(0.4),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    20.0,
                                                  ),
                                                ),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  alignment:
                                                      Alignment.topCenter,
                                                  imageUrl:
                                                      eachSong["albumArt"]!,
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: downloadProgress
                                                          .progress,
                                                      color: Colors.accents[
                                                          Random().nextInt(Colors
                                                              .accents
                                                              .length)], // Colors.white,
                                                      strokeWidth: 1.0,
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(
                                                    Icons.error_outline,
                                                  ),
                                                ),
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
                                            child: AlbumsContainer(
                                              currentAlbum: eachSong,
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
                                                    // justDisplay: eachSong["title"] == widget.,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Hero(
                                                  tag: eachSong["albumArt"]!,
                                                  child: Container(
                                                    width: 150.0,
                                                    height: 150.0,
                                                    color: Colors.grey[900]!
                                                        .withOpacity(0.4),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          eachSong["albumArt"]!,
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                                  downloadProgress) =>
                                                              Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress,
                                                          color: Colors.accents[
                                                              Random().nextInt(
                                                                  Colors.accents
                                                                      .length)], // Colors.white,
                                                          strokeWidth: 1.0,
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(
                                                        Icons.error_outline,
                                                      ),
                                                    ),
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
          SizedBox(height: 10.0),

          // Podcasts
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            child: Text(
              "Podcasts",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          // List of podcasts
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
            child: Container(
              height: 230.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var eachPodcast in podcasts)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PodcastDetailsPage(
                              podcastObject: eachPodcast,
                              musicData: eachPodcast,
                              streamMusic: widget.streamMusic,
                              pauseOrPlay: widget.pauseOrPlay,
                              nextInPlaylist: widget.nextInPlaylist,
                              previousInPlaylist: widget.previousInPlaylist,
                              assetsAudioPlayer: widget.assetsAudioPlayer,
                              isMusicPlaying: widget.isMusicPlaying,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Podcast Cover Art
                            Hero(
                              tag: eachPodcast["coverArt"]!,
                              child: Container(
                                width: 180.0,
                                height: 180.0,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: Colors.grey[900]!.withOpacity(0.4),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      10.0,
                                    ),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 10.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: eachPodcast["coverArt"]!,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                      // color: randomContainerColor, // Colors.white,
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
                            // Podcast Title
                            SizedBox(height: 5.0),
                            Container(
                              width: 180.0,
                              child: Text(
                                eachPodcast["title"]!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 2.0),
                            // Podcast Episodes Number
                            Text(
                              "Episodes: " +
                                  eachPodcast["episodes"].length.toString(),
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
          ),

          SizedBox(height: 150.0),
        ],
      ),
    );
  }
}
