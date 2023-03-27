// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:myallin1/main.dart';
import 'package:myallin1/pages/bottomsheets/accounts_list_bottom_sheet.dart';
import 'package:myallin1/pages/chatpage/chat_page.dart';
import 'package:myallin1/pages/components/small_pfp.dart';
import 'package:myallin1/pages/musicStreamingPage/music_player_page.dart';
import 'package:myallin1/pages/musicStreamingPage/music_streaming_page.dart';
// import 'package:myallin1/pages/musicplayerpage/music_player_page.dart';
import 'package:myallin1/pages/notificationpage/notificationpage.dart';
import 'package:myallin1/pages/postspage/new_post_page.dart';
import 'package:myallin1/pages/postspage/posts_page.dart';
import 'package:myallin1/pages/profilepage/profilepage.dart';
import 'package:myallin1/pages/searchpage/search_page.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as loc;
import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:myallin1/config/config.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:marquee/marquee.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.currentUser,
  });

  final dynamic currentUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Globals
  String baseURL = Config.baseUrl;
  late TabController tabController;
  int pageIndex = 1;
  bool feedLoading = true;
  bool isMusicPlaying = false;
  List deviceMusicList = [];
  String currentSong = " Sample Song ";
  FocusNode searchFocusNode = FocusNode();
  Map weatherData = {};
  bool weatherLoading = true;
  List availableChats = [];

  // Sample Data
  Map currentUser = {
    "username": "dagmawibabi",
    "fullname": "Dagmawi Babi",
    "profilepic": "assets/images/me.jpg",
    "posts": 96,
    "followers": 13548,
    "following": 465,
    "phone": "+251975124687",
    "email": "1babidagi@gmail.com",
    "bio": "Build, Break and Rebuild!",
  };
  List feed = [
    {
      "username": "DagmawiBabi",
      "fullname": "Dagmawi Babi",
      "profilepic": "assets/images/me.jpg",
      "likes": 1345,
      "comments": 945,
      "reposts": 342,
      "content":
          "Currently working on componentizing every element of this social media to make development easy and efficient.",
      "commentsList": [
        "1",
        "2",
        "3",
        "4",
        "5",
      ],
      "likers": [
        "11",
        "22",
        "33",
      ],
      "reposters": [
        "111",
        "222",
        "333",
        "444",
      ],
    },
    {
      "profilepic": "assets/images/me.jpg",
      "fullname": "Dagmawi Babi",
      "username": "DagmawiBabi",
      "likes": 1200,
      "comments": 864,
      "reposts": 256,
      "content":
          "This is the first  post in this new amazing social media that will take off. Trust me this is amazing. So gorgeous too.",
      "commentsList": [
        "1",
        "2",
        "3",
        "4",
        "5",
      ],
      "likers": [
        "11",
        "22",
        "33",
      ],
      "reposters": [
        "111",
        "222",
        "333",
        "444",
      ],
    },
    {
      "profilepic": "assets/images/me.jpg",
      "fullname": "Dagmawi Babi",
      "username": "DagmawiBabi",
      "likes": 1345,
      "comments": 945,
      "reposts": 342,
      "content":
          "This is the first  post in this new amazing social media that will take off. Trust me this is amazing. So gorgeous too.",
      "commentsList": [
        "1",
        "2",
        "3",
        "4",
        "5",
      ],
      "likers": [
        "11",
        "22",
        "33",
      ],
      "reposters": [
        "111",
        "222",
        "333",
        "444",
      ],
    },
    {
      "profilepic": "assets/images/me.jpg",
      "fullname": "Dagmawi Babi",
      "username": "DagmawiBabi",
      "likes": 1200,
      "comments": 864,
      "reposts": 256,
      "content":
          "This is the first  post in this new amazing social media that will take off. Trust me this is amazing. So gorgeous too.",
      "commentsList": [
        "1",
        "2",
        "3",
        "4",
        "5",
      ],
      "likers": [
        "11",
        "22",
        "33",
      ],
      "reposters": [
        "111",
        "222",
        "333",
        "444",
      ],
    },
  ];

  // Get Feed
  void getFeed() async {
    var route = "$baseURL/posts/getFeed/" + widget.currentUser["username"];
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    dynamic resultJSON = jsonDecode(results.body);
    feed = resultJSON.reversed.toList();
    feedLoading = false;
    setState(() {});
    // print(resultJSON);
  }

  // Get Feed Polling
  void getFeedPolling() async {
    Timer.periodic(Duration(seconds: 10), (time) {
      pageIndex == 1 ? getFeed() : () {};
    });
  }

  // New Post
  void newPost(newPostObject) async {
    var route = "$baseURL/posts/newPost";
    var url = Uri.parse(route);
    var jsonFormat = jsonEncode(newPostObject);
    await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonFormat,
    );

    getFeed();
  }

  // New Upload
  void newUpload(newPostObject, image, imageName, isImage) async {
    var route =
        isImage == true ? "$baseURL/upload/images" : "$baseURL/upload/videos";
    var url = Uri.parse(route);
    var jsonFormat = jsonEncode(newPostObject);

    var request = http.MultipartRequest("POST", url);
    request.fields["fullname"] = newPostObject["fullname"];
    request.fields["username"] = newPostObject["username"];
    request.fields["content"] = newPostObject["content"];
    request.fields["gore"] = newPostObject["gore"].toString();
    request.fields["hidden"] = newPostObject["hidden"].toString();
    request.fields["spoiler"] = newPostObject["spoiler"].toString();
    request.fields["nsfw"] = newPostObject["nsfw"].toString();

    var picture = http.MultipartFile.fromBytes(
      isImage == true ? "image" : "video",
      image,
      filename: imageName,
    );

    request.files.add(picture);
    await request.send();
    getFeed();
    setState(() {});
  }

  // Music Player
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  // Get All Device Audio Files
  void getDeviceAudioFiles() async {
    deviceMusicList = [];
    dynamic files =
        Directory('/storage/emulated/0/Music').listSync(recursive: true);
    for (dynamic file in files) {
      if (file.path.endsWith(".mp3") == true) {
        deviceMusicList.add(file.path);
      }
    }
    chooseRandomAlbumArt();
  }

  // Load Music FIle
  void loadDeviceMusicFile(String path) async {
    await audioPlayer.stop();
    await audioPlayer.open(
      Audio.file(path),
      autoStart: true,
      showNotification: false,
      loopMode: LoopMode.single,
    );
    chooseRandomAlbumArt();
  }

  // Change the title of the current playing music
  void changeMusicTitle(String title) {
    currentSong = title;
    setState(() {});
  }

  void nextDeviceMusic() async {}

  int albumArtIndex = 0;
  var albumArts = [
    "https://i.pinimg.com/564x/5a/f1/ce/5af1ce2c040bbfaa7fc6717b3d2fceac.jpg",
    "https://i.pinimg.com/564x/66/74/fe/6674fe273ff978cf8faeae9b1115b097.jpg",
    "https://i.pinimg.com/564x/1a/ad/d3/1aadd37ada5ec9cd4ad3076bf0361d39.jpg",
  ];
  void chooseRandomAlbumArt() async {
    var random = Random();
    albumArtIndex = random.nextInt(albumArts.length - 1);
  }

  // Music Streaming
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  String musicRoot = Config.musicLibraryRoot + "/";
  int playlistIndex = 0;
  // List playlist = [];
  bool isPlaylist = false;
  bool isMusicStopped = true;
  Map currentPlayingSong = {};
  String currentPlaylistSong = " Song Title ";
  List<Audio> playlist = [];
  List playlistStrings = [];
  List entireMusicData = [];
  dynamic playlistMusicData;

  void streamMusic(isPlaylist, musicData, currentSongIndex) async {
    currentPlayingSong = musicData;
    // playlistIndexParam = playlistIndex;
    await assetsAudioPlayer.stop();
    // await assetsAudioPlayer.dispose();
    // assetsAudioPlayer = AssetsAudioPlayer();
    // isMusicPlaying = false;
    // setState(() {});
    // https://modest-carson-3aa7ad.netlify.app/Latch.mp3
    try {
      if (isPlaylist == false) {
        playlistIndex = -1;
        await assetsAudioPlayer.open(
          Audio.network(
            musicRoot + musicData["link"],
          ),
          autoStart: true,
        );
      } else {
        playlist = [];
        playlistStrings = musicData["songs"];
        playlistMusicData = musicData;
        // entireMusicData = musicData;
        for (var eachSong in musicData["songs"]) {
          playlist.add(
            Audio.network(
              musicRoot +
                  musicData["artist"] +
                  "/" +
                  musicData["album"] +
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
          autoStart: true,
        );

        isPlaylist = true;
        playlistIndex = currentSongIndex;

        currentPlaylistSong = musicData["songs"][currentSongIndex].toString();

        setState(() {});
        setState(() {});
        await assetsAudioPlayer.playlistPlayAtIndex(playlistIndex);
      }
      isMusicPlaying = true;
      isMusicStopped = false;
      // pauseOrPlay();
    } catch (t) {
      print("some error");
      isMusicPlaying = false;
      isMusicStopped = true;
      setState(() {});
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
    isMusicStopped = false;
    setState(() {});
  }

  void previousInPlaylist() async {
    playlistIndex--;
    if (playlistIndex < 0) {
      playlistIndex = playlist.length - 1;
    }
    currentPlaylistSong = playlistStrings[playlistIndex].toString();
    // print(playlist[playlistIndex]);
    setState(() {});
    await assetsAudioPlayer.stop();
    await assetsAudioPlayer.previous();
  }

  void nextInPlaylist() async {
    playlistIndex++;
    if (playlistIndex >= playlist.length) {
      playlistIndex = 0;
    }
    currentPlaylistSong = playlistStrings[playlistIndex].toString();
    // print(playlist[playlistIndex]);
    setState(() {});
    await assetsAudioPlayer.stop();
    await assetsAudioPlayer.next();
  }

  void stopMusic() async {
    isMusicStopped = true;
    await assetsAudioPlayer.stop();
    setState(() {});
  }

  // Get Weather
  late loc.LocationData locationData;
  Future<void> getWeather() async {
    // Get Current Latitude and Longitude
    loc.Location location = await loc.Location();
    locationData = await location.getLocation();
    String latitude = locationData.latitude.toString();
    String longitude = locationData.longitude.toString();
    // Fetch Weather
    var url = Uri.parse(
        "http://api.weatherapi.com/v1/forecast.json?key=d2fea15ced26458aa9801210231401&q=" +
            latitude +
            "," +
            longitude +
            "&aqi=yes");
    var response = await http.get(url);
    var responseJSON = jsonDecode(response.body);
    weatherData = responseJSON;
    weatherLoading = false;
    setState(() {});
  }

  void getAvailableChats() async {
    var route = "$baseURL/profile/getAllProfiles/";
    var url = Uri.parse(route);
    dynamic results = await http.get(url);
    dynamic resultsJSON = jsonDecode(results.body);
    availableChats = resultsJSON;
  }

  void availableChatsList() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      anchorPoint: Offset(0, 0),
      constraints: BoxConstraints(
        // minHeight: MediaQuery.of(context).size.height * 0.6,
        maxHeight: (MediaQuery.of(context).size.height * 0.8),
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return AccountsListBottomSheet(
          listOfAccounts: availableChats,
          currentUser: widget.currentUser,
          listTitle: "Chat With",
        );
      },
    );
  }

  // Ask For Permission
  void askPermission() async {
    // Ask Storage Permissions
    PermissionStatus storagePermissionStatus = await Permission.storage.status;
    if (storagePermissionStatus.isGranted == false) {
      await Permission.storage.request();
      await Permission.manageExternalStorage.request();
      await Permission.photos.request();
      await Permission.videos.request();
      await Permission.audio.request();
    } else {
      // getDeviceAudioFiles();
    }
    print(storagePermissionStatus.isGranted);
    // Ask Location Permission
    loc.Location location = await new loc.Location();
    PermissionStatus locationPermissionStatus =
        await Permission.location.status;
    if (locationPermissionStatus.isGranted == false) {
      await Permission.location.request();
      getWeather();
    } else {
      // locationData = await location.getLocation();
      getWeather();
    }
  }

  // getData
  void getContent() async {
    // getWeather();
    getFeed();
    getFeedPolling();
    getAvailableChats();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
  }

  // initState
  @override
  void initState() {
    askPermission();
    chooseRandomAlbumArt();

    tabController = TabController(length: 3, vsync: this);
    tabController.index = 1;
    tabController.addListener(() {
      pageIndex = tabController.index;
      setState(() {});
    });

    getContent();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    currentUser = widget.currentUser;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 5.0,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                // Navigator.pushNamed(context, "profile");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      profile: currentUser,
                    ),
                  ),
                );
              },
              child: Hero(
                tag: "profilepic",
                child: Container(
                  padding: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(100.0),
                    ),
                  ),
                  child: SmallPFP(
                    size: 35.0,
                    netpic: widget.currentUser["profilepic"],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            GestureDetector(
              onLongPress: () {
                isMusicStopped = !isMusicStopped;
                setState(() {});
              },
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MusicStreamingPage(
                      streamMusic: streamMusic,
                      pauseOrPlay: pauseOrPlay,
                      nextInPlaylist: nextInPlaylist,
                      previousInPlaylist: previousInPlaylist,
                      assetsAudioPlayer: assetsAudioPlayer,
                      isMusicPlaying: isMusicPlaying,
                    ),
                  ),
                );
              },
              child: Text(
                "Philomena",
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              getFeed();
            },
            icon: Icon(
              Icons.refresh_outlined,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationPage(
                    currentUser: currentUser,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.notifications_outlined,
            ),
          ),
          // SizedBox(width: 15.0),
          SizedBox(width: 5.0),
        ],
        bottom: TabBar(
          controller: tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 1.0,

          // indicatorColor: Colors.greenAccent.withOpacity(0.4),
          // indicatorPadding: EdgeInsets.symmetric(horizontal: 20.0),
          labelStyle: TextStyle(
            fontSize: 15.0,
          ),
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Colors.grey[800]!,
          unselectedLabelStyle: TextStyle(
            fontSize: 14.0,
          ),
          tabs: [
            Tab(
              // icon: Icon(Icons.directions_transit),
              text: "Search",
            ),
            Tab(
              // icon: Icon(Icons.directions_car),
              text: "Feed",
            ),
            Tab(
              // icon: Icon(Icons.directions_transit),
              text: "Chats",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          // Search
          SearchPage(
            currentUser: currentUser,
            searchFocusNode: searchFocusNode,
          ),
          // Posts
          feedLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Column(
                      children: [
                        CircularProgressIndicator(
                          color: Colors.grey[500],
                          strokeWidth: 2.0,
                        ),
                        SizedBox(height: 25.0),
                        Text(
                          "Fetching Posts",
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Spacer(),
                    Spacer(),
                  ],
                )
              : PostsPage(
                  feed: feed,
                  currentUser: currentUser,
                  getFeed: getFeed,
                  weatherData: weatherData,
                  weatherLoading: weatherLoading,
                ),
          // Chats
          ChatPage(currentUser: currentUser),
        ],
      ),
      floatingActionButton: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          // color: Colors.grey[900],
          borderRadius: BorderRadius.all(
            Radius.circular(
              100.0,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isMusicStopped == true
                ? Container(
                    color: Colors.transparent,
                    height: 0.0,
                    width: 0.0,
                  )
                : Container(
                    // width: 300.0,
                    // height: 60.0,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 18, 18, 18),
                      border: Border.all(
                        color: Colors.grey[850]!,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          100.0,
                        ),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          currentPlayingSong["albumArt"] ??
                              albumArts[albumArtIndex],
                        ),
                        fit: BoxFit.cover,
                        opacity: 0.1,
                      ),
                    ),
                    margin: EdgeInsets.only(left: 30.0),
                    // padding: EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      children: [
                        SizedBox(width: 6.0),
                        GestureDetector(
                          onTap: () {
                            // print(
                            //     "=================================================x");
                            // print(playlistMusicData);
                            // print(currentPlayingSong);
                            // print(currentSong);
                            // print(playlistMusicData["songs"][playlistIndex]);
                            // print("isPlaylist: " + isPlaylist.toString());

                            // print(
                            //     "isMusicPlaying: " + isMusicPlaying.toString());
                            // print(
                            //     "=================================================x");

                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => MusicPlayerPage(
                            //       audioPlayer: audioPlayer,
                            //       deviceMusicList: deviceMusicList,
                            //       loadDeviceMusicFile: loadDeviceMusicFile,
                            //       getDeviceAudioFiles: getDeviceAudioFiles,
                            //       changeMusicTitle: changeMusicTitle,
                            //       currentSong: currentSong,
                            //       albumArt: albumArts[albumArtIndex],
                            //     ),
                            //   ),
                            // );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MusicPlayerPage(
                                  musicData: playlistIndex != -1
                                      ? playlistMusicData
                                      : currentPlayingSong,
                                  currentSong: playlistIndex != -1
                                      ? playlistMusicData["songs"]
                                          [playlistIndex]
                                      : currentSong,

                                  // isPlaylist == true
                                  //     ? playlistMusicData[playlistIndex]
                                  //     : currentPlayingSong["title"],
                                  isPlaylist: playlistIndex == -1
                                      ? false
                                      : true, // isPlaylist,
                                  streamMusic: streamMusic,
                                  pauseOrPlay: pauseOrPlay,
                                  nextInPlaylist: nextInPlaylist,
                                  previousInPlaylist: previousInPlaylist,
                                  assetsAudioPlayer: assetsAudioPlayer,
                                  isMusicPlaying: isMusicPlaying,
                                  justDisplay: true,
                                ),
                              ),
                            );
                          },
                          child: Hero(
                            tag: currentPlayingSong["albumArt"],
                            child: SmallPFP(
                              netpic: currentPlayingSong["albumArt"] ??
                                  albumArts[albumArtIndex],
                              size: 42.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Container(
                          height: 50.0,
                          width: 90.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 120.0,
                                height: 30.0,
                                padding: EdgeInsets.only(top: 4.0),
                                child: Marquee(
                                  text: currentPlayingSong["title"] ??
                                      currentPlaylistSong.toString().substring(
                                          0,
                                          currentPlaylistSong.lastIndexOf(".")),

                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  blankSpace: 80.0,
                                  velocity: 30.0,
                                  // numberOfRounds: 10,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              //   Text(
                              //     "Anne Leone",
                              //     overflow: TextOverflow.ellipsis,
                              //     style: TextStyle(
                              //       color: Colors.grey[600],
                              //     ),
                              //   ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 6.0),
                          decoration: BoxDecoration(
                            // color: Colors.grey[900],
                            color: Color.fromARGB(255, 18, 18, 18),

                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                100.0,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  stopMusic();
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 14.0, right: 2.0),
                                  child: Icon(
                                    Icons.stop,
                                    size: 22.0,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  previousInPlaylist();
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.fast_rewind,
                                    size: 22.0,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  pauseOrPlay();
                                  // audioPlayer.isPlaying.value
                                  //     ? audioPlayer.pause()
                                  //     : audioPlayer.play();
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    isMusicPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    size: 22.0,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  nextInPlaylist();
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(left: 8.0, right: 14.0),
                                  child: Icon(
                                    Icons.fast_forward,
                                    size: 22.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.grey[850]!),
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              child: Center(
                child: FloatingActionButton(
                  onPressed: () {
                    // ProfileBar(
                    //   profile: {
                    //     "profilepic": widget.post["profilepic"],
                    //     "fullname": widget.post["fullname"],
                    //     "username": widget.post["username"],
                    //   },
                    // ),
                    if (pageIndex == 0) {
                      searchFocusNode.requestFocus();
                    } else if (pageIndex == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewPostPage(
                            currentUser: currentUser,
                            newPostFunction: newPost,
                            uploadPostFunction: newUpload,
                          ),
                        ),
                      );
                    } else if (pageIndex == 2) {
                      availableChatsList();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 6.0),
                    child: Icon(
                      pageIndex == 0
                          ? Ionicons.search_outline
                          : pageIndex == 1
                              ? Ionicons.pencil_outline
                              : Ionicons.person_add_outline,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
