part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}
class MyRoomsLoaded extends ChatState {}
class MyRoomsError extends ChatState {}
class MyRoomsLoading extends ChatState {}
