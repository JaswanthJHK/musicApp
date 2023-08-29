import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_ui/All_Songs/allSongs_functon.dart';
import 'package:music_ui/applications/nav_bloc/nav_bloc_bloc.dart';
import 'package:music_ui/applications/playlist_bloc/play_list_bloc_bloc.dart';
import 'package:music_ui/applications/recent_bloc/recent_bloc_bloc.dart';
import 'package:music_ui/applications/search_bloc/search_bloc_bloc.dart';
import 'package:music_ui/favorite/favorite_model.dart';
import 'package:music_ui/function/playlist/playlist_model.dart';
import 'package:music_ui/model/model.dart';
import 'package:music_ui/screens/splachScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'applications/MostlyBloc/bloc/mostly_bloc_bloc.dart';
import 'applications/favorite_bloc/bloc/favorite_bloc.dart';

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
  runApp(const MyScreen());
}

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoriteBloc>(
          create: (context) => FavoriteBloc(),
        ),
        BlocProvider<MostBloc>(
          create: (context) => MostBloc(),
        ),
        BlocProvider<RecentlyBloc>(
          create: (context) => RecentlyBloc(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<PlayListBloc>(
          create: (context) => PlayListBloc(),
        ),
        BlocProvider<NavBloc>(
          create: (context) => NavBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomSheetTheme:
              const BottomSheetThemeData(backgroundColor: Colors.transparent),
          primarySwatch: Colors.grey,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
