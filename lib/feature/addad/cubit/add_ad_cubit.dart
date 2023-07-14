import 'package:easy_localization/easy_localization.dart';
import 'package:bloc/bloc.dart';
import 'package:engwheels/core/models/cars_model.dart';
import 'package:engwheels/core/models/category_model.dart';
import 'package:engwheels/feature/my_ads/cubit/my_ads_cubit.dart';
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
import '../../../core/api/end_points.dart';
import '../../../core/models/car_options_model.dart';
import '../../../core/models/sub_category.dart';
import '../../../core/models/sub_category_model.dart';
import '../../../core/utils/hex_color.dart';
import '../../../core/utils/matrial_color.dart';
import '../model/add_ad_model.dart';
import 'add_ad_state.dart';


class AddAdCubit extends Cubit<AddAdState> {
  int index=0;
  AddAdModel model=AddAdModel();
  XFile? imageFile;
  String imageType='';
  bool isAddAdValid=false;
  bool isAdd2AdValid=false;
  final ServiceApi api;
  CategoryModel? selectCategories;
  SubCategory? selectSubCategories;
int? year;
String? status;
String? engineType;
  List<CategoryModel> categories=[];
  List<SubCategory> subcategories=[];
  List<OptionsModel> options=[];
  List<TextEditingController> additionscontrol=[];
  List<TextEditingController> additionsvaluecontrol=[];
  TextEditingController kiloetercontrol = TextEditingController();
  TextEditingController capcityControl = TextEditingController();
  TextEditingController priceControl = TextEditingController();
  TextEditingController detailsControl = TextEditingController();

  String? colors;

  CarsModel? carsModel;
  AddAdCubit(this.api) : super(AddAdInitial()){
    getCategories();
    getCarOptions();

  }

  getCategories() async {
    emit(CategoriesLoading());
    final response = await api.getCategory();
    response.fold(
          (l) => emit(CategoriesError()),
          (r) {
        categories = r.data!;
        if(carsModel!=null){
        for(int i=0;i<categories.length;i++){
          if(categories.elementAt(i).id==carsModel!.categoryId){
            changeCategories(categories.elementAt(i));
          }
        }}
        emit(CategoriesLoaded());
      },
    );
  }
  getSubCategory() async {
    emit(SubCategoriesLoading());
    final response = await api.getSubCategory(selectCategories!.id);
    response.fold(
          (l) => emit(SubCategoriesError()),
          (r) {
            subcategories.clear();
            emit(SubCategoriesLoaded());
            selectSubCategories=null;
        subcategories = r.data;
            if(carsModel!=null){
              for(int i=0;i<subcategories.length;i++){
                if(subcategories.elementAt(i).id==carsModel!.subCategoryId){
                  changeSubCategories(subcategories.elementAt(i));
                }
              }}
        emit(SubCategoriesLoaded());
      },
    );
  }
  getCarOptions() async {
    emit(CarOptionsLoading());
    final response = await api.getCarOptions();
    response.fold(
          (l) => emit(CarOptionsError()),
          (r) {
            options.clear();
            options=r.data;
            if(carsModel!=null){
              for(int i=0;i<options.length;i++){
                for(int j=0;j<carsModel!.options.length;j++){
                if(options.elementAt(i).id==carsModel!.options.elementAt(j).option.id){
                  changeoptions(true,i);
                }}
              }}
            emit(CarOptionsLoaded());

      },
    );
  }

  void changeCategories(CategoryModel? value) {
    selectCategories=value;
    getSubCategory();
    emit(CategoriesLoaded());

  }
  void changeyear(int? value) {
    year=value;
    emit(CategoriesLoaded());

  }
  void changeColor(String? value) {

    colors=value;
    emit(CategoriesLoaded());

  }
  void changeStatus(String? value) {
    status=value;
    emit(CategoriesLoaded());

  }
  void changeEngineType(String? value) {
    engineType=value;
    emit(CategoriesLoaded());

  }
  void changeSubCategories(SubCategory? value) {
    selectSubCategories=value;
    emit(SubCategoriesLoaded());

  }
  setIndex(int index){
    this.index=index;
    emit(AddAdcreensIndex(index));
  }
  pickImage({required String type,required BuildContext context}) async {
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

      model.image.add( croppedFile!.path);


    emit(PhotoPicked());
    checkValid1AddAdData(context);
  }
  void checkValid1AddAdData(BuildContext context) {
    if (model.isData1Valid(context)) {
      isAddAdValid = true;
      emit(OnAddAdVaild());
    } else {
      isAddAdValid = false;

      emit(OnAddAdVaildFaild());
    }
  }
  void checkValid2AddAdData(BuildContext context) {
    if (model.isData2Valid(context)) {
      isAdd2AdValid = true;
      emit(OnAddAdVaild());
    } else {
      isAdd2AdValid = false;

      emit(OnAddAdVaildFaild());
    }
  }
  void AddAd(BuildContext context) async {
    // AppWidget.createProgressDialog(context, 'wait'.tr());
    // final response = await api.AddAdUser(model);
    // response.fold(
    //       (failure) => {Navigator.pop(context), emit(AddAdFailure())},
    //       (AddAdModel) {
    //     if (AddAdModel.code == 409) {
    //       Navigator.pop(context);
    //       toastMessage("exists_email".tr(), context);
    //       // errorGetBar(translateText(AppStrings.noEmailError, context));
    //       emit(AddAdFailure());
    //     } else if (AddAdModel.code == 200) {
    //       Navigator.pop(context);
    //       Preferences.instance.setUser(AddAdModel).then((value) {
    //         Preferences.instance.setUser(AddAdModel).then((value) {
    //         //  emit(OnAddAdSuccess(AddAdModel));
    //           Navigator.pop(context);
    //           Navigator.pop(context);
    //         });            // emit(OnAddAdSuccess(response));
    //       });
    //     }
    //   },
    // );
  }

