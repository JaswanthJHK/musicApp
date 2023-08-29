import 'package:bloc/bloc.dart';


class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavState(navIndex: 0)) {
    on<NavEvent>((event, emit) {
      return emit(NavState(navIndex: event.index)); 
    });
  }
}

class NavEvent {
  int index;
  NavEvent({required this.index});
}

class NavState {
  int navIndex;
  NavState({required this.navIndex});
}