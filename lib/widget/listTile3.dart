import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:music_ui/screens/musicPlaying.dart';

class PlaylistMusic extends StatelessWidget {
  String song;
  PlaylistMusic({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
                border: Border.all(
                    color: Color.fromARGB(255, 228, 228, 228), width: 3),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1604795210696-13d11806284d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
                  ),
                ),
              ),
            ),
            title: Text(
              song,
              style: TextStyle(
                  color: Color.fromARGB(255, 228, 228, 228),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
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
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('REMOVE'),
                                            content: Text(
                                                'Are sure you want to remove this song?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Close'),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(Icons.remove_circle_outline),
                                  label: Text('Remove from PlayList')),
                              ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.add),
                                  label: Text('Add to other playlist    ')),
                              ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.add),
                                  label: Text('  Add to Favorite           ')),
                            ],
                          ));
                    },
                  );
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Color.fromARGB(255, 215, 215, 215),
                ))),
      ),
    );
  }
}
 