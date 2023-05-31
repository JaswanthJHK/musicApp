import 'package:flutter/material.dart';
import 'package:music_ui/screens/homeScreen.dart';
import 'package:music_ui/screens/playlist.dart';
import 'package:music_ui/screens/search.dart';

class BottomNav extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<BottomNav> {
  int _currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    PlaylistScreen(),
    
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
        body: IndexedStack(children: screens,index: _currentIndex,
          
        ),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[700],
          currentIndex: _currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onTabTapped,
          items: const [
             BottomNavigationBarItem(
              icon: Icon(Icons.home,
              color: Colors.black,
              size: 30,),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search,
              color: Colors.black,
              size: 30,),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.playlist_add,
              color: Colors.black,
              size: 30,),
              label: '',
            ),
          ],
        ),
      
    );
  }
}
