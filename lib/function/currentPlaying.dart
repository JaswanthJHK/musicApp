import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:music_ui/screens/splachScreen.dart';
import '../model/model.dart';
// import '../screens/homeScreen.dart';
import '../screens/objectsFuncton.dart';

// Modelsong? currentlyplaying;
// List<Audio> playinglistAudio = [];

// playAudio(List<Modelsong> songs, int index) async {
//   currentlyplaying = songs[index];
//   player.stop();
//   playinglistAudio.clear();

//   for (int i = 0; i < songs.length; i++) {
//     playinglistAudio.add(Audio.file(songs[i].url!,
//         metas: Metas(
//           title: songs[i].name,
//           artist: songs[i].artist,
//           id: songs[i].id.toString(),
//         ))  );
//   }
//   await player.open(
//       Playlist(
//         audios: playinglistAudio,
//         startIndex: index,
//       ),
//       showNotification: true,
//       notificationSettings: const NotificationSettings(stopEnabled: false));
//   player.setLoopMode(LoopMode.playlist);
// }

// currentlyplayingfinder(int? playingId) {
//   for (Modelsong song in listofSongs) {
//     if (song.id == playingId) {
//       currentlyplaying = song;
//       break;
//     }
//   }
// }

//----------------------------------------------------------------------

//List<Audio> convertToAudioList(List<dynamic> listofSongs) {
//Convertinh=g audio to embty list
//We can reusse this list becouse every separated list we
//create embty list so we add this function to add
//that file aseparatly
//   List<Audio> allSongsAudioList = [];

//   for (var x = 0; x < listofSongs.length; x++) {
//     allSongsAudioList.add(
//       Audio.file(
//        listofSongs[x].uri!,
//         metas: Metas(
//           title: listofSongs[x].displayName,
//           artist: listofSongs[x].artist,
//           id: listofSongs[x].id.toString(),
//         ),
//       ),
//     );
//   }
//   return allSongsAudioList;
// }
//----------------------------------------------------------music playing function

List<Audio> playingList = [];

playMusic(int index, List<Modelsong> songs) async {
  playingList.clear();
  for (var element in songs) {
    playingList.add(
      Audio.file(
        element.url!,
        metas: Metas(
          title: element.name,
          artist: element.artist,
          id: element.id.toString(),
        ),
      ),
    );
  }

  await player.open(
      Playlist(
        audios: playingList,
        startIndex: index,
      ),
      showNotification: true);
  player.setLoopMode(LoopMode.playlist);
}
