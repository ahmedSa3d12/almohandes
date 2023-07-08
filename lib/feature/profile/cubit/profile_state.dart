part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class SettingsLoaded extends ProfileState {}
class SettingsError extends ProfileState {}
class SettingsLoading extends ProfileState {}
class DeviceTokenError extends ProfileState {}
class DeviceTokenSuccess extends ProfileState {}
