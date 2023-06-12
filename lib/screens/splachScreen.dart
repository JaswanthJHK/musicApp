import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_ui/All_Songs/allSongs_functon.dart';
import 'package:music_ui/favorite/fav_db_functions.dart';
import 'package:music_ui/favorite/favorite_model.dart';

import 'package:music_ui/model/model.dart';
import 'package:music_ui/screens/bottomnav.dart';
import 'package:music_ui/screens/objectsFuncton.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

//List<Modelsong> listofSongs = [];
List<Modelsong> allSongs = allSongsDB.values.toList();

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SongFetch fetching = SongFetch();
    fetching.fetching();
    super.initState();
    gotohome();
  }

  gotohome() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNav(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 31, 28),
      body: Center(
        child: Container(
            child: const Image(
                image: AssetImage('assets/image/Splash_Image.png'))),
      ),
    );
  }
}

class SongFetch {
  permisionRequest() async {
    // check android version here working
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
        if (element.fileExtension == "mp3"&&!allSongsDB.values.contains(element.id)) {
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
  }

  favoriteFetch() async {
    List<FavoriteModel> favSongCheck = [];
    Box<FavoriteModel> favdb = await Hive.openBox('Fav_db');
    favSongCheck.addAll(favdb.values);
    for (var favs in favSongCheck) {
      int count = 0;
      for (var songs in allSongs) {
        if (favs.id == songs.id) {
          // favorite function that created in fav_db_function
          favorite.value.insert(0, songs);
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
}
