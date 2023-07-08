import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:engwheels/core/models/user_model.dart';
import 'package:engwheels/feature/profile/cubit/profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/country_model.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/remote/service.dart';
import '../../../../core/utils/appwidget.dart';
import '../../../../core/utils/toast_message_method.dart';
import '../model/edit_Profile_model.dart';

part 'editprofile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {

  EditProfileModel model=EditProfileModel();
  XFile? imageFile;
  String imageType='';
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isLoginValid=false;
  final ServiceApi api;
  CountryModel? selectedCountry;


  List<CountryModel> countries = [];
  EditProfileCubit(this.api) : super(EditProfileInitial()){

    getCountries();

  }

  getCountries() async {
    emit(CountriesLoading());
    final response = await api.getCountries();
    response.fold(
          (l) => emit(CountriesError()),
          (r) async {
        countries = r.data!;
        UserModel? userModel=await Preferences.instance.getUserModel();
        for(int i=0;i<countries.length;i++){
          if(userModel!.data!.countryId==countries.elementAt(i).id){
            changeCountry(countries.elementAt(i));
          }
        }
        emit(CountriesLoaded());
      },
    );
  }

  void changeCountry(CountryModel? value) {
    selectedCountry=value;
    emit(CountriesLoaded());

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
      emit(OnEditProfileVaild());
    } else {
      isLoginValid = false;

      emit(OnLoginVaildFaild());
    }
  }
  void EditProfile(BuildContext context) async {
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.EditProfileUser(model);
    response.fold(
          (failure) => {Navigator.pop(context), emit(EditProfileFailure())},
          (loginModel) {
        if (loginModel.code == 409) {
          Navigator.pop(context);
          toastMessage("exists_email".tr(), context);
          // errorGetBar(translateText(AppStrings.noEmailError, context));
          emit(EditProfileFailure());
        } else if (loginModel.code == 200) {
          Navigator.pop(context);
          Preferences.instance.setUser(loginModel).then((value) {
            Preferences.instance.setUser(loginModel).then((value) {
              //  emit(OnLoginSuccess(loginModel));
              Navigator.pop(context);
             // Navigator.pop(context);
              context.read<ProfileCubit>().getuserData();
            });            // emit(OnLoginSuccess(response));
          });
        }
      },
    );
  }

  Future<void> editData() async {
    UserModel? userModel=await Preferences.instance.getUserModel();
    nameController.text=userModel!.data!.name;
    emailController.text=userModel.data!.email;
    phoneController.text=userModel.data!.phone;
    model..phone=userModel.data!.phone
    ..email=userModel.data!.email
    ..name=userModel.data!.name..id=userModel.data!.id;


    emit(EditProfileInitial());
  }
}
