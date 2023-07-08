part of 'mainscreens_cubit.dart';

@immutable
abstract class MainscreensState {}

class MainscreensInitial extends MainscreensState {}
class MainscreensIndex extends MainscreensState {
  final int index;
  MainscreensIndex(this.index);
}
