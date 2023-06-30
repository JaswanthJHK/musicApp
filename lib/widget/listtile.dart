// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:music_ui/screens/musicPlaying.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class MusicList extends StatefulWidget {
//   String song;
//   String artist;
//   int id;

//   MusicList({
//     super.key,
//     required this.song,
//     required this.artist,
//     required this.id
//   });

//   @override
//   State<MusicList> createState() => _MusicListState();
// }

// class _MusicListState extends State<MusicList> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(),
// child: ListTile(
//   leading: QueryArtworkWidget(
//     // width: 50,
//     // height: 50,
//     // decoration: BoxDecoration(
//     //   borderRadius: BorderRadius.circular(8),
//     //   border: Border.all(
//     //       color: Color.fromARGB(255, 230, 230, 230), width: 3),
//     //   image: DecorationImage(
//     //     fit: BoxFit.cover,
//     //     image: AssetImage(
//     //       'assets/image/Music3.png',
//     //     ),
//     //   ),
//     // ),

//     artworkFit: BoxFit.cover,
//     id: widget.id!,
//     type: ArtworkType.AUDIO,
//     artworkQuality: FilterQuality.high,
//     size: 2000,
//     quality: 100,
//     artworkBorder: BorderRadius.circular(50),
//     nullArtworkWidget: ClipRRect(
//       borderRadius: const BorderRadius.all(Radius.circular(50)),
//       child: Image.asset(
//         'assets/Music Brand and App Logo (1).png',
//         fit: BoxFit.cover,
//       ),
//     ),
//   ),
//   title: Text(
//     widget.song,
//     overflow: TextOverflow.ellipsis,
//     style: TextStyle(
//         fontFamily: 'OpenSans',
//         color: Colors.grey[100],
//         fontSize: 16,
//         fontWeight: FontWeight.w500),
//   ),
//   subtitle: Text(
//     widget.artist,
//     overflow: TextOverflow.ellipsis,
//     style: TextStyle(
//         color: Colors.grey[100],
//         fontSize: 12,
//         fontWeight: FontWeight.w300),
//   ),
//   // trailing: Icon(
//   //   Icons.more_vert,
//   //   color: Colors.grey[100],
//   // ),
//   trailing: IconButton(
//       onPressed: () {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//                 backgroundColor: Color.fromARGB(255, 198, 198, 198),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     ElevatedButton.icon(
//                         onPressed: () {},
//                         icon: Icon(Icons.add),
//                         label: Text('Add to favorite')),
//                     ElevatedButton.icon(
//                         onPressed: () {},
//                         icon: Icon(Icons.add),
//                         label: Text('Add to playlist')),
//                   ],
//                 ));
//           },
//         );
//       },
//       icon: Icon(
//         Icons.more_vert,
//         color: Color.fromARGB(255, 217, 217, 217),
//       )),
//       // ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:music_ui/model/model.dart';
// import 'package:music_ui/recently/recentlyPlayed.dart';

// ValueNotifier<List<Modelsong>> recentlist = ValueNotifier([]);

// recentadding(Modelsong song) async {
//   Box<int> recentDb = await Hive.openBox('recent');
//   List<int> temp = [];
//   temp.addAll(recentDb.values);
//   if (recentList.value.contains(song)) {
//     recentList.value.remove(song);
//     recentList.value.insert(0, song);

//     for (int i = 0; i < temp.length; i++) {
//       if (temp[i] == song.id) {
//         recentDb.deleteAt(i);
//         recentDb.add(song.id!);
//       }
//     }
//   } else {
//     recentList.value.insert(0, song);
//     recentDb.add(song.id!);
//   }
//   if (recentList.value.length > 10) {
//     recentList.value = recentList.value.sublist(0, 10);
//     recentDb.deleteAt(0);
//   }
// }

