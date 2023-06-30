import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_ui/function/playlist/playlist_model.dart';
import 'package:music_ui/model/model.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'list_model.dart';

ValueNotifier<List<ListClass>> playlistNotifier = ValueNotifier([]);

addPlaylist(name) async {
  playlistNotifier.value.add(ListClass(name: name));
  Box<PlayListModel> playlistDB = await Hive.openBox('playlist_db');
  //-------------------
  if (playlistDB.values.contains(name)) {
    return 'add  another';
  } else {
    playlistDB.add(PlayListModel(playlistName: name));
  }
  playlistNotifier.notifyListeners();
}

deletePlaylist(int index) async {
  String deletingName = playlistNotifier.value[index].name;
  Box<PlayListModel> playlistDB = await Hive.openBox('playlist_db');
  for (PlayListModel element in playlistDB.values) {
    if (element.playlistName == deletingName) {
      playlistDB.delete(element.key);
      break;
    }
  }

  playlistNotifier.value.removeAt(index);
  playlistNotifier.notifyListeners();
}

addsongToPlaylist(Modelsong addingsong, String name) async {
  Box<PlayListModel> playlistDB = await Hive.openBox('playlist_db');
  for (PlayListModel element in playlistDB.values) {
    if (element.playlistName == name) {
      PlayListModel playlistUpdate = PlayListModel(playlistName: name);
      playlistUpdate.item.addAll(element.item);
      playlistUpdate.item.add(addingsong.id as int);
      playlistDB.put(element.key, playlistUpdate);
      break;
    }
  }
  playlistNotifier.notifyListeners();
}

romoveFromPlaylist(Modelsong removingSong, String name) async {
  Box<PlayListModel> playlistDB = await Hive.openBox('playlist_db');
  for (PlayListModel element in playlistDB.values) {
    if (element.playlistName == name) {
      PlayListModel playlistUpdate = PlayListModel(playlistName: name);
      for (int item in element.item) {
        if (item == removingSong.id) {
          continue;
        }
        playlistUpdate.item.add(item);
      }
      playlistDB.put(element.key, playlistUpdate);
      break;
    }
  }
  playlistNotifier.notifyListeners();
}

updateNamePlaylist(String name, int index) async {
  String playlistName = playlistNotifier.value[index].name;
  Box<PlayListModel> playlistDB = await Hive.openBox('playlist_db');
  for (PlayListModel elements in playlistDB.values) {
    if (elements.playlistName == playlistName) {
      elements.playlistName = name;
      playlistDB.put(elements.key, elements);
    }
  }
  playlistNotifier.value[index].name = name;
  playlistNotifier.notifyListeners();
  
  
}
