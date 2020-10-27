import 'package:flutter_app/ui/home/home_event.dart';
import 'package:flutter_app/ui/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(NavigateHome());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    switch(event) {
      case HomeEvent.eventHome:
        yield NavigateHome();
        break;
      case HomeEvent.eventSnack:
        yield NavigateSnack();
        break;
    }
  }
}