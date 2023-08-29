import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_ui/function/currentPlaying.dart';
import 'package:music_ui/model/model.dart';
import 'package:music_ui/screens/musicPlaying.dart';
import 'package:music_ui/screens/splachScreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../applications/search_bloc/search_bloc_bloc.dart';
import '../applications/search_bloc/search_bloc_state.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final List<Modelsong> searchSongs = List.from(allSongs);

  final TextEditingController searchController = TextEditingController();

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
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: TextFormField(
                controller: searchController,
                onChanged: (value) {
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchEvent(query: searchController.text));
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

            const SizedBox(
              height: 20,
            ),

            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return Expanded(
                  child: state.searchdata.isEmpty
                      ? const Center(
                          child: Text(
                          'Not found',
                          style: TextStyle(color: Colors.grey),
                        ))
                      : ListView.builder(
                          physics: const ScrollPhysics(
                              parent: BouncingScrollPhysics()),
                          padding: const EdgeInsets.only(top: 20),
                          itemCount: state.searchdata.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                playMusic(index, state.searchdata);
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return PlayingScreen(
                                      playingSong: state.searchdata[index],
                                    );
                                  },
                                ));
                              },
                              child: ListTile(
                                leading: QueryArtworkWidget(
                                  artworkWidth: 30,
                                  artworkHeight: 30,
                                  artworkFit: BoxFit.cover,
                                  id: state.searchdata[index].id!,
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
                                  state.searchdata[index].name!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      color: Colors.grey[100],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  state.searchdata[index].artist ?? 'unknown',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey[100],
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                            );
                          },
                        ),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
