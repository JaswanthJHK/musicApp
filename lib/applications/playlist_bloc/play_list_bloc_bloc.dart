import 'package:bloc/bloc.dart';
import 'package:music_ui/function/playlist/list_model.dart';
import 'package:music_ui/model/model.dart';
import '../../function/playlist/playlist_funcion.dart';
import '../../screens/splachScreen.dart';
part 'play_list_bloc_event.dart';
part 'play_list_bloc_state.dart';

class PlayListBloc extends Bloc<PlayListEvent, PlayListState> {
  PlayListBloc() : super(PlayListState(playlist: [])) {
    on<PlaylistFetch>((event, emit) async {
      List<ListClass> playlistdata = await playlistFetch();
      return emit(PlayListState(playlist: playlistdata));
    });

    on<PlaylistAdd>((event, emit) async {
      await addPlaylist(event.newname);
      List<ListClass> playlistdata = await playlistFetch();
      return emit(PlayListState(playlist: playlistdata));
    });

    on<PlaylistDelete>((event, emit) async {
      await deletePlaylist(event.playlistIndex);
      List<ListClass> playlistdata = await playlistFetch();
      return emit(PlayListState(playlist: playlistdata));
    });

    on<PlaylistRename>((event, emit) async {
      await updateNamePlaylist(event.newname,event.playlistIndex);
      List<ListClass> playlistdata = await playlistFetch();
      return emit(PlayListState(playlist: playlistdata));
    });

    on<PlaylistSongAdd>((event, emit) async {
      await addsongToPlaylist(event.song,event.name);
      List<ListClass> playlistdata = await playlistFetch();
      return emit(PlayListState(playlist: playlistdata));
    });

    on<PlaylistRemoveSong>((event, emit) async {
      await romoveFromPlaylist(event.song,event.name);
      List<ListClass> playlistdata = await playlistFetch();
      return emit(PlayListState(playlist: playlistdata));
    });

  }
}