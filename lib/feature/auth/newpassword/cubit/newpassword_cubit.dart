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

part 'newpassword_state.dart';

class NewpasswordCubit extends Cubit<NewpasswordState> {
  TextEditingController newpass = TextEditingController();
  TextEditingController confirmpass = TextEditingController();
String email='';
  final ServiceApi api;

  NewpasswordCubit(this.api) : super(NewpasswordInitial());
  void newpassword(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.newpassword(context.read<ForgotpasswordCubit>().controllerEmail.text,newpass.text);
    response.fold(
          (failure) => {Navigator.pop(context),
        emit(OnError(failure.toString()))},
          (loginModel) {
        Navigator.pop(context);

        if (loginModel.code == 409) {
          toastMessage(loginModel.message, context);
          // emit(LoginLoaded());
        } else if (loginModel.code == 200) {
          Navigator.pop(context);

       //   Navigator.pushReplacementNamed(context, Routes.loginRoute,);

        }
      },
    );
  }

}
