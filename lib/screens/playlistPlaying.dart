import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_ui/widget/listTile3.dart';

class PlaylistPlaying extends StatelessWidget {
  PlaylistPlaying({super.key});
  List<String> list = [
        'Music 1',
        'Music 2',
        'Music 3',
        'Music 4',
        'Music 5',
  ];

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
                        padding: EdgeInsets.only(right: 143),
                        child: Text(
                          'Playlist',
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
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 5),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return PlaylistMusic (song: list[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
