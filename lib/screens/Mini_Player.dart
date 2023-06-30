import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music_ui/recently/recentlyPlayed.dart';
import 'package:music_ui/screens/musicPlaying.dart';
// import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'objectsFuncton.dart';
// import 'package:project_music_player/Global_Files/Global_Files.dart';
// import 'package:project_music_player/Screens/MainPlayer.dart';

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
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 175, 175, 175),
            ),
            height: 80,
            width: double.infinity,
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return PlayingScreen();
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
                            color:  Color.fromARGB(255, 68, 68, 68),
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
                          color:  Color.fromARGB(255, 68, 68, 68),
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
