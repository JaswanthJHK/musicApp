import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_ui/function/allSongs.dart';
import 'package:music_ui/function/currentPlaying.dart';
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

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  // List<String> list = [
  //   'song 1',
  //   'song 2',
  //   'song 3',
  //   'song 4',
  //   'song 5',
  //   'song 6',
  //   'song 7',
  //   'song 8'
  // ];

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

            appbarfunction(context),
            Column(
              children: [
                Container(
                  height: 130,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 209, 209, 209),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: const [
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

                Row(
                  children: const [
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
            //---------------------------------------------------------------------------------
            musicListview(),
          ]),
        ),
      ),
    );
  }

  appbarfunction(context) {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(left: 10),
        child: Text(
          'Good Morning',
          style: TextStyle(
            fontSize: 35,
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
        child: ValueListenableBuilder(
          valueListenable: mySongs,
          builder: (context, value, child) {
            return ListView.builder(
               physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 5),
              itemCount: listofSongs.length,
              itemBuilder: (context, index) {
                //-----------------------------------------PLAYING AREA------------------------------------------
                log("iiiiiiiiiiiiiiiiikannappiiii");
                print(mySongs.value.length);

                return GestureDetector(
                  onTap: () async {
                    log("iiiiiiiiiiiiggggggggggggggggggiiiiikannappiiii");
                    player.open(Audio.file(listofSongs[index].url!));

                    await playMusic(index, listofSongs);

                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      playingList.add(Audio(listofSongs[index].url!));
                      return PlayingScreen();
                    }));
                  },
                  // child: MusicList(
                  //   song: listofSongs[index].name ?? 'untitled',
                  //   artist: listofSongs[index].artist ?? 'Unknown',
                  //   id: listofSongs[index].id!,
                  //   //-------------------------------------------try to clear the id null problem what if a null image will come
                  // ),
                  child: ListTile(
                    leading: Container(
                      width: 49,height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color.fromARGB(255, 226, 226, 226),
                          width: 2,
                        ),
                        color: Colors.white
                      ),
                      child: QueryArtworkWidget(
                        // width: 50,
                        // height: 50,
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(8),
                        //   border: Border.all(
                        //       color: Color.fromARGB(255, 230, 230, 230), width: 3),
                        //   image: DecorationImage(
                        //     fit: BoxFit.cover,
                        //     image: AssetImage(
                        //       'assets/image/Music3.png',
                        //     ),
                        //   ),
                        // ),
                    
                        artworkFit: BoxFit.cover,
                        id: listofSongs[index].id!,
                        type: ArtworkType.AUDIO,
                        artworkQuality: FilterQuality.high,
                        size: 10,
                        quality: 100,
                        artworkBorder: BorderRadius.circular(60),
                        nullArtworkWidget: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8),),
                          child: Image.asset(
                            'assets/image/Music3.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      listofSongs[index].name!,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          color: Colors.grey[100],
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      listofSongs[index].artist ?? 'unknown',
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
                                      ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: Icon(Icons.add),
                                          label: Text('Add to favorite')),
                                      ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: Icon(Icons.add),
                                          label: Text('Add to playlist')),
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
            width: 180,
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
