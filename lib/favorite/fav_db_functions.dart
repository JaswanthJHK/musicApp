

// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:music_ui/favorite/favorite_model.dart';
import 'package:music_ui/model/model.dart';
import 'package:music_ui/screens/splachScreen.dart';

List<Modelsong> favorite = [];

addToFav(int id) async {
  final favDb = await Hive.openBox<FavoriteModel>("fav_db");
  await favDb.put(id, FavoriteModel(id: id));
  for (var elements in allSongs) {
    if (elements.id == id) {
      favorite.add(elements);
    }
  }
  // ignore: invalid_use_of_protected_member
 // favorite.notifyListeners();
}

removeFromFav(int id) async {
  final favDb = await Hive.openBox<FavoriteModel>('fav_db');
  await favDb.delete(id);
  for (var elements in allSongs) {
    if (elements.id == id) {
      favorite.remove(elements);
    }
  }
  //favorite.notifyListeners();
}
