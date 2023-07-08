import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/remote/service.dart';
import '../../../../core/utils/appwidget.dart';
import '../../../../core/utils/toast_message_method.dart';
import '../../forgotpassword/cubit/forgotpassword_cubit.dart';

part 'confirm_code_state.dart';

class ConfirmCodeCubit extends Cubit<ConfirmCodeState> {
  final ServiceApi api;
  int seconds = 60;
  String time = '';
  String time1 = '';
  Timer? timer;
  TextEditingController controllerCode = TextEditingController();
String email='';
  ConfirmCodeCubit(this.api) : super(ConfirmCodeInitial()){
    startTimer();
  }
  void confirmcode(BuildContext context) async {
    stopTimer();
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.confirmcode(context.read<ForgotpasswordCubit>().controllerEmail.text,controllerCode.text);
    response.fold(
          (failure) => {Navigator.pop(context),
        emit(OnError(failure.toString()))},
          (loginModel) {
        Navigator.pop(context);

        if (loginModel.code == 409) {
          toastMessage(loginModel.message, context);
          // emit(LoginLoaded());
        } else if (loginModel.code == 200) {

          Navigator.pushReplacementNamed(context, Routes.newpassRoute);

        }
      },
    );
  }
  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        time = '${seconds}'.padLeft(2, '0');
        time1="00:"+time;
        emit(OnTimerChanged('00:${time}'));
      } else {
        time1='';
        time = '';
        seconds = 60;
        emit(OnTimerChanged(''));
        timer.cancel();
      }
    });
  }

  stopTimer() {
    timer!.cancel();
  }
}
