import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_ui/function/playlist/playlist_funcion.dart';
import 'package:music_ui/model/model.dart';
import 'package:music_ui/screens/homeScreen.dart';

class addingToPlaylist extends StatefulWidget {
  final Modelsong music;
  const addingToPlaylist({required this.music, super.key});

  @override
  State<addingToPlaylist> createState() => _addingToPlaylistState();
}

class _addingToPlaylistState extends State<addingToPlaylist> {
  TextEditingController playlist = TextEditingController();
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
                          padding: EdgeInsets.only(right: 96),
                          child: Text(
                            'Your Playlistsss',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 15),
                        //   child: IconButton(
                        //     onPressed: () {

                        //     },
                        //     icon: Icon(Icons.add),
                        //     iconSize: 30,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListTile(
                    title: Text(
                      'PlayLists',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor:
                                  Color.fromARGB(255, 220, 220, 220),
                              title: Text('Add Name'),
                              content: TextField(
                                controller: playlist,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Playlist Name',
                                ),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                      
                                        addPlaylist(playlist.text);
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text('OK'))
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.add),
                      color: Color.fromARGB(255, 182, 182, 182),
                      iconSize: 30,
                    )),
              ),
              Expanded(
                // child: ValueListenableBuilder(
                //   valueListenable: playlistNotifier,
                //   builder: (context, value, child) {
                //     return ListView.builder(
                //       itemCount: playlistNotifier.value.length,
                //       itemBuilder: (context, index) {
                //         return Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Card(
                //             color: Color.fromARGB(255, 163, 163, 163),
                //             child: InkWell(
                // onTap: () {
                //   addsongToPlaylist(
                //       music, playlistNotifier.value[index].name);
                //   playlistNotifier.value[index].playlistSongs
                //       .add(music);
                //   Navigator.pop(context);
                // },
                //               child: ListTile(
                //                 title: Text(playlistNotifier.value[index].name),
                //               ),
                //             ),
                //           ),
                //         );
                //       },
                //     );
                //   },
                // ),

                child: ValueListenableBuilder(
                  valueListenable: playlistNotifier,
                  builder: (context, value, child) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: GridView.count(
                        padding: EdgeInsets.only(top: 10),
                        crossAxisCount: 2,
                        crossAxisSpacing: 25,
                        mainAxisSpacing: 10,
                        children: List.generate(playlistNotifier.value.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: GestureDetector(
                              onTap: () {//------------------------------------------------------------same song checking--------------
                                if (!playlistNotifier.value[index].playlistSongs
                              .contains(widget.music)) {
                            playlistNotifier.value[index].playlistSongs
                                .insert(0, widget.music);
                            addsongToPlaylist(widget.music,
                                playlistNotifier.value[index].name);
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Center(child: const Text('Song Added')),
                              backgroundColor: const Color.fromARGB(255, 104, 104, 104),
                              duration: const Duration(seconds: 1),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Center(child: const Text('Song Alredy Present',style:TextStyle(color: Color.fromARGB(255, 0, 0, 0)),)),
                              backgroundColor: const Color.fromARGB(255, 161, 161, 161),
                            ));
                          }



                                addsongToPlaylist(widget.music,
                                    playlistNotifier.value[index].name);
                                playlistNotifier.value[index].playlistSongs
                                    .add(widget.music);
                                Navigator.pop(context);
                              },
                              child: Container(
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  color: Color.fromARGB(255, 93, 93, 93),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topRight: Radius.circular(25),
                                              topLeft: Radius.circular(25)),
                                          child: Image.asset(
                                            'assets/image/favorite.png',
                                            height: 89,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          )),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Text(
                                                playlistNotifier
                                                    .value[index].name,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
