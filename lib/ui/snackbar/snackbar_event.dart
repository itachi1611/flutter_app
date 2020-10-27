import 'package:meta/meta.dart';

@immutable
abstract class SnackBarEvent {}

class FetchData extends SnackBarEvent {}