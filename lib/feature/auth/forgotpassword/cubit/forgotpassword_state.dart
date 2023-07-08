part of 'forgotpassword_cubit.dart';

@immutable
abstract class ForgotpasswordState {}

class ForgotpasswordInitial extends ForgotpasswordState {}
class OnError extends ForgotpasswordState {
 final String error;

  OnError(this.error);

}
