part of 'choose_country_cubit.dart';

@immutable
abstract class ChooseCountryState {}

class ChooseCountryInitial extends ChooseCountryState {}
class CountriesLoading extends ChooseCountryState {}
class CountriesLoaded extends ChooseCountryState {}
class CountriesError extends ChooseCountryState {}