import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:music_ui/screens/musicPlaying.dart';
import 'package:music_ui/screens/splachScreen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../applications/MostlyBloc/bloc/mostly_bloc_bloc.dart';
import '../applications/MostlyBloc/bloc/mostly_bloc_event.dart';
import '../applications/recent_bloc/recent_bloc_bloc.dart';
import '../function/currentPlaying.dart';
import '../model/model.dart';
import 'objectsFuncton.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return player.builderCurrent(
      builder: (context, playing) {
        Modelsong? song;
        int id = int.parse(playing.audio.audio.metas.id!);
        currentlyplayingfinder(id);
        for (Modelsong element in allSongs) {
          if (element.id == id) {
            song = element;
          }
        }
        BlocProvider.of<RecentlyBloc>(context)
            .add(RecentAdd(song: song as Modelsong));
        BlocProvider.of<MostBloc>(context).add(MostPlayedAdd(song: song));
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 175, 175, 175),
            ),
            height: 80,
            width: double.infinity,
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return PlayingScreen(playingSong: currentlyplaying);
                  },
                ));
              },
              leading: QueryArtworkWidget(
                id: int.parse(playing.audio.audio.metas.id!),
                type: ArtworkType.AUDIO,
                nullArtworkWidget: const CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage('assets/image/playing.png')),
                artworkFit: BoxFit.fill,
              ),
              title: Marquee(
                text: player.getCurrentAudioTitle,
                blankSpace: 50,
                style: const TextStyle(color: Color.fromARGB(255, 56, 56, 56)),
              ),
              trailing: PlayerBuilder.isPlaying(
                player: player,
                builder: (context, isPlaying) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () async {
                            await player.previous();
                            setState(() {});
                            if (isPlaying == false) {
                              player.pause();
                            }
                          },
                          icon: const Icon(
                            Icons.skip_previous,
                            color: Color.fromARGB(255, 68, 68, 68),
                          )),
                      IconButton(
                          onPressed: () async {
                            await player.playOrPause();
                          },
                          icon: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: const Color.fromARGB(255, 68, 68, 68),
                          )),
                      IconButton(
                        onPressed: () async {
                          await player.next();
                          setState(() {});
                          if (isPlaying == false) {
                            player.pause();
                          }
                        },
                        icon: const Icon(
                          Icons.skip_next,
                          color: Color.fromARGB(255, 68, 68, 68),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
