part of 'favorite_bloc.dart';

class FavoriteEvent {}

class addToFavoriteBloc extends FavoriteEvent {
  final int blocId;

  addToFavoriteBloc({required this.blocId});
}

class removeFromFavBloc extends FavoriteEvent {
  final int id;

  removeFromFavBloc({required this.id});
}
