import 'package:hive/hive.dart';
part 'favorite_model.g.dart';

@HiveType(typeId: 0)
class FavoriteModel extends HiveObject {
  @HiveField(0)
  int? id;

  FavoriteModel({required this.id});
}
