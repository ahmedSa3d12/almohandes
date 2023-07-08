part of 'my_ads_cubit.dart';

@immutable
abstract class MyAdsState {}

class MyAdsInitial extends MyAdsState {}
class MyCarsLoaded extends MyAdsState {}
class MyCarsError extends MyAdsState {}
class MyCarsLoading extends MyAdsState {}
