import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class Modelsong {

  @HiveField(0)
  String? name;
  @HiveField(1)
  String? artist;
  @HiveField(3)
  int? duration;
  @HiveField(4)
  int? id;
  @HiveField(5)
  String? url;

  Modelsong(
      {required this.name,
      required this.artist,
      required this.duration,
      required this.id,
      required this.url});
}
