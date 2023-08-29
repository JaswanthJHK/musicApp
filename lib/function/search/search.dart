import 'package:music_ui/model/model.dart';
import '../../screens/splachScreen.dart';

search(String querry) {
  List<Modelsong> data = allSongs
      .where((element) =>
          element.name!.toLowerCase().contains(querry.toLowerCase().trim()))
      .toList();
  return data;
}
