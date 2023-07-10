import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/user_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';
import '../../message/cubit/message_cubit.dart';

part 'ad_details_state.dart';

class AdDetailsCubit extends Cubit<AdDetailsState> {
  UserModel? userModel;
  int page = 1;
  final ServiceApi api;
  AdDetailsCubit(this.api) : super(AdDetailsInitial()){
    getuserData();
  }
  Future<void> getuserData() async {
    userModel=await Preferences.instance.getUserModel();
    print(userModel!.data!.name);
    emit(AdDetailsInitial());
  }

  void changepage(int i) {
    page=i+1;
    emit(AdDetailsInitial());

  }
  void sendMessage(int user_id,BuildContext context) async {

    final response = await api.sendmessage("welcome".tr(),"",user_id);
    response.fold(
          (failure) => {
      },
          (loginModel) {
        if (loginModel.code == 200) {
          context.read<MessageCubit>().getMessages(loginModel.data.id);
          Navigator.pushNamed(context, Routes.messageRoute,arguments:loginModel.data );
        }
      },
    );
  }

}
