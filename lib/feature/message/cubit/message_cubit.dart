import 'package:bloc/bloc.dart';
import 'package:engwheels/core/models/message_data_model.dart';
import 'package:engwheels/core/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../core/preferences/preferences.dart';
import '../../../core/remote/service.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final ServiceApi api;
   ScrollController scrollController = ScrollController();

  List<MessageModel> messages = [];
  XFile? imageFile;
  String imageType='';
  UserModel? userModel;
  TextEditingController textxontrol = TextEditingController();


  MessageCubit(this.api) : super(MessageInitial()) {
    getuserData();

  }

  Future<void> getuserData() async {
    userModel = await Preferences.instance.getUserModel();
    print(userModel!.data!.name);
    emit(MessageInitial());
  }

  getMessages(int user_id) async {
    emit(MessageLoading());
    final response = await api.getMessage(user_id);
    response.fold(
      (l) => emit(MessageError()),
      (r) {
        messages = r.data!;


        emit(MessageLoaded());

      },
    );
  }
  void sendMessage(String text,String image,int user_id) async {

    final response = await api.sendmessage(text,image,user_id);
    response.fold(
          (failure) => {
        },
          (loginModel) {
       if (loginModel.code == 200) {
       messages.insert(0,loginModel.data);
textxontrol.text='';
       emit(MessageLoaded());
       if (scrollController.hasClients) {
         scrollController.animateTo(0,
             duration: const Duration(milliseconds: 500),
             curve: Curves.fastOutSlowIn);
       }
        }
      },
    );
  }
  pickImage({required String type,required int user_id}) async {
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




   //emit(PhotoPicked());
    sendMessage("", croppedFile!.path,user_id );
  }
}
