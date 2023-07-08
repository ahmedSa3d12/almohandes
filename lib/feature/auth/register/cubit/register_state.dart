import 'package:flutter/cupertino.dart';



@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class  RegistercreensIndex extends RegisterState {
  final int index;
  RegistercreensIndex(this.index);
}
class OnRegisterVaild extends RegisterState {}
class RegisterFailure extends RegisterState {}
class OnLoginVaildFaild extends RegisterState {}
class PhotoPicked extends RegisterState {}
class CountriesLoading extends RegisterState {}
class CountriesLoaded extends RegisterState {}
class CountriesError extends RegisterState {}