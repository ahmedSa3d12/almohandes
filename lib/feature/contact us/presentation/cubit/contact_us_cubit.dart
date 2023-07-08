import 'dart:convert';

import 'package:engwheels/core/preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/remote/service.dart';
import '../../models/contact_us_model.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit(this.api) : super(ContactUsInitial()) {
    _getStoreUser();
  }

  final ServiceApi api;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  UserModel? loginModel;

  Future<void> _getStoreUser() async {
    if (Preferences.instance.getUserModel() != null) {
      UserModel? loginModel =await Preferences.instance.getUserModel();
      this.loginModel = loginModel;
      nameController.text = this.loginModel!.data!.name!;
      phoneController.text = this.loginModel!.data!.phone!;
      emailController.text = this.loginModel!.data!.email!;
    }
    emit(ContactUsGetUserModel());

  }

  contactUsApi() async {
    emit(ContactUsLoading());
    final response = await api.contactUsApi(
      ContactUsData(
        name: nameController.text,
        phone: phoneController.text,
        subject: subjectController.text,
        message: messageController.text,
        email:emailController.text
      ),
    );
    response.fold(
      (l) => emit(ContactUsError()),
      (r) {
        emit(ContactUsLoaded());
        Future.delayed(Duration(seconds: 1),(){
          emit(ContactUsInitial());
        });
      },
    );
  }
}
