import 'package:engwheels/core/utils/toast_message_method.dart';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:engwheels/feature/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/remote/service.dart';
import '../../../../core/utils/appwidget.dart';
import '../model/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  bool isLoginValid = false;

  LoginModel loginModel = LoginModel();

  bool ishidden = true;
  final ServiceApi api;

  LoginCubit(this.api) : super(LoginInitial());

  hide() {
    print("sss${ishidden}");
    ishidden = !ishidden;
    print("seess${ishidden}");
    emit(PasswordHidden(ishidden));
  }

  void checkValidLoginData() {
    if (loginModel.isDataValid()) {
      isLoginValid = true;
      emit(OnLoginVaild());
    } else {
      isLoginValid = false;

      emit(OnLoginVaildFaild());
    }
  }

  void login(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.postLogin(loginModel);
    response.fold(
      (failure) => {Navigator.pop(context), emit(OnError(failure.toString()))},
      (loginModel) {
        Navigator.pop(context);

        if (loginModel.code == 409) {
          toastMessage(loginModel.message, context);
          // emit(LoginLoaded());
        } else if (loginModel.code == 200) {
          Preferences.instance.setUser(loginModel).then((value) {
            emit(OnLoginSuccess(loginModel));
            context.read<ProfileCubit>().getuserData();
            context.read<ProfileCubit>().getDeviceToken();

            Navigator.pop(context);

          });
        }
      },
    );
  }
}
