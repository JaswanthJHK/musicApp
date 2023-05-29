import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_ui/screens/favoriteScreen.dart';
import 'package:music_ui/screens/playlistPlaying.dart';

class PlaylistScreen extends StatelessWidget {
  PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 141, 141, 141),
              Color.fromARGB(255, 65, 65, 65)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Column(children: [
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
                color: Color.fromARGB(255, 95, 95, 95),
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FavoriteScreen(),
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
                            builder: (context) => FavoriteScreen(),
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
                            backgroundColor: Color.fromARGB(255, 220, 220, 220),
                            title: Text('Add Name'),
                            content: TextField(
                             
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Playlist Name',
                              ),
                            ),
                             actions: [
                            TextButton(
                                onPressed: () {
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
                  )
                  ),
            ),
            Container(
                width: 330, // Set the desired width of the container
                height: 429, // Set the desired height of the container
                child: GridView.count(
                  padding: EdgeInsets.only(top: 10),
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 0,
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlaylistPlaying(),
                              ));
                        },
                        child: Container(
                          //margin: const EdgeInsets.only(left: 1, right: 1),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            color: Color.fromARGB(255, 93, 93, 93),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          "PlayList",
                                          style: TextStyle(
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
                                                      Color.fromARGB(
                                                          255, 198, 198, 198),
                                                  content: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      ElevatedButton.icon(
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return AlertDialog(
                                                                    title: Text(
                                                                        'DELETE'),
                                                                    content: Text(
                                                                        'Are sure you want to Delete this playlist?'),
                                                                    actions: [
                                                                      TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: Text(
                                                                            'Close'),
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                          },
                                                          icon: Icon(Icons
                                                              .remove_circle_outline),
                                                          label: Text(
                                                              'Delete this PlayList')),
                                                    ],
                                                  ));
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.more_vert),
                                        color: Color.fromARGB(255, 219, 219, 219),iconSize: 20,
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
                ))
          ]),
        ),
      ),
    );
  }
}
