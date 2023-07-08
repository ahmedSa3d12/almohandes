part of 'editprofile_cubit.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}
class OnLoginVaildFaild extends EditProfileState {}
class OnEditProfileVaild extends EditProfileState {}
class EditProfileFailure extends EditProfileState {}
class PhotoPicked extends EditProfileState {}
class CountriesLoading extends EditProfileState {}
class CountriesLoaded extends EditProfileState {}
class CountriesError extends EditProfileState {}