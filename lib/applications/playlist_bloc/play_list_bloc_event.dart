part of 'play_list_bloc_bloc.dart';

class PlayListEvent {}

class PlaylistAdd extends PlayListEvent {
  String newname;
  PlaylistAdd({required this.newname});
}

class PlaylistDelete extends PlayListEvent {
  int playlistIndex;
  PlaylistDelete({required this.playlistIndex});
}

class PlaylistRename extends PlayListEvent {
  int playlistIndex;
  String newname;
  PlaylistRename({required this.playlistIndex,required this.newname});
}


class PlaylistSongAdd extends PlayListEvent {
  Modelsong song;
  String name;
PlaylistSongAdd({required this.song,required this.name});
}

class PlaylistRemoveSong extends PlayListEvent {
  Modelsong song;
  String name;
PlaylistRemoveSong({required this.song,required this.name});
}

class PlaylistFetch extends PlayListEvent{
  
}