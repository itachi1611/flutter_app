import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/repository/firebase_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final FirebaseRepository _firebaseRepository;
  StreamSubscription<User> _firebaseSubscription;

  AuthBloc({
    @required FirebaseRepository firebaseRepository
  }) : assert(firebaseRepository != null),
      _firebaseRepository = firebaseRepository,
      super(const AuthState.unknown()) {
    _firebaseSubscription = _firebaseRepository.user.listen((event) {
      add(AuthUserChanged(event));
    });
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if(event is AuthUserChanged) {
      yield _mapAuthenticationUserChangedToState(event);
    } else if(event is AuthLogoutRequested) {
      _firebaseRepository.signOutApp();
    }
  }

  AuthState _mapAuthenticationUserChangedToState(AuthUserChanged event) {
    return event.user != User.empty
          ? AuthState.authenticated(event.user)
          : const AuthState.unauthenticated();
  }

  @override
  Future<void> close() {
    _firebaseSubscription.cancel();
    return super.close();
  }
}
