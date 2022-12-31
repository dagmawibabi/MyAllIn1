import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

class MusicListBottomSheet extends StatefulWidget {
  const MusicListBottomSheet({
    super.key,
    required this.deviceMusicList,
    required this.loadDeviceMusicFile,
    required this.getDeviceAudioFiles,
    required this.changeMusicTitle,
    required this.localChangedMusicTitle,
    required this.currentSong,
  });

  final List deviceMusicList;
  final Function loadDeviceMusicFile;
  final Function getDeviceAudioFiles;
  final Function changeMusicTitle;
  final Function localChangedMusicTitle;
  final String currentSong;

  @override
  State<MusicListBottomSheet> createState() => _MusicListBottomSheetState();
}

class _MusicListBottomSheetState extends State<MusicListBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          // height: MediaQuery.of(context).size.height * 0.6,
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          padding: EdgeInsets.only(top: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            image: DecorationImage(
              image: AssetImage("assets/images/INR.jpg"),
              fit: BoxFit.cover,
              opacity: 0.15,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Songs",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            widget.getDeviceAudioFiles();
                          },
                          icon: Icon(
                            Icons.refresh,
                            size: 20.0,
                            color: Colors.grey[500]!,
                          ),
                        ),
                        Text(
                          widget.deviceMusicList.length.toString(),
                          style: TextStyle(
                            color: Colors.grey[500]!,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              for (var songs in widget.deviceMusicList)
                GestureDetector(
                  onTap: () {
                    widget.loadDeviceMusicFile(songs);
                    widget.changeMusicTitle(
                      p.withoutExtension(
                        p.basename(
                          songs.toString(),
                        ),
                      ),
                    );
                    widget.localChangedMusicTitle(
                      p.withoutExtension(
                        p.basename(
                          songs.toString(),
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Container(
                    // width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      p.withoutExtension(
                        p.basename(
                          songs.toString(),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 15.0,
                        color: widget.currentSong ==
                                p.withoutExtension(
                                  p.basename(
                                    songs.toString(),
                                  ),
                                )
                            ? Colors.greenAccent
                            : Colors.grey[300]!,
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 200.0),
            ],
          ),
        ),
      ],
    );
  }
}
