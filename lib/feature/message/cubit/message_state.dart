part of 'message_cubit.dart';

@immutable
abstract class MessageState {}

class MessageInitial extends MessageState {}
class MessageLoaded extends MessageState {}
class MessageError extends MessageState {}
class MessageLoading extends MessageState {}
