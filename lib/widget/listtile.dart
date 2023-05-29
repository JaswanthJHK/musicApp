import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_ui/screens/musicPlaying.dart';

class MusicList extends StatefulWidget {
  String song;
  String artist;

  MusicList({
    super.key,
    required this.song,
    required this.artist,
  });

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => (PlayingScreen()),
              ));
        },
        child: ListTile(
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: Color.fromARGB(255, 230, 230, 230), width: 3),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  'assets/image/Music3.png',
                ),
              ),
            ),
          ),
          title: Text(
            widget.song,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontFamily: 'OpenSans',
                color: Colors.grey[100],
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            widget.artist,
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
          trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        backgroundColor: Color.fromARGB(255, 198, 198, 198),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.add),
                                label: Text('Add to favorite')),
                            ElevatedButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.add),
                                label: Text('Add to playlist')),
                          ],
                        ));
                  },
                );
              },
              icon: Icon(
                Icons.more_vert,
                color: Color.fromARGB(255, 217, 217, 217),
              )),
        ),
      ),
    );
  }
}
