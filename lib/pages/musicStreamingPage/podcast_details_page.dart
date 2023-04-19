import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myallin1/pages/musicStreamingPage/music_player_page.dart';
import 'package:palette_generator/palette_generator.dart';

class PodcastDetailsPage extends StatefulWidget {
  const PodcastDetailsPage({
    super.key,
    required this.podcastObject,
    required this.musicData,
    required this.streamMusic,
    required this.pauseOrPlay,
    required this.nextInPlaylist,
    required this.previousInPlaylist,
    required this.assetsAudioPlayer,
    required this.isMusicPlaying,
  });

  final Map podcastObject;
  final Map musicData;
  final Function streamMusic;
  final Function pauseOrPlay;
  final Function nextInPlaylist;
  final Function previousInPlaylist;
  final AssetsAudioPlayer assetsAudioPlayer;
  final bool isMusicPlaying;

  @override
  State<PodcastDetailsPage> createState() => _PodcastDetailsPageState();
}

class _PodcastDetailsPageState extends State<PodcastDetailsPage> {
  // Globals
  bool isSubscribed = false;
  bool isNotificationOn = false;

  Future<Color> getImagePalette() async {
    ImageProvider imageProvider = NetworkImage(
      widget.podcastObject["coverArt"]!,
    );
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor!.color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     widget.podcastObject["title"],
      //   ),
      // ),
      body: FutureBuilder(
        future: getImagePalette(),
        builder: (context, snapshot) => Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: snapshot.data == null
                ? Colors.black.withOpacity(0.4)
                : snapshot.data?.withOpacity(1.0),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: snapshot.data == null
                  ? [
                      Colors.transparent,
                      Colors.transparent,
                    ]
                  : [
                      snapshot.data!,
                      snapshot.data!.withOpacity(0.6),
                      snapshot.data!.withOpacity(0.6),
                      Colors.black,
                      Colors.black,
                      Colors.black,
                      // Colors.grey[900]!.withOpacity(0.4),
                    ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          child: ListView(
            children: [
              SizedBox(height: 14.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Hero(
                    tag: widget.podcastObject["coverArt"]!,
                    child: Container(
                      width: 180.0,
                      height: 180.0,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        // color: Colors.grey[700]!.withOpacity(0.01),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 50.0,
                            spreadRadius: 0.5,
                          ),
                        ],
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.podcastObject["coverArt"]!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
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
                  // Podcast Title and Producer
                  Column(
                    children: [
                      // Podcast Title
                      Container(
                        width: 170.0,
                        // color: Colors.red,
                        child: Text(
                          widget.podcastObject["title"],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                            height: 1.3,
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      // Podcast Producer
                      Container(
                        width: 170.0,
                        // color: Colors.red,
                        child: Text(
                          widget.podcastObject["producer"],
                          style: TextStyle(
                            color: Colors.grey[400]!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // Subscribe and Notification
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      isSubscribed = !isSubscribed;
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 20.0,
                        top: 14.0,
                        bottom: 14.0,
                        right: 8.0,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 5.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSubscribed == true
                              ? Colors.orangeAccent
                              : Colors.greenAccent,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                      ),
                      child: Text(
                        isSubscribed == true ? "Unsubscribe" : "Subscribe",
                        style: TextStyle(
                          color: isSubscribed == true
                              ? Colors.orange
                              : Colors.greenAccent,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      isNotificationOn = !isNotificationOn;
                      setState(() {});
                    },
                    child: Icon(
                      Icons.notification_add_outlined,
                      color: isNotificationOn == true
                          ? Colors.lightBlueAccent
                          : Colors.white,
                    ),
                  ),
                ],
              ),
              // Podcast Description
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: Text(
                  widget.podcastObject["description"],
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              // Episodes
              SizedBox(height: 20.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "Episodes",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 18.0),
                      child: Text(
                        widget.podcastObject["episodes"].length.toString(),
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.0),

              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                child: ListView(
                  children: [
                    // Each Episode
                    for (var eachEpisode in widget.podcastObject["episodes"])
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MusicPlayerPage(
                                musicData: widget.podcastObject,
                                isPlaylist: true,
                                currentSong: eachEpisode.toString(),
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
                          margin: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          padding: EdgeInsets.only(
                            left: 10.0,
                            right: 10.0,
                            top: 10.0,
                            bottom: 0.0,
                          ),
                          decoration: BoxDecoration(
                            // color: Colors.blue,
                            color: Colors.grey[900]!.withOpacity(0.5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 45.0,
                                        height: 45.0,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          // color: Colors.grey[700]!.withOpacity(0.01),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                        ),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              widget.podcastObject["coverArt"]!,
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                            child: CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                              // color: randomContainerColor, // Colors.white,
                                              color: Colors.white,
                                              strokeWidth: 1.0,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                            Icons.error_outline,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              eachEpisode.toString(),
                                              style: TextStyle(
                                                // fontSize: 18.0,
                                                color: Colors.white,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Container(
                                            child: Text(
                                              "July 12, 2024" +
                                                  " • " +
                                                  "16 mins",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.grey[500]!,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(4.0),
                                    margin: EdgeInsets.only(
                                        bottom: 3.0, right: 2.0),
                                    decoration: BoxDecoration(
                                      // color: Color.fromARGB(255, 53, 189, 25),
                                      border: Border.all(
                                        color: Color.fromARGB(255, 53, 189, 25),
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(200.0),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Color.fromARGB(255, 53, 189, 25),
                                      // size: 30.0,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                widget.podcastObject["description"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  height: 1.4,
                                ),
                              ),
                              // SizedBox(height: 10.0),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.downloading_outlined,
                                      size: 22.0,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.share_outlined,
                                      size: 22.0,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.more_vert_outlined,
                                      size: 22.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    // Space
                    SizedBox(height: 200.0),
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
