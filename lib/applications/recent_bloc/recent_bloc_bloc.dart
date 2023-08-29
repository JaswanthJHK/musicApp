import 'package:bloc/bloc.dart';

import '../../model/model.dart';
import '../../recently/recentlyPlayed.dart';
import '../../screens/splachScreen.dart';
part 'recent_bloc_event.dart';
part 'recent_bloc_state.dart';

class RecentlyBloc extends Bloc<RecentlyEvent, RecentlyState> {
  RecentlyBloc() : super(RecentlyState(recentList: [])) {
    on<RecentFetch>((event, emit) async {
      List<Modelsong> recent = await recentfetch();
      return emit(RecentlyState(recentList: recent));
    });

    on<RecentAdd>((event, emit) async {
      List<Modelsong> data = await recentadd(event.song);
      return emit(RecentlyState(recentList: data));
    });
  }
}
