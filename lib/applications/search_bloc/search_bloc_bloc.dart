import 'package:bloc/bloc.dart';
import 'package:music_ui/applications/search_bloc/search_bloc_state.dart';
import 'package:music_ui/model/model.dart';
import '../../function/search/search.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState(searchdata: [])) {
    on<SearchEvent>((event, emit) {
      List<Modelsong> searchdata = search(event.query);
      emit(SearchState(searchdata: searchdata));
    });
  }
}

class SearchEvent {
  String query;
  SearchEvent({required this.query});
}
