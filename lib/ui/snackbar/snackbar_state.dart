import 'package:meta/meta.dart';

@immutable
abstract class SnackBarState {}

class Initial extends SnackBarState {}

class Loading extends SnackBarState {}

class Success extends SnackBarState {}
