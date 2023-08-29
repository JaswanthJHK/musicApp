import 'package:bloc/bloc.dart';
import 'package:music_ui/favorite/fav_db_functions.dart';
import 'package:music_ui/model/model.dart';
part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial(favoriteBloc: favorite)) {
    on<addToFavoriteBloc>((event, emit)async {
      await addToFav(event.blocId);
      return emit(FavoriteState(favoriteBloc: favorite));
    });
     on<removeFromFavBloc>((event, emit) async{
      await removeFromFav(event.id);
      return emit(FavoriteState(favoriteBloc: favorite));
    });
  }
}
