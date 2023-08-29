// ignore_for_file: file_names

import 'package:hive/hive.dart';
import 'package:music_ui/model/model.dart';

late Box<Modelsong> allSongsDB;
openAllSongs() async {
  allSongsDB = await Hive.openBox<Modelsong>('all_songs_DB');
  allSongsDB.clear();
}
