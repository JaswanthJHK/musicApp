import 'package:flutter/material.dart';
import 'package:music_ui/All_Songs/allSongs_functon.dart';
import 'package:music_ui/favorite/favorite_model.dart';
import 'package:music_ui/function/playlist/playlist_model.dart';
import 'package:music_ui/model/model.dart';
import 'package:music_ui/screens/splachScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(ModelsongAdapter().typeId)) {
    Hive.registerAdapter(ModelsongAdapter());
  }
  if (!Hive.isAdapterRegistered(FavoriteModelAdapter().typeId)) {
    Hive.registerAdapter(FavoriteModelAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayListModelAdapter().typeId)) {
    Hive.registerAdapter(PlayListModelAdapter());
  }

  await openAllSongs();
  runApp(MyScreen());
}

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.transparent),
        primarySwatch: Colors.grey,
      ),
      home: SplashScreen(),
    );
  }
}