  void addwiget() {
   model.additions.add("");
   model.additionsvalue.add("");
   additionscontrol.add(new TextEditingController());
   additionsvaluecontrol.add(new TextEditingController());
    emit(CategoriesLoaded());
  }

  void changeoptions(bool? value, int index) {
    OptionsModel optionsModel=options.elementAt(index);
    optionsModel.isselected=value!;
    options.removeAt(index);
    options.insert(index, optionsModel);
    if(value==false){
      model.options.remove(optionsModel.id.toString());
    }
    else{
      model.options.add(optionsModel.id.toString());
    }
    emit(CarOptionsLoaded());
  }

  void changtextname(String data, int index) {
    model.additions.removeAt(index);
    model.additions.insert(index,data);
    emit(CategoriesLoaded());
  }

  void changtextvalue(String data, int index) {
    model.additionsvalue.removeAt(index);
    model.additionsvalue.insert(index,data);
    emit(CategoriesLoaded());
  }

  void remove(int index) {
    model.additionsvalue.removeAt(index);
    model.additions.removeAt(index);
    emit(CategoriesLoaded());

  }
  void addAd(BuildContext context) async {
    print(model.image.elementAt(0));
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.addAd(model);
    response.fold(
          (failure) => {
            Navigator.pop(context),
            },
          (loginModel) {
       if (loginModel.code == 200) {
          Navigator.pop(context);
          context.read<MyAdsCubit>().getMyAds();
          Navigator.pushNamedAndRemoveUntil(context, Routes.myAdsRoute, (route) => false);
        }
      },
    );
  }
  void update(BuildContext context) async {
    print(model.image.elementAt(0));
    AppWidget.createProgressDialog(context, 'wait'.tr());
    final response = await api.updateAd(model);
    response.fold(
          (failure) => {
            Navigator.pop(context),
            },
          (loginModel) {
       if (loginModel.code == 200) {
          Navigator.pop(context);
          model=AddAdModel();
          carsModel=null;
          capcityControl.text='';
          priceControl.text='';
          kiloetercontrol.text='';
          capcityControl.text='';
          detailsControl.text='';
          selectCategories=null;
          selectSubCategories=null;
          year=null;
          status=null;
          colors=null;
          engineType=null;
          additionsvaluecontrol=[];
          additionscontrol=[];
          getCarOptions();
          setIndex(0);
          context.read<MyAdsCubit>().getMyAds();
          Navigator.pushNamedAndRemoveUntil(context, Routes.myAdsRoute, (route) => false);
        }
      },
    );
  }

  void setdata(CarsModel? carsModel) {
    this.carsModel=carsModel;
    model.id=carsModel!.id;
    model.price=carsModel!.price.toString();
    model.category_id=carsModel!.categoryId.toString();
    model.subcategory_id=carsModel!.subCategoryId.toString();
    model.kilometers_travaled=carsModel!.kilometre.toString();
    model.engine_capacity=carsModel.engineCapacity.toString();
    model.status=carsModel.data.elementAt(0).value;
    model.engineType=carsModel.data.elementAt(1).value;
    model.year=carsModel.data.elementAt(2).value;
    model.colors=carsModel.color!;
    model.details=carsModel.description;
    model.isavilable=carsModel.installmentAvailable=="1"?true:false;
    kiloetercontrol.text=carsModel!.kilometre!;
    capcityControl.text=carsModel!.engineCapacity!;
    priceControl.text=carsModel!.price!.toString();
    detailsControl.text=carsModel!.description!;
if(carsModel.color!=null){changeColor(carsModel.color!);}
changeStatus(carsModel.data.elementAt(0).value);
changeEngineType(carsModel.data.elementAt(1).value);

changeyear(int.parse(carsModel.data.elementAt(2).value));
if(carsModel.data.length>3){
  int k=0;
  for(int i=3;i<carsModel.data.length;i++){
    print(carsModel.data.elementAt(i).key);
    model.additions.add(carsModel.data.elementAt(i).key);
    model.additionsvalue.add(carsModel.data.elementAt(i).value);
    additionscontrol.add(new TextEditingController());
    additionscontrol.elementAt(k).text=carsModel.data.elementAt(i).key;
    additionsvaluecontrol.add(new TextEditingController());
    additionsvaluecontrol.elementAt(k).text=carsModel.data.elementAt(i).value;
    k=k+1;
  }
}
for(int i=0;i<carsModel.images.length;i++){
  model.image.add(EndPoints.baseUrl
      .replaceAll("/api", "") +carsModel.images.elementAt(i).image);
}
    emit(CarLoading());
  }

  void deletelocal(int index,BuildContext context) {

    model.image.removeAt(index);


    emit(PhotoPicked());
    checkValid1AddAdData(context);
  }
  void deleteonline(int index,BuildContext context) {
    print(model.ids.length);
for(int i=0;i<carsModel!.images.length;i++){
  if(model.image.elementAt(index).replaceAll(EndPoints.baseUrl
      .replaceAll("/api", ""), "")==carsModel!.images.elementAt(i).image){
    model.ids.add(carsModel!.images.elementAt(i).id);
  }
}
    model.image.removeAt(index);


    emit(PhotoPicked());
    checkValid1AddAdData(context);
  }


}
