import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_ui/favorite/fav_db_functions.dart';
import 'package:music_ui/function/currentPlaying.dart';
import 'package:music_ui/function/playlist/playlist_funcion.dart';
import 'package:music_ui/screens/Mini_Player.dart';
import 'package:music_ui/screens/homeScreen.dart';
import 'package:music_ui/screens/musicPlaying.dart';
import 'package:music_ui/screens/splachScreen.dart';
import 'package:music_ui/widget/listTile3.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../function/mostlyPlayed/mostlyPlayed_function.dart';
import '../function/playlist/list_model.dart';
import '../recently/recentlyPlayed.dart';

class PlaylistPlaying extends StatelessWidget {
  
  final int indexoflist;
  final ListClass? currentPlayListindex;
  PlaylistPlaying(
      {required this.indexoflist, super.key, this.currentPlayListindex});
  List<String> list = [
    'Music 1',
    'Music 2',
    'Music 3',
    'Music 4',
    'Music 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 141, 141, 141),
            Color.fromARGB(255, 25, 25, 25)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 60,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 94, 94, 94),
                    Color.fromARGB(255, 35, 35, 35)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 143, 143, 143),
                        Color.fromARGB(255, 75, 75, 75)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_new)),
                      const Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Text(
                          'Playlistttt',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: IconButton(
                          onPressed: () {
                            bottomsheet(context);
                          },
                          icon: Icon(Icons.add),
                          iconSize: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 10,
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: playlistNotifier,
                    builder: (context, value, child) {
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 5),
                        itemCount: value[indexoflist].playlistSongs.length,
                        itemBuilder: (context, index) {
                          // return ListTile(
                          //   title:
                          //       Text(value[indexoflist].playlistSongs[index].name!),

                          // );

                          return InkWell(
                            onTap: () {
                               recentadd(allSongs[index]);
                               addMostlyPlayed(allSongs[index]);
                              playMusic(index,
                                  playlistNotifier.value[indexoflist].playlistSongs);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayingScreen(),
                                  ));
                            },
                            child: ListTile(
                              leading: QueryArtworkWidget(
                                artworkWidth: 30,
                                artworkHeight: 30,
                                artworkFit: BoxFit.cover,
                                id: playlistNotifier.value[indexoflist]
                                    .playlistSongs[index].id!,
                                type: ArtworkType.AUDIO,
                                artworkQuality: FilterQuality.high,
                                size: 10,
                                quality: 100,
                                artworkBorder: BorderRadius.circular(60),
                                nullArtworkWidget: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  child: Image.asset(
                                    'assets/image/Music3.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Text(
                                playlistNotifier.value[indexoflist]
                                    .playlistSongs[index].name!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    color: Colors.grey[100],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                playlistNotifier.value[indexoflist]
                                        .playlistSongs[index].artist ??
                                    'unknown',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey[100],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300),
                              ),
                              // trailing: Icon(
                              //   Icons.more_vert,
                              //   color: Colors.grey[100],
                              // ),
                              trailing: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            backgroundColor: Color.fromARGB(
                                                255, 198, 198, 198),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      romoveFromPlaylist(
                                                          playlistNotifier
                                                                  .value[
                                                                      indexoflist]
                                                                  .playlistSongs[
                                                              index],
                                                          currentPlayListindex!
                                                              .name);
                                                      playlistNotifier
                                                          .value[indexoflist]
                                                          .playlistSongs
                                                          .remove(playlistNotifier
                                                                  .value[
                                                                      indexoflist]
                                                                  .playlistSongs[
                                                              index]);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Remove')),
                                                // ElevatedButton.icon(
                                                //     onPressed: () {},
                                                //     icon: Icon(Icons.add),
                                                //     label:
                                                //         Text('Add to playlist')),
                                              ],
                                            ));
                                      },
                                    );
                                  },
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: Color.fromARGB(255, 217, 217, 217),
                                  )),
                            ),
                          );
                        },
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    ),
    bottomSheet: MiniPlayer(),
    );
  }

  bottomsheet(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Color(0xFF808080),
      context: context,
      builder: (context) {
        return ListView.builder(
          itemCount: allSongs.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: QueryArtworkWidget(
                artworkWidth: 30, artworkHeight: 30,
                artworkFit: BoxFit.cover,
                id: allSongs[index].id!,
                type: ArtworkType.AUDIO,
                artworkQuality: FilterQuality.high,
                //size: 10,
                quality: 100,
                artworkBorder: BorderRadius.circular(60),
                nullArtworkWidget: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                  child: Image.asset(
                    'assets/image/Music3.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                allSongs[index].name!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: 'OpenSans',
                    color: Colors.grey[100],
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                allSongs[index].artist ?? 'unknown',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 12,
                    fontWeight: FontWeight.w300),
              ),
              trailing: IconButton(
                  onPressed: () {
                    if (playlistNotifier.value[indexoflist].playlistSongs
                        .contains(allSongs[index])) {
                      romoveFromPlaylist(
                          allSongs[index], currentPlayListindex!.name);
                      playlistNotifier.value[indexoflist].playlistSongs
                          .remove(allSongs[index]);
                    } else {
                      addsongToPlaylist(
                          allSongs[index], currentPlayListindex!.name);
                      playlistNotifier.value[indexoflist].playlistSongs
                          .add(allSongs[index]);
                    }
                  },
                  icon: Icon(
                    Icons.add,
                    color: Color.fromARGB(255, 217, 217, 217),
                  )),
            );
          },
        );
      },
    );
  }
}
