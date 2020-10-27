import 'package:flutter_app/ui/snackbar/snackbar_event.dart';
import 'package:flutter_app/ui/snackbar/snackbar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SnackBarBloc extends Bloc<SnackBarEvent, SnackBarState> {

  SnackBarBloc() : super(Initial());

  @override
  Stream<SnackBarState> mapEventToState(SnackBarEvent event) async* {
    if(event is FetchData) {
      yield Loading();
      await Future.delayed(Duration(seconds: 2));
      yield Success();
    }
  }

}