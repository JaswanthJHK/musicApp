import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

import 'package:music_ui/screens/objectsFuncton.dart';

class PlayingScreen extends StatefulWidget {
  PlayingScreen({
    super.key,
  });

  @override
  State<PlayingScreen> createState() => _PlayingScreenState();
}

class _PlayingScreenState extends State<PlayingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 112, 112, 112),
                Color.fromARGB(255, 72, 72, 72)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: player.builderCurrent(
              builder: (context, playing) {
                return Column(
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
                                padding: EdgeInsets.only(right: 110),
                                child: Text(
                                  'Now Playing',
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
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 320,
                      width: 300,
                    
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage('assets/image/playing.png')),
                        color: Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.grey[300],
                                size: 30,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.add,
                                color: Colors.grey[300],
                                size: 35,
                              )),
                        ],
                      ),
                    ),

                    //-----------------------------------PROGRESS BAR--------------------------------------------------------------

                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: PlayerBuilder.realtimePlayingInfos(
                          player: player,
                          builder: (context, realtimePlayingInfos) {
                            final duration =
                                realtimePlayingInfos.current!.audio.duration;

                            final position =
                                realtimePlayingInfos.currentPosition;
                            return ProgressBar(
                              progress: position,
                              total: duration,
                              timeLabelPadding: 15,
                              timeLabelTextStyle:
                                  const TextStyle(color: Colors.white),
                              thumbColor: Color.fromARGB(255, 49, 49, 49),
                              progressBarColor: Color.fromARGB(255, 44, 44, 44),
                              baseBarColor: Colors.grey[400],
                              onSeek: (duration) => player.seek(duration),
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () async {
                                await player.previous(keepLoopMode: true);
                              },
                              icon: Icon(
                                Icons.skip_previous_outlined,
                                size: 40,
                              )),

                          IconButton(
                              onPressed: () async {
                                await player
                                    .seekBy(const Duration(seconds: -10));
                              },
                              icon: Icon(
                                Icons.replay_10,
                                size: 40,
                              )),
                          // Container(
                          //   width: 70,
                          //   height: 70,
                          //   child: IconButton(
                          //       onPressed: () {
                          //         player.pause();
                          //       },
                          //       icon: Icon(
                          //         Icons.pause_circle_filled,
                          //         size: 70,
                          //       )),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 37, 37, 37),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: PlayerBuilder.isPlaying(
                                    player: player,
                                    builder: (context, isPlaying) {
                                      return IconButton(
                                        onPressed: () {
                                          player.playOrPause();
                                        },
                                        icon: Icon(isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow),
                                        iconSize: 40,
                                        color:
                                            Color.fromARGB(255, 133, 133, 133),
                                      );
                                    }),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () async {
                              //  print('seek pressed-------------------------------------------------------');
                                await player
                                    .seekBy(const Duration(seconds: 10));
                              },
                              icon: const Icon(
                                Icons.forward_10,
                                size: 40,
                              )),

                          IconButton(
                              onPressed: () async {
                                print('next pressed-----------------------------------------------------------------');
                                await player.next();
                              },
                              icon: const Icon(Icons.skip_next_outlined),
                              iconSize: 40)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.repeat)),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.shuffle)),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
            ),
      ),
    );
  }
}
