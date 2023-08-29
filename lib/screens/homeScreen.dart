// ignore_for_file: camel_case_types

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_ui/favorite/fav_db_functions.dart';
import 'package:music_ui/function/currentPlaying.dart';
import 'package:music_ui/function/mostlyPlayed/mostlyPlayed_function.dart';
import 'package:music_ui/recently/recentlyPlayed.dart';
import 'package:music_ui/screens/addtoplaylist.dart';
import 'package:music_ui/screens/favoriteScreen.dart';
import 'package:music_ui/screens/mostlyPlayed.dart';
import 'package:music_ui/screens/musicPlaying.dart';
import 'package:music_ui/screens/recentlyPlayed.dart';
import 'package:music_ui/screens/settings.dart';
import 'package:music_ui/screens/splachScreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../applications/favorite_bloc/bloc/favorite_bloc.dart';

final player2 = AssetsAudioPlayer.withId('1');

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String greeting = '';
  @override
  void initState() {
    super.initState();
    updateTime();
  }

  void updateTime() {
    DateTime now = DateTime.now();
    if (now.hour >= 0 && now.hour < 12) {
      setState(() {
        greeting = 'Good Morning';
      });
    } else if (now.hour >= 12 && now.hour < 18) {
      setState(() {
        greeting = 'Good Afternoon';
      });
    } else {
      setState(() {
        greeting = 'Good Night';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaquery = MediaQuery.of(context);
    // getAll();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 170, 170, 170),
            Color.fromARGB(255, 46, 46, 46)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            //------------------Appbar Function--------------------------------

            appbarfunction(context, greeting),
            Column(
              children: [
                Container(
                  height: mediaquery.size.height * 0.19,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 209, 209, 209),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),

                        //----------------------------RecentlyMostlyPlayed--------------------------------
                        child: recentlyMostlyPlayed(),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 7, left: 30, bottom: 7),
                      child: Text(
                        'Your Favorite',
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          fontSize: 27,
                        ),
                      ),
                    ),
                  ],
                ),

                //-----------------------YOURS FAVORITE----------------------------------------
                const yoursFavorite(),

                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 30),
                      child: Text(
                        'Your Songs',
                        style: TextStyle(
                          color: Color.fromARGB(255, 168, 168, 168),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Poppins',
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //----------------------------------------------------------------MUSIC LIST VIEW AREA-------------------------
            const musicListview(),
          ]),
        ),
      ),
    );
  }

  Widget appbarfunction(BuildContext context, String name) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
            fontFamily: 'Poppins',
            color: Color.fromARGB(255, 120, 120, 120),
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 209, 209, 209),
      elevation: 0,
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ));
          },
          icon: const Icon(
            Icons.settings,
            size: 30,
          ),
          padding: const EdgeInsets.only(right: 20, top: 10),
          color: const Color.fromARGB(255, 77, 76, 76),
        ),
      ],
    );
  }
}

class musicListview extends StatelessWidget {
  const musicListview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 10,
        ),
        //------------------------------------valueListenable----------------------------------------------------
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 5),
          itemCount: allSongs.length,
          itemBuilder: (context, index) {
            //-----------------------------------------PLAYING AREA------------------------------------------

            return GestureDetector(
              onTap: () async {
                recentadd(allSongs[index]);
                addMostlyPlayed(allSongs[index]);

                playMusic(index, allSongs);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  playingList.add(Audio(allSongs[index].url!));
                  return PlayingScreen(playingSong: allSongs[index]);
                }));
              },
              child: ListTile(
                leading: QueryArtworkWidget(
                  artworkWidth: 55, artworkHeight: 55,
                  artworkFit: BoxFit.cover,
                  id: allSongs[index].id!,
                  type: ArtworkType.AUDIO,
                  artworkQuality: FilterQuality.high,
                  //size: 10,
                  quality: 100,
                  artworkBorder: BorderRadius.circular(10),
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
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              backgroundColor:
                                  const Color.fromARGB(255, 198, 198, 198),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        if (!favorite
                                            .contains(allSongs[index])) {
                                          context.read<FavoriteBloc>().add(
                                              addToFavoriteBloc(
                                                  blocId: allSongs[index].id
                                                      as int));
                                        } else {
                                          context.read<FavoriteBloc>().add(
                                              removeFromFavBloc(
                                                  id: allSongs[index].id
                                                      as int));
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: favorite.contains(allSongs[index])
                                          ? const Text('Remove from favorite')
                                          : const Text('Add to favorite')),
                                  ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                addingToPlaylist(
                                                    music: allSongs[index]),
                                          ),
                                        );
                                      },
                                      icon: const Icon(Icons.add),
                                      label: const Text('Add to playlistt')),
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
        ),
      ),
    );
  }
}

class yoursFavorite extends StatelessWidget {
  const yoursFavorite({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteScreen(),
                ));
          },
          child: Container(
            height: 125,
            width: 170,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/image/favorite.png')),
              color: Color.fromARGB(255, 0, 0, 0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                topLeft: Radius.circular(15),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteScreen(),
                ));
          },
          child: Container(
            height: 125,
            width: 165,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 83, 83, 83),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Center(
              child: Text(
                'Yours',
                style: TextStyle(
                    color: Colors.grey[500],
                    //fontFamily: 'OpenSans',
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class recentlyMostlyPlayed extends StatelessWidget {
  const recentlyMostlyPlayed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          //===============================
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RecentlyScreen(),
                ));
          },
          child: Container(
            width: 150,
            height: 100,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 7,
                  blurRadius: 19,
                  offset: Offset(0, 5),
                )
              ],
              image:
                  DecorationImage(image: AssetImage('assets/image/Music2.png')),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 30, left: 15),
              child: Text(
                'Recently \nPlayed',
                style: TextStyle(
                    color: Color.fromARGB(255, 225, 225, 225),
                    fontWeight: FontWeight.w700,
                    fontSize: 25),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MostlyPlayedScreen(),
                ));
          },
          child: Container(
            width: 150,
            height: 100,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 7,
                  blurRadius: 19,
                  offset: Offset(0, 5),
                )
              ],
              image:
                  DecorationImage(image: AssetImage('assets/image/Music2.png')),
              color: Color.fromARGB(255, 65, 63, 63),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 30, left: 15),
              child: Text(
                'Mostly \nPlayed',
                style: TextStyle(
                    color: Color.fromARGB(255, 225, 225, 225),
                    fontWeight: FontWeight.w700,
                    fontSize: 25),
              ),
            ),
          ),
        )
      ],
    );
  }
}
