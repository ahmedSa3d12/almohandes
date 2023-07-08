part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeCarsLoaded extends HomeState {}
class HomeCarsError extends HomeState {}
class HomeCarsLoading extends HomeState {}
class HomeFilterCarsLoaded extends HomeState {}
class HomeFilterCarsError extends HomeState {}
class HomeFilterCarsLoading extends HomeState {}
class CategoryLoaded extends HomeState {}
class CategoryError extends HomeState {}
class CategoryLoading extends HomeState {}
