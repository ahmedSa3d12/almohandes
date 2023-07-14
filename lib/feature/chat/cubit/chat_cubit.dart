import 'package:bloc/bloc.dart';
import 'package:engwheels/core/models/chat_data_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/user_model.dart';
import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';
import 'package:get/get.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ServiceApi api;

  UserModel? userModel;

  List<ChatModel> rooms = [];
  ChatCubit(this.api) : super(ChatInitial()) {
    getuserData();


}
  Future<void> getuserData() async {
    userModel=await Preferences.instance.getUserModel();
    if(userModel!=null){
      getRooms();
    }
    else{
Get.toNamed(Routes.loginRoute);
       // Navigator.pushNamed(Get., Routes.loginRoute);


    }
    emit(ChatInitial());
  }
getRooms() async {
  emit(MyRoomsLoading());
  final response = await api.getRooms();
  response.fold(
        (l) => emit(MyRoomsError()),
        (r) {
          rooms = r.data!;
      emit(MyRoomsLoaded());
    },
  );
}
}
