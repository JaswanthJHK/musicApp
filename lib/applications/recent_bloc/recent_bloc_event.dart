part of 'recent_bloc_bloc.dart';

class RecentlyEvent {}

class RecentFetch extends RecentlyEvent {}

class RecentAdd extends RecentlyEvent {
  Modelsong song;
  RecentAdd({required this.song});
}
