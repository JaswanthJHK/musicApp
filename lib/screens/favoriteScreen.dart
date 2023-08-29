import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_ui/favorite/fav_db_functions.dart';
import 'package:music_ui/function/currentPlaying.dart';
import 'package:music_ui/recently/recentlyPlayed.dart';
import 'package:music_ui/screens/musicPlaying.dart';
import 'package:music_ui/screens/splachScreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../applications/favorite_bloc/bloc/favorite_bloc.dart';
import '../function/mostlyPlayed/mostlyPlayed_function.dart';
import 'addtoplaylist.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});


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
                height: 70,
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
                          padding: EdgeInsets.only(right: 135),
                          child: Text(
                            'Favorites',
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
                  child: BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 5),
                        itemCount: favorite.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                               recentadd(allSongs[index]);
                               addMostlyPlayed(allSongs[index]);

                              playMusic(index, favorite);

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
                                id: state.favoriteBloc[index].id!,
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
                                state.favoriteBloc[index].name!,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    color: Colors.grey[100],
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Text(
                                state.favoriteBloc[index].artist ?? 'unknown',
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
                                            backgroundColor: const Color.fromARGB(
                                                255, 198, 198, 198),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {context.read<FavoriteBloc>().add(removeFromFavBloc(id:favorite
                                                          [index]
                                                          .id as int));
                                                     
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                        'Remove from favorite')),
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
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
