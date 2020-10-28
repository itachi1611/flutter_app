part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// Fired just after the app is launched
class InitApp extends LoginEvent {}

// Fired when a user has successfully logged in
class UserLogin extends LoginEvent {
  final User user;

  UserLogin({@required this.user});

  @override
  List<Object> get props => [user];
}

// Fired when the user has logged out
class UserLogout extends LoginEvent {}
