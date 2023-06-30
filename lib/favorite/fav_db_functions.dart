import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:music_ui/favorite/favorite_model.dart';
import 'package:music_ui/model/model.dart';
import 'package:music_ui/screens/splachScreen.dart';

ValueNotifier<List<Modelsong>> favorite = ValueNotifier([]);

addToFav(int id) async {
  final favDb = await Hive.openBox<FavoriteModel>("fav_db");
  await favDb.put(id, FavoriteModel(id: id));
  for (var elements in allSongs) {
    if (elements.id == id) {
      favorite.value.add(elements);
    }
  }
  favorite.notifyListeners();
}

Future<void> removeFromFav(int id) async {
  final favDb = await Hive.openBox<FavoriteModel>('fav_db');
  await favDb.delete(id);
  for (var elements in allSongs) {
    if (elements.id == id) {
      favorite.value.remove(elements);
    }
  }
  favorite.notifyListeners();
}
