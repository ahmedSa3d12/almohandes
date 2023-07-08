part of 'newpassword_cubit.dart';

@immutable
abstract class NewpasswordState {}

class NewpasswordInitial extends NewpasswordState {}
class OnError extends NewpasswordState {
  final String error;

  OnError(this.error);
}

