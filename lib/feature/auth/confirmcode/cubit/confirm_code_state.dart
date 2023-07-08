part of 'confirm_code_cubit.dart';

@immutable
abstract class ConfirmCodeState {}

class ConfirmCodeInitial extends ConfirmCodeState {}
class OnError extends ConfirmCodeState {
  final String error;

  OnError(this.error);

}
class OnTimerChanged extends ConfirmCodeState {
  String time = '00:00';

  OnTimerChanged(this.time);
}