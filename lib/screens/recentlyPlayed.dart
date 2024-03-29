import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_ui/recently/recentlyPlayed.dart';
import 'package:music_ui/screens/splachScreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../applications/recent_bloc/recent_bloc_bloc.dart';
import '../function/currentPlaying.dart';
import 'addtoplaylist.dart';
import 'musicPlaying.dart';

class RecentlyScreen extends StatelessWidget {
  const RecentlyScreen({super.key});

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
                  padding: const EdgeInsets.only(left: 10),
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
                            icon: const Icon(Icons.arrow_back_ios_new)),
                        const Padding(
                          padding: EdgeInsets.only(right: 90),
                          child: Text(
                            'Recently played',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
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
                  child: BlocBuilder<RecentlyBloc, RecentlyState>(
                    builder: (context, recentState) {
                      if (recentList.value.isEmpty) {
                        return const Padding(
                          padding:
                              EdgeInsets.only(right: 20, bottom: 20, left: 20),
                          child: Center(
                            child: Text(
                              "No Songs Added",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 126, 126, 126),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 5),
                        itemCount: recentList.value.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              playMusic(index, recentList.value);
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                playingList.add(Audio(allSongs[index].url!));
                                return PlayingScreen(playingSong: allSongs[index]);
                              }));
                            },
                            child: ListTile(
                              leading: QueryArtworkWidget(
                                artworkWidth: 30,
                                artworkHeight: 30,
                                artworkFit: BoxFit.cover,
                                id: recentList.value[index].id!,
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
                                recentList.value[index].name!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    color: Colors.grey[100],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                recentList.value[index].artist ?? 'unknown',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey[100],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 198, 198, 198),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                // ElevatedButton(
                                                //     onPressed: () {
                                                //       removeFromFav(favorite
                                                //           .value[index]
                                                //           .id as int);

                                                //       Navigator.pop(context);
                                                //     },
                                                //     child: Text(
                                                //         'Remove to favorite')),
                                                ElevatedButton.icon(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              addingToPlaylist(
                                                                  music: allSongs[
                                                                      index]),
                                                        ),
                                                      );
                                                    },
                                                    icon: const Icon(Icons.add),
                                                    label: const Text(
                                                        'Add to playlist')),
                                              ],
                                            ));
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.more_vert,
                                    color: Color.fromARGB(255, 217, 217, 217),
                                  )),
                            ),
                          );
                        },
                      );
                    },
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
