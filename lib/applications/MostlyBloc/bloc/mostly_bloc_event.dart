import 'package:music_ui/model/model.dart';

class MostEvent {}

class MostPlayedFetch extends MostEvent {}

class MostPlayedAdd extends MostEvent {
  Modelsong song;
  MostPlayedAdd({required this.song});
}