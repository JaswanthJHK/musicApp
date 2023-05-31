import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_ui/screens/splachScreen.dart';

import '../model/model.dart';

ValueNotifier<List<Modelsong>> mySongs = ValueNotifier([]);

addSongs() async {
  final songDB = await Hive.openBox<Modelsong>('songs');
  for (var element in listofSongs) {
    songDB.add(Modelsong(
        name: element.name,
        artist: element.artist,
        duration: element.duration,
        id: element.id,
        url: element.url));
  }
  mySongs.value.addAll(songDB.values);
  mySongs.notifyListeners();
  print(mySongs.value.length);
}

getAll() async {
  final songDB = await Hive.openBox<Modelsong>('songs');
  mySongs.value.addAll(songDB.values);
  mySongs.notifyListeners();
}
