import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';

class RegisterModel{
  String email = '';
  String password ='';
  String confirmpassword ='';
  String phone='';
  String phone_code='';
  String name='';
  String image='';



  bool isDataValid(){
    if(EmailValidator.validate(email)&&password.isNotEmpty&&password.length>=6&&confirmpassword.isNotEmpty&&confirmpassword==password&&name.isNotEmpty&&phone_code.isNotEmpty&&phone.isNotEmpty ){

      return true;
    }

    return false;
  }
  Future<Map<String, dynamic>> updateToJson() async => {
    "phone": phone,
    "email": email,
    "name": name,
    "password": password,
    "phone_code": phone_code,

    if (image.isNotEmpty) ...{
      "image": await MultipartFile.fromFile(image)
    },

  };

}