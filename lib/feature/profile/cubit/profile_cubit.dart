import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:engwheels/core/models/setting.dart';
import 'package:engwheels/core/preferences/preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/status_resspons.dart';
import '../../../core/models/user_model.dart';
import '../../../core/remote/service.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/appwidget.dart';
import '../../../core/utils/toast_message_method.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ServiceApi api;

  SettingData? settings;
  UserModel? userModel;

  String? softwareType;
  ProfileCubit(this.api) : super(ProfileInitial()){
    getuserData();
    getSettings();

  }
  getSettings() async {
    emit(SettingsLoading());
    final response = await api.getSettings();
    response.fold(
          (l) => emit(SettingsError()),
          (r) {
        settings = r;
        emit(SettingsLoaded());
      },
    );
  }
  deleteAccount(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.deleteAccount();
    response.fold(
          (l) => {
          Navigator.pop(context),
          Navigator.pop(context)
          },
          (r) {
            Navigator.pop(context);
            Navigator.pop(context);
            if (r.code == 200) {
              // Fluttertoast.showToast(msg: 'deleted'.tr(),fontSize: 15.0,backgroundColor: AppColors.black,gravity: ToastGravity.SNACKBAR,textColor: AppColors.white);
              // context.read<OrderCubit>().getorders(userModel);

              toastMessage('sucess'.tr(), AppColors.primary);
              Preferences.instance.clearUserData();
              getuserData();
            } else {
              toastMessage(r.message, AppColors.primary);
            }
      },
    );

  }
  logout(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    String? token = await FirebaseMessaging.instance.getToken();
    final response = await api.logout(token!);
    response.fold(
          (l) => {
          Navigator.pop(context)
          },
          (r) {
            Navigator.pop(context);
            if (r.code == 200) {
              // Fluttertoast.showToast(msg: 'deleted'.tr(),fontSize: 15.0,backgroundColor: AppColors.black,gravity: ToastGravity.SNACKBAR,textColor: AppColors.white);
              // context.read<OrderCubit>().getorders(userModel);
              //   Navigator.pop(context);
              toastMessage('sucess'.tr(), AppColors.primary);
              Preferences.instance.clearUserData();
              getuserData();
            } else {
              toastMessage(r.message, AppColors.primary);
            }
      },
    );

  }
  getDeviceToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    if (Platform.isAndroid) {
      softwareType = 'android';
    } else if (Platform.isIOS) {
      softwareType = 'ios';
    }
    final response = await api.addDeviceToken(token!, softwareType!);
    response.fold(
          (l) => emit(DeviceTokenError()),
          (r) {
        if (r.code == 200) {
          emit(DeviceTokenSuccess());
        } else {
          emit(DeviceTokenError());
        }
      },
    );
  }
  Future<void> getuserData() async {
    userModel=await Preferences.instance.getUserModel();
   // print(userModel!.data!.name);
    if(userModel!=null){
      getDeviceToken();
    }
    emit(ProfileInitial());
  }

}
