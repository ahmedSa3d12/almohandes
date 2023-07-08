import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:engwheels/feature/auth/confirmcode/cubit/confirm_code_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/remote/service.dart';
import '../../../../core/utils/appwidget.dart';
import '../../../../core/utils/toast_message_method.dart';

part 'forgotpassword_state.dart';

class ForgotpasswordCubit extends Cubit<ForgotpasswordState> {
  final ServiceApi api;
  TextEditingController controllerEmail = TextEditingController();

  ForgotpasswordCubit(this.api) : super(ForgotpasswordInitial());
  void forgotpassword(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.forgotPassword(controllerEmail.text);
    response.fold(
          (failure) => {Navigator.pop(context),
            emit(OnError(failure.toString()))},
          (loginModel) {
        Navigator.pop(context);

        if (loginModel.code == 409) {
          toastMessage(loginModel.message, context);
          // emit(LoginLoaded());
        } else if (loginModel.code == 200) {
          context.read<ConfirmCodeCubit>().email=controllerEmail.text;

          Navigator.pushReplacementNamed(context, Routes.confirmCodeRoute);


        }
      },
    );
  }

}
