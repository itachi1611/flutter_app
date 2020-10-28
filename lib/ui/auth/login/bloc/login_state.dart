part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends LoginState {}

class AuthenticationLoading extends LoginState {}

class AuthenticationNotAuthenticated extends LoginState {}

class AuthenticationAuthenticated extends LoginState {
  final User user;

  AuthenticationAuthenticated({@required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationFailure extends LoginState {
  final String message;

  AuthenticationFailure({@required this.message});

  @override
  List<Object> get props => [message];
}