part of 'favorite_bloc.dart';

class FavoriteState {
  final List<Modelsong> favoriteBloc;

  FavoriteState({required this.favoriteBloc});
}

class FavoriteInitial extends FavoriteState {
  FavoriteInitial({required super.favoriteBloc});
}
