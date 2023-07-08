import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:engwheels/core/utils/toast_message_method.dart';
import 'package:flutter/material.dart';

class AddAdModel{
  int id=0;
  String price ='';
  String details ='';
  String engine_capacity='';
  String category_id='';
  String year='';
  String status='';
  String engineType='';
  String subcategory_id='';
  String kilometers_travaled='';
  List<String> image=[];
  List<String> options=[];
  bool isavilable=false;
  String colors='';
List<String> additions=[];
List<String> additionsvalue=[];


  bool isData1Valid(BuildContext context){
    if(image.isNotEmpty&&price.isNotEmpty&&kilometers_travaled.isNotEmpty&&category_id.isNotEmpty&&subcategory_id.isNotEmpty&&engine_capacity.isNotEmpty&&year.isNotEmpty&&status.isNotEmpty&&colors.isNotEmpty&&engineType.isNotEmpty ){

      return true;
    }
    if(image.isEmpty){
      toastMessage("choose Images".tr(), context);
    }
    if(category_id.isEmpty){
      toastMessage("choose Brand".tr(), context);
    }
    if(subcategory_id.isEmpty){
      toastMessage("choose model".tr(), context);
    }
    if(year.isEmpty){
      toastMessage("choose year".tr(), context);
    }
    if(status.isEmpty){
      toastMessage("choose status".tr(), context);
    }
    if(colors.isEmpty){
      toastMessage("choose colors".tr(), context);
    }
    if(engineType.isEmpty){
      toastMessage("choose engine type".tr(), context);
    }

    return false;
  }
  bool isData2Valid(BuildContext context){
    if(details.isNotEmpty ){
      bool istrue=true;
if(additionsvalue.isNotEmpty){
  for(int i=0;i<additionsvalue.length;i++){
    if(additionsvalue[i].isEmpty||additions[i].isEmpty){
      print(";;;;;");
      istrue=false;
    }
  }
}
if(istrue==false){
  toastMessage("Complete Addtions", context);

}
print("ldldl");
      return istrue;
    }
    if(additionsvalue.isNotEmpty){
      for(int i=0;i<additionsvalue.length;i++){
        if(additionsvalue[i].isEmpty||additions[i].isEmpty){
         // print(";;;;;");
          toastMessage("Complete Addtions", context);
          break;
        }
      }
    }
    return false;
  }
  Future<Map<String, dynamic>> updateToJson() async => {
  "description":details,
  "price":price,
  "Installment_available":isavilable?"1":"0",
  "engine_capacity":engine_capacity,
  "color":colors,
  "kilometre":kilometers_travaled,
  "category_id":category_id,
  "sub_category_id":subcategory_id,
  "car_data[0][key]":"Status",
  "car_data[0][value]":status,
  "car_data[1][key]":"Gear Type",
  "car_data[1][value]":engineType,
  "car_data[2][key]":"Manufacture Year",
  "car_data[2][value]":year,
    if(additions.isNotEmpty)...{
      for(int i=0;i<additions.length;i++)...{

        "car_data[$i+3][key]":additions[i],
        "car_data[$i+3][value]":additionsvalue[i],
      }},
  "options[]":options,
    if(image.isNotEmpty)...{
      "images[]": [ for(int i=0;i<image.length;i++)...{
       await MultipartFile.fromFile(image[i])

     }.toList()]
    }
  };
  Future<Map<String, dynamic>> updateaddToJson() async => {
    "id":id,
  "description":details,
  "price":price,
  "Installment_available":isavilable?"1":"0",
  "engine_capacity":engine_capacity,
  "color":colors,
  "kilometre":kilometers_travaled,
  "category_id":category_id,
  "sub_category_id":subcategory_id,
  "car_data[0][key]":"Status",
  "car_data[0][value]":status,
  "car_data[1][key]":"Gear Type",
  "car_data[1][value]":engineType,
  "car_data[2][key]":"Manufacture Year",
  "car_data[2][value]":year,
    if(additions.isNotEmpty)...{
      for(int i=0;i<additions.length;i++)...{

        "car_data[$i+3][key]":additions[i],
        "car_data[$i+3][value]":additionsvalue[i],
      }},
  "options[]":options,
    if(image.isNotEmpty)...{
        for(int i=0;i<image.length;i++)...{
          if(!image[i].contains("http"))...{
            "images[$i]": await MultipartFile.fromFile(image[i])
          }
     }
    }
  };

}