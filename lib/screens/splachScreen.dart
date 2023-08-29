import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:music_ui/All_Songs/allSongs_functon.dart';
import 'package:music_ui/favorite/fav_db_functions.dart';
import 'package:music_ui/favorite/favorite_model.dart';
import 'package:music_ui/function/mostlyPlayed/mostlyPlayed_function.dart';
import 'package:music_ui/function/playlist/list_model.dart';
import 'package:music_ui/function/playlist/playlist_funcion.dart';

import 'package:music_ui/model/model.dart';
import 'package:music_ui/screens/bottomnav.dart';
import 'package:music_ui/screens/objectsFuncton.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

import '../applications/MostlyBloc/bloc/mostly_bloc_bloc.dart';
import '../applications/MostlyBloc/bloc/mostly_bloc_event.dart';
import '../applications/recent_bloc/recent_bloc_bloc.dart';
import '../function/playlist/playlist_model.dart';
import '../recently/recentlyPlayed.dart';

//List<Modelsong> listofSongs = [];
List<Modelsong> allSongs = allSongsDB.values.toList();

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    wait(context);
    return const Scaffold(
      backgroundColor: Color(0xFF101010),
      body: Padding(
        padding: EdgeInsets.only(top: 80),
        child: Center(
          child: SizedBox(
              child: Image(
                  image: AssetImage('assets/image/REAL-SONGVERSE-ICON.png'))),
        ),
      ),
    );
  }
}

wait(context) async {
  SongFetch fetch = SongFetch();
  await fetch.fetching();
  // BlocProvider.of<FavoriteBloc>(context).add(FavoriteEvent());
  BlocProvider.of<RecentlyBloc>(context).add(RecentFetch());
  BlocProvider.of<MostBloc>(context).add(MostPlayedFetch());
  Timer(const Duration(milliseconds: 1500), () {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => BottomNav(),
      ),
    );
  });
}

class SongFetch {
  permisionRequest() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  fetching() async {
    bool status = await permisionRequest();
    if (status) {
      List<SongModel> fetchsong = await audioquery.querySongs(
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
          uriType: UriType.EXTERNAL);

      for (SongModel element in fetchsong) {
        if (element.fileExtension == "mp3" &&
            !allSongsDB.values.contains(element.id)) {
          await allSongsDB.add(Modelsong(
              name: element.displayNameWOExt,
              artist: element.artist,
              duration: element.duration,
              id: element.id,
              url: element.uri));
        }
      }
    }
    // favorite songs fetching
    await favoriteFetch();
    await mostlyPlayedFetch();
    await playlistFetch();
    await recentfetch();
  }
}

favoriteFetch() async {
  favorite.clear();
  List<FavoriteModel> favSongCheck = [];
  Box<FavoriteModel> favdb = await Hive.openBox('fav_db');
  favSongCheck.addAll(favdb.values);
  for (var favs in favSongCheck) {
    int count = 0;
    for (var songs in allSongs) {
      if (favs.id == songs.id) {
        // favorite function that created in fav_db_function
        favorite.insert(0, songs);
        break;
      } else {
        count++;
      }
    }
    if (count == allSongs.length) {
      var key = favs.key;
      favdb.delete(key);
    }
  }
}

mostlyPlayedFetch() async {
  Box<int> mostPlayedDB = await Hive.openBox('mostly_played');
  if (mostPlayedDB.isEmpty) {
    for (Modelsong element in allSongs) {
      if (mostPlayedDB.containsKey(element)) {
        continue;
      } else {
        mostPlayedDB.put(element.id, 0);
      }
    }
  } else {
    for (int id in mostPlayedDB.keys) {
      int count = mostPlayedDB.get(id) ?? 0;
      if (count > 3) {
        for (Modelsong element in allSongs) {
          if (element.id == id) {
            mostlyPLayedlist.value.add(element);
            break;
          }
        }
      }
    }
    if (mostlyPLayedlist.value.length > 10) {
      mostlyPLayedlist.value = mostlyPLayedlist.value.sublist(0, 10);
    }
  }
}

playlistFetch() async {
  Box<PlayListModel> playlistDB = await Hive.openBox('playlist_db');
  for (PlayListModel element in playlistDB.values) {
    String listName = element.playlistName;
    ListClass fetchPlaylist = ListClass(name: listName);
    for (int id in element.item) {
      for (Modelsong songs in allSongs) {
        if (id == songs.id) {
          fetchPlaylist.playlistSongs.add(songs);
          break;
        }
      }
    }
    playlistNotifier.value.add(fetchPlaylist);
  }
}

recentfetch() async {
  Box<int> recentDb = await Hive.openBox('recent');
  List<Modelsong> recenttemp = [];
  for (int element in recentDb.values) {
    for (Modelsong song in allSongs) {
      if (element == song.id) {
        recenttemp.add(song);
        break;
      }
    }
  }
  recentList.value = recenttemp.reversed.toList();
}
