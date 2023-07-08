import 'package:flutter/cupertino.dart';



@immutable
abstract class AddAdState {}

class AddAdInitial extends AddAdState {}
class  AddAdcreensIndex extends AddAdState {
  final int index;
  AddAdcreensIndex(this.index);
}
class OnAddAdVaild extends AddAdState {}
class AddAdFailure extends AddAdState {}
class OnAddAdVaildFaild extends AddAdState {}
class PhotoPicked extends AddAdState {}
class CategoriesLoading extends AddAdState {}
class CategoriesLoaded extends AddAdState {}
class CategoriesError extends AddAdState {}
class SubCategoriesLoading extends AddAdState {}
class SubCategoriesLoaded extends AddAdState {}
class SubCategoriesError extends AddAdState {}
class CarOptionsLoaded extends AddAdState {}
class CarOptionsError extends AddAdState {}
class CarOptionsLoading extends AddAdState {}
class CarLoading extends AddAdState {}