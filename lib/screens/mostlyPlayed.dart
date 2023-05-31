import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../widget/listtile.dart';

class MostlyPlayedScreen extends StatelessWidget {
   MostlyPlayedScreen({super.key});
  List<String> list = [
    'song 1',
    'song 2',
    'song 3',
    'song 4',
    'song 5',
    'song 6',
    'song 7',
    
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
                  padding: EdgeInsets.only(top: 0, left: 10),
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
                          padding: EdgeInsets.only(right: 100),
                          child: Text(
                            'Mostly played',
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
                // return MusicList(song: list[index],artist:list[index],);
              },
            ),
          ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}
