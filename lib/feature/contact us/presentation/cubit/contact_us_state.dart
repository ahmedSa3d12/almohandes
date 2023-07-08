part of 'contact_us_cubit.dart';

abstract class ContactUsState {}

class ContactUsInitial extends ContactUsState {}

class ContactUsGetUserModel extends ContactUsState {}


class ContactUsLoading extends ContactUsState {}
class ContactUsLoaded extends ContactUsState {}
class ContactUsError extends ContactUsState {}
