import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/user_model.dart';
import '../../../core/preferences/preferences.dart';

part 'ad_details_state.dart';

class AdDetailsCubit extends Cubit<AdDetailsState> {
  UserModel? userModel;
  int page = 1;
  AdDetailsCubit() : super(AdDetailsInitial()){
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
}
