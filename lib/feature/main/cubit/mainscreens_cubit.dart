import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/user_model.dart';
import '../../../core/preferences/preferences.dart';

part 'mainscreens_state.dart';

class MainscreensCubit extends Cubit<MainscreensState> {
  int index=0;
  UserModel? userModel;

  MainscreensCubit() : super(MainscreensInitial()){
    getuserData();

  }

  setIndex(int index){
    this.index=index;
emit(MainscreensIndex(index));
  }
  Future<void> getuserData() async {
    userModel=await Preferences.instance.getUserModel();
    // print(userModel!.data!.name);
    if(userModel!=null){
    //  getDeviceToken();
    }
    emit(MainscreensInitial());
  }
}
