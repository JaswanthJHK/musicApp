import 'package:hive/hive.dart';
part 'model.g.dart';

@HiveType(typeId: 1)
class Modelsong extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? artist;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  int? id;
  @HiveField(4)
  String? url;

  Modelsong(
      {required this.name,
      required this.artist,
      required this.duration,
      required this.id,
      required this.url});
}
