import 'package:bloc/bloc.dart';

import '../../../function/mostlyPlayed/mostlyPlayed_function.dart';
import '../../../model/model.dart';
import '../../../screens/splachScreen.dart';
import 'mostly_bloc_event.dart';
import 'mostly_bloc_state.dart';

class MostBloc extends Bloc<MostEvent, MostState> {
  MostBloc() : super(MostState(mostPlayedList: [])) {
    on<MostPlayedFetch>((event, emit) async {
      List<Modelsong> data = await mostlyPlayedFetch();
      return emit(MostState(mostPlayedList: data));
    });

    on<MostPlayedAdd>((event, emit) async {
      List<Modelsong> data = await addMostlyPlayed(event.song);
      return emit(MostState(mostPlayedList: data));
    });
  }
}
