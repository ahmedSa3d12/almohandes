import 'package:easy_localization/easy_localization.dart';
import 'package:engwheels/feature/auth/register/cubit/register_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/models/country_model.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/remote/service.dart';
import '../../../../core/utils/appwidget.dart';
import '../../../../core/utils/toast_message_method.dart';
import '../../../chat/cubit/chat_cubit.dart';
import '../../../main/cubit/mainscreens_cubit.dart';
import '../../../profile/cubit/profile_cubit.dart';
import '../model/register_model.dart';


class RegisterCubit extends Cubit<RegisterState> {
  int index=0;
  RegisterModel model=RegisterModel();
  XFile? imageFile;
  String imageType='';

  bool isLoginValid=false;
  final ServiceApi api;
  CountryModel? selectedCountry;


  List<CountryModel> countries = [];
  RegisterCubit(this.api) : super(RegisterInitial()){

    getCountries();

  }

  getCountries() async {
    emit(CountriesLoading());
    final response = await api.getCountries();
    response.fold(
          (l) => emit(CountriesError()),
          (r) {
        countries = r.data!;
        emit(CountriesLoaded());
      },
    );
  }

  void changeCountry(CountryModel? value) {
    selectedCountry=value;
    emit(CountriesLoaded());

  }
  setIndex(int index){
    this.index=index;
    emit(RegistercreensIndex(index));
  }
  pickImage({required String type}) async {
    imageFile = await ImagePicker().pickImage(
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery);
    imageType = 'file';

    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
        sourcePath: imageFile!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        cropStyle: CropStyle.rectangle,
        compressFormat: ImageCompressFormat.png,
        compressQuality: 90);

      model.image = croppedFile!.path;


    emit(PhotoPicked());
    checkValidLoginData();
  }
  void checkValidLoginData() {
    if (model.isDataValid()) {
      isLoginValid = true;
      emit(OnRegisterVaild());
    } else {
      isLoginValid = false;

      emit(OnLoginVaildFaild());
    }
  }
  void register(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.registerUser(model);
    response.fold(
          (failure) => {Navigator.pop(context), emit(RegisterFailure())},
          (loginModel) {
        if (loginModel.code == 409) {
          Navigator.pop(context);
          toastMessage("exists_email".tr(), context);
          // errorGetBar(translateText(AppStrings.noEmailError, context));
          emit(RegisterFailure());
        } else if (loginModel.code == 200) {
          Navigator.pop(context);
          Preferences.instance.setUser(loginModel).then((value) {
            Preferences.instance.setUser(loginModel).then((value) {
            //  emit(OnLoginSuccess(loginModel));
              context.read<ProfileCubit>().getuserData();
              context.read<MainscreensCubit>().getuserData();
              context.read<ChatCubit>().getuserData();
              context.read<ProfileCubit>().getDeviceToken();
              Navigator.pop(context);
              Navigator.pop(context);

            });            // emit(OnLoginSuccess(response));
          });
        }
      },
    );
  }

}
