import 'package:hive/hive.dart';
import 'package:music_ui/model/model.dart';

class ListClass extends HiveObject {
  String name;
  List<Modelsong> playlistSongs = [];

  ListClass({required this.name});
}
