import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';


import '../models/country_model.dart';
import '../models/user_model.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';

class Preferences {
  static final Preferences instance = Preferences._internal();

  Preferences._internal();

  factory Preferences() => instance;


  Future<void> setUser(UserModel userModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('user', json.encode(userModel));
  }

  Future<UserModel?> getUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('user');
    UserModel userModel;
    if (jsonData != null) {

      userModel = UserModel.fromJson(jsonDecode(jsonData));
    }else{
    return  null;


    }

    return userModel;
  }

  clearUserData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
  Future<String> getSavedLang() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(AppStrings.locale) ?? 'en';
  }

  Future<void> savedLang(String local) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(AppStrings.locale, local);
  }
Future<void> setcountry(CountryModel countryModel) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString(
    'country',
    jsonEncode(
      CountryModel.fromJson(
        countryModel.toJson(),
      ),
    ),
  );
}

Future<CountryModel> getcountryModel() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? jsonData = preferences.getString('country');
  CountryModel countryModel;
  if (jsonData != null) {
    countryModel = CountryModel.fromJson(jsonDecode(jsonData));
    // countryModel.data?.isLoggedIn = true;
  } else {
    countryModel = CountryModel();
  }
  return countryModel;
}
}
