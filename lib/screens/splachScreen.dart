import 'package:flutter/material.dart';

import 'package:music_ui/model/model.dart';
import 'package:music_ui/screens/bottomnav.dart';
import 'package:music_ui/screens/objectsFuncton.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

List<Modelsong> listofSongs = [];

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    gotohome();
  }

  gotohome() async {
    SongFetch fetching = SongFetch();
    fetching.fetching();
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
        if (element.fileExtension == "mp3") {
          listofSongs.add(Modelsong(
              name: element.displayNameWOExt,
              artist: element.artist,
              duration: element.duration,
              id: element.id,
              url: element.uri));
        }
      }
    }
  }
}
