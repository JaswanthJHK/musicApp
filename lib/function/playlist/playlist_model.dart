import 'package:hive/hive.dart';
part 'playlist_model.g.dart';

@HiveType(typeId: 2)
class PlayListModel extends HiveObject{
  
  @HiveField(0)
  String playlistName;

  @HiveField(1)
  List<int> item = [];

  PlayListModel({
    required this.playlistName,
  }); 
}
