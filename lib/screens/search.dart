import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_ui/function/currentPlaying.dart';
import 'package:music_ui/model/model.dart';
import 'package:music_ui/screens/musicPlaying.dart';
import 'package:music_ui/screens/splachScreen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Modelsong> searchSongs = List.from(allSongs);

  final SearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 107, 107, 107),
            Color.fromARGB(255, 46, 46, 46)
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
                    Color.fromARGB(255, 46, 46, 46)
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              child: const Padding(
                padding: EdgeInsets.only(top: 10, left: 140),
                child: Text(
                  'Search',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 30,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              // child: TextField(
              //   style: TextStyle(
              //     fontSize: 10.0,
              //     color: Color.fromARGB(255, 125, 120, 119),
              //   ),
              //   decoration: InputDecoration(

              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       borderSide: BorderSide.none
              //     ),

              //     fillColor: Colors.white.withOpacity(.3),
              //     filled: true,
              //     prefixIcon: Icon(Icons.search,size: 30,color: Colors.black,),
              //     suffixIcon: Icon(Icons.clear,size: 30,color: Color.fromARGB(255, 201, 201, 201),),
              //     labelText: 'Search songs . . .',
              //     labelStyle: TextStyle(
              //       color: Color.fromARGB(255, 211, 211, 211),
              //       fontSize: 18.0,
              //       fontFamily:'OpenSans'
              //     ),
              //   ),
              // ),
              child: TextFormField(
                controller: SearchController,
                onChanged: (value) {
                  search(SearchController.text);
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    filled: true,
                    fillColor: Colors.grey,
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                          width: 0,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Search your song here'),
              ),
            ),

            //----------------------------------------------------------------------------------------------------------

            SizedBox(
              height: 20,
            ),

            Expanded(
              child: searchSongs.isEmpty
                  ? const Center(child: Text('Not found'))
                  : ListView.builder(
                      physics:
                          const ScrollPhysics(parent: BouncingScrollPhysics()),
                      padding: EdgeInsets.only(top: 20),
                      itemCount: searchSongs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            playMusic(index, searchSongs);
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return PlayingScreen();
                              },
                            ));
                          },
                          child: ListTile(
                            leading: QueryArtworkWidget(
                              artworkWidth: 30,
                              artworkHeight: 30,
                              artworkFit: BoxFit.cover,
                              id: allSongs[index].id!,
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
                              searchSongs[index].name!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  color: Colors.grey[100],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(
                              searchSongs[index].artist ?? 'unknown',
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

                            //------------------------------------------------------trailing--------------------
                            // trailing: IconButton(
                            //     onPressed: () {
                            //       showDialog(
                            //         context: context,
                            //         builder: (context) {
                            //           return AlertDialog(
                            //               backgroundColor: Color.fromARGB(
                            //                   255, 198, 198, 198),
                            //               content: Column(
                            //                 mainAxisSize: MainAxisSize.min,
                            //                 children: [
                            //                   ElevatedButton(
                            //                       onPressed: () {
                            //                         removeFromFav(favorite
                            //                             .value[index]
                            //                             .id as int);

                            //                         Navigator.pop(context);
                            //                       },
                            //                       child: Text(
                            //                           'Remove from favorite')),
                            //                   ElevatedButton.icon(
                            //                       onPressed: () {},
                            //                       icon: Icon(Icons.add),
                            //                       label: Text(
                            //                           'Add to playlist')),
                            //                 ],
                            //               ));
                            //         },
                            //       );
                            //     },
                            //     icon: Icon(
                            //       Icons.more_vert,
                            //       color: Color.fromARGB(255, 217, 217, 217),
                            //     )),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    ));
  }

  search(String value) {
    setState(() {
      searchSongs = allSongs
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase().trim()))
          .toList();
      // for (SongDetails elements in searchSong) {
      //   allSongIn.add(Audio.file(elements.url.toString(),
      //       metas: Metas(title: elements.name, id: elements.id.toString())));
      // }
    });
  }
}
