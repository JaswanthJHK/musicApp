
// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:music_ui/function/playlist/playlist_funcion.dart';
import 'package:music_ui/screens/favoriteScreen.dart';
import 'package:music_ui/screens/playlistPlaying.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  TextEditingController playList = TextEditingController();
  TextEditingController editname = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final playlistkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int containerIndex;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 141, 141, 141),
                Color.fromARGB(255, 65, 65, 65)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 60,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 94, 94, 94),
                            Color.fromARGB(255, 35, 35, 35)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 10, left: 120),
                    child: Text(
                      'My Library',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  width: 370,
                  height: 59,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 95, 95, 95),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoriteScreen(),
                          ));
                    },
                    child: ListTile(
                      title: const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Favorite Tracks',
                          style: TextStyle(
                              fontSize: 25,
                              color: Color.fromARGB(255, 212, 212, 212),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FavoriteScreen(),
                              ));
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromARGB(255, 212, 212, 212),
                          size: 20,
                        ),
                      ),
                      //leading: Icon(Icons.favorite_border_outlined,color:  Color.fromARGB(255, 212, 212, 212),),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 30,
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  child: ListTile(
                      title: const Text(
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
                                    const Color.fromARGB(255, 220, 220, 220),
                                title: const Text('Add Name'),
                                content: Form(
                                  key: playlistkey,
                                  child: TextFormField(
                                    controller: playList,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Please add a Name';
                                      } else if (playList.text.length > 7) {
                                        return 'Name should be lesthan 7 letters';
                                      } else if (playlistNotifier.value.any(
                                          (playlist) =>
                                              playlist.name == playList.text)) {
                                        return 'Name already exists';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      border:
                                          OutlineInputBorder(), //------------------------------------------------
                                      hintText: 'Playlist Name',
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        // setState(() {
                                        //   addPlaylist(playlist.text);
                                        // });
                                        if (playlistkey.currentState!
                                            .validate()) {
                                          addPlaylist(playList.text);
                                          playList.clear();
                                          Navigator.pop(context);
                                        }
                                        
                                      },
                                      child: const Text('OK'))
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.add),
                        color: const Color.fromARGB(255, 182, 182, 182),
                        iconSize: 30,
                      )),
                ),
                SizedBox(
                  width: 330, // Set the desired width of the container
                  height: 450, // Set the desired height of the container
                  child: ValueListenableBuilder(
                    valueListenable: playlistNotifier,
                    builder: (context, value, child) {
                      if (playlistNotifier.value.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'No Playlist has creatd',
                              style: TextStyle(
                                  color:
                                      Color.fromARGB(255, 138, 137, 137),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      }

                      return GridView.count(
                        padding: const EdgeInsets.only(top: 10),
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 0,
                        children: List.generate(playlistNotifier.value.length,
                            (index) {
                          containerIndex = index;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlaylistPlaying(
                                          currentPlayListindex:
                                              playlistNotifier.value[index],
                                          indexoflist: index),
                                    ));
                              },
                              child: SizedBox(
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  color: const Color.fromARGB(255, 93, 93, 93),
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
                                      SizedBox(
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
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                          const Color.fromARGB(255,
                                                              198, 198, 198),
                                                      content: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          ElevatedButton.icon(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return AlertDialog(
                                                                        title: const Text(
                                                                            'DELETE'),
                                                                        content:
                                                                            const Text('Are sure you want to Delete this playlist?'),
                                                                        actions: [
                                                                          TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              setState(() {
                                                                                deletePlaylist(index);
                                                                              });
                                                                              Navigator.of(context).pop();
                                                                              // Navigator.popUntil(context, (route) => )
                                                                            },
                                                                            child:
                                                                                const Text('yes'),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    });
                                                              },
                                                              icon: const Icon(Icons
                                                                  .remove_circle_outline),
                                                              label: const Text(
                                                                  'Delete this PlayList')),
                                                          ElevatedButton.icon(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return AlertDialog(
                                                                      title: const Text(
                                                                          'EDIT'),
                                                                      content:
                                                                          Form(
                                                                        key:
                                                                            formkey,
                                                                        child:
                                                                            TextFormField(
                                                                          controller:
                                                                              editname,
                                                                          // initialValue: playlistNotifier.value[index].name,
                                                                          validator:
                                                                              (value) {
                                                                            if (value == null ||
                                                                                value.trim().isEmpty) {
                                                                              return 'please enter something';
                                                                            } else if (editname.text.length > 7) {
                                                                              return 'name should be less than 7 letters..! ';
                                                                            } else if (playlistNotifier.value.any((playlist) => playlist.name == editname.text)) {
                                                                              return 'Same name exists';
                                                                            }
                                                                            return null;
                                                                          },
                                                                    
                                                                          decoration:
                                                                              const InputDecoration(
                                                                            border:
                                                                                OutlineInputBorder(),
                                                                            hintText:
                                                                                'Playlist Name',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      actions: [
                                                                        TextButton(
                                                                          onPressed:
                                                                              () {
                                                                            if (formkey.currentState!.validate()) {
                                                                              updateNamePlaylist(editname.text, index);
                                                                              editname.clear();
                                                                              Navigator.pop(context);
                                                                            }
                                                                          },
                                                                          child:
                                                                              const Text('yes'),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  });
                                                            },
                                                            icon: const Icon(Icons
                                                                .remove_circle_outline),
                                                            label: const Text(
                                                                '  Edit this PlayList  '),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              icon: const Icon(Icons.more_vert),
                                              color: const Color.fromARGB(
                                                  255, 219, 219, 219),
                                              iconSize: 20,
                                            )
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
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
