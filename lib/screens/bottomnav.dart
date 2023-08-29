import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_ui/screens/Mini_Player.dart';
import 'package:music_ui/screens/homeScreen.dart';
import 'package:music_ui/screens/playlist.dart';
import 'package:music_ui/screens/search.dart';

import '../applications/nav_bloc/nav_bloc_bloc.dart';

class BottomNav extends StatelessWidget {
  final int _currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    SearchScreen(),
    const PlaylistScreen(),
  ];

  BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBloc, NavState>(
      builder: (context, state) {
        return Scaffold(
          body: screens[state.navIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey[700],
            currentIndex: _currentIndex,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: (value) {
              BlocProvider.of<NavBloc>(context).add(NavEvent(index: value));
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 30,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 30,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.playlist_add,
                  color: Colors.black,
                  size: 30,
                ),
                label: '',
              ),
            ],
          ),
          bottomSheet: const MiniPlayer(),
        );
      },
    );
  }
}
