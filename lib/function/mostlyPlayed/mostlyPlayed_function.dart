import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:music_ui/model/model.dart';

ValueNotifier<List<Modelsong>> mostlyPLayedlist = ValueNotifier([]);

addMostlyPlayed(Modelsong song) async {
  Box<int> mostPlayedDB = await Hive.openBox('mostly_played');
  int count = (mostPlayedDB.get(song.id) ?? 0) + 1;
  mostPlayedDB.put(song.id, count);
  if (count > 3 && !mostlyPLayedlist.value.contains(song)) {
    mostlyPLayedlist.value.add(song);
  }

  if (mostlyPLayedlist.value.length > 10) {
    //kind of list that occur inside of a list that only take the value inside the sublist
    mostlyPLayedlist.value = mostlyPLayedlist.value.sublist(0, 10);
  }
}
