import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_ui/favorite/fav_db_functions.dart';
// import 'package:music_ui/function/db_functions/allSongs.dart';
import 'package:music_ui/function/currentPlaying.dart';
import 'package:music_ui/function/mostlyPlayed/mostlyPlayed_function.dart';
import 'package:music_ui/recently/recentlyPlayed.dart';
import 'package:music_ui/screens/addtoplaylist.dart';
import 'package:music_ui/screens/favoriteScreen.dart';
import 'package:music_ui/screens/mostlyPlayed.dart';
import 'package:music_ui/screens/musicPlaying.dart';
import 'package:music_ui/screens/objectsFuncton.dart';
import 'package:music_ui/screens/recentlyPlayed.dart';
import 'package:music_ui/screens/settings.dart';
import 'package:music_ui/screens/splachScreen.dart';
import 'package:music_ui/widget/listtile.dart';
import 'package:flutter/src/material/bottom_navigation_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';

final player2 = AssetsAudioPlayer.withId('1');

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String greeting = '';
  void initState() {
    favoriteFetch();
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
                  height: 140,
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
                        //textAlign:TextAlign.start ,
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 10,
                // ),

                //-----------------------YOURS FAVORITE----------------------------------------
                yoursFavorite(),

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
                        //textAlign:TextAlign.start ,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //----------------------------------------------------------------MUSIC LIST VIEW AREA-------------------------
            musicListview(),
          ]),
        ),
      ),
    );
  }

 Widget appbarfunction(BuildContext context,String name) {
    return AppBar(
      title:  Padding(
        padding: EdgeInsets.only(left: 10),
         child: Text(
          name,
          // 'Good Morning',
          // greeting,
        
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w300,
            fontFamily: 'Poppins',
            color: Color.fromARGB(255, 120, 120, 120),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 209, 209, 209),
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
          icon: Icon(
            Icons.settings,
            size: 30,
          ),
          padding: EdgeInsets.only(right: 20, top: 10),
          color: Color.fromARGB(255, 77, 76, 76),
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
    return Container(
      //height: MediaQuery.of(context).size.height - 450,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 10,
        ),
        //------------------------------------valueListenable----------------------------------------------------
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 5),
          itemCount: allSongs.length,
          itemBuilder: (context, index) {
            //-----------------------------------------PLAYING AREA------------------------------------------
            // log("iiiiiiiiiiiiiiiiikannappiiii");
            // print(mySongs.value.length);

            return GestureDetector(
              onTap: () async {
                recentadd(allSongs[index]);
                addMostlyPlayed(allSongs[index]);
                //  log("iiiiiiiiiiiiggggggggggggggggggiiiiikannappiiii");
                // player.open(Audio.file(allSongs[index].url!));
                //print(player2.getCurrentAudioArtist);
                playMusic(index, allSongs);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  playingList.add(Audio(allSongs[index].url!));
                  return PlayingScreen(song: allSongs[index]);
                }));
              },
              // child: MusicList(
              //   song: listofSongs[index].name ?? 'untitled',
              //   artist: listofSongs[index].artist ?? 'Unknown',
              //   id: listofSongs[index].id!,
              //   //-------------------------------------------try to clear the id null problem what if a null image will come
              // ),
              child: ListTile(
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
                              backgroundColor:
                                  Color.fromARGB(255, 198, 198, 198),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        if (!favorite.value
                                            .contains(allSongs[index])) {
                                          addToFav(allSongs[index].id as int);
                                        } else {
                                          removeFromFav(
                                              allSongs[index].id as int);
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: favorite.value
                                              .contains(allSongs[index])
                                          ? Text('Remove from favorite')
                                          : Text('Add to favorite')),
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

                                        //print(player.getCurrentAudioTitle);
                                      },
                                      icon: Icon(Icons.add),
                                      label: Text('Add to playlistt')),
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
                  builder: (context) => FavoriteScreen(),
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
                  builder: (context) => FavoriteScreen(),
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
                  builder: (context) => RecentlyScreen(),
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
        // SizedBox(width: 10,),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MostlyPlayedScreen(),
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
// class MusicPlayerWidget extends StatelessWidget {
//   final String greeting;

//   MusicPlayerWidget({required this.greeting});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           greeting,
//           style: TextStyle(fontSize: 24),
//         ),
//         // Add your music player widget code here
//       ],
//     );
//   }
// }
