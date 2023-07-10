import 'dart:convert';
import 'dart:ui';

import 'package:engwheels/core/api/status_code.dart';
import 'package:engwheels/core/models/message_data_model.dart';
import 'package:engwheels/core/preferences/preferences.dart';
import 'package:engwheels/feature/auth/edit_profile/model/edit_Profile_model.dart';
import 'package:engwheels/feature/auth/login/model/login_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../feature/addad/model/add_ad_model.dart';
import '../../feature/auth/register/model/register_model.dart';
import '../../feature/contact us/models/contact_us_model.dart';
import '../api/base_api_consumer.dart';
import '../api/end_points.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../models/car_options_model.dart';
import '../models/cars_data_model.dart';
import '../models/category_data_model.dart';
import '../models/chat_data_model.dart';
import '../models/country_data_model.dart';
import '../models/country_model.dart';
import '../models/new_model.dart';
import '../models/setting.dart';
import '../models/single_ad_model.dart';
import '../models/single_chat.dart';
import '../models/single_message_model.dart';
import '../models/status_resspons.dart';
import '../models/sub_category_model.dart';
import '../models/user_model.dart';

class ServiceApi {
  final BaseApiConsumer dio;

  ServiceApi(this.dio);

  Future<Either<Failure, CountryDataModel>> getCountries() async {
    try {
      final response = await dio.get(
        EndPoints.countryUrl,
      );
      return Right(CountryDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, NewsModel>> getNews() async {
    try {
      final response = await dio.get(EndPoints.newsUrl,
          queryParameters: {'pagination_status': "off"});
      return Right(NewsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, CategoryDataModel>> getCategory() async {
    try {
      final response = await dio.get(EndPoints.categoryUrl,
          queryParameters: {'pagination_status': "off"});
      return Right(CategoryDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, SubCategoryModel>> getSubCategory(int id) async {
    try {
      final response = await dio.get(EndPoints.subcategoryUrl,
          queryParameters: {'pagination_status': "off",
            'id': id});
      return Right(SubCategoryModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, CarsDataModel>> getHomeCars() async {
    CountryModel countryModel = await Preferences.instance.getcountryModel();
    try {
      final response = await dio.get(EndPoints.homeUrl, queryParameters: {
        'pagination_status': "off",
        "country_id": countryModel.id
      });
      return Right(CarsDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, CarsDataModel>> getMyCars() async {
    UserModel? userModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(EndPoints.myCarsUrl, queryParameters: {
        'pagination_status': "off",

      },
        options: Options(
          headers: {
            'Authorization': userModel!.data!.token,
          },
        ),);
      return Right(CarsDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, ChatDataModel>> getRooms() async {
    UserModel? userModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(EndPoints.roomsUrl, queryParameters: {
        'pagination_status': "off",

      },
        options: Options(
          headers: {
            'Authorization': userModel!.data!.token,
          },
        ),);
      return Right(ChatDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, MessageDataModel>> getMessage(int user_id) async {
    UserModel? userModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(EndPoints.messagesUrl, queryParameters: {
        'pagination_status': "off",
        "user_id":user_id

      },
        options: Options(
          headers: {
            'Authorization': userModel!.data!.token,
          },
        ),);
      return Right(MessageDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, CarOptionsModel>> getCarOptions() async {
    UserModel? userModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.get(EndPoints.carOptionsUrl, queryParameters: {
        'pagination_status': "off",


      },
        options: Options(
          headers: {
            'Authorization': userModel!.data!.token,
          },
        ),);
      return Right(CarOptionsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, CarsDataModel>> getHomeFilterCars(String status,String gear_type,String manufacturing_year,String category_id,String from_price,String  to_price) async {
    CountryModel countryModel = await Preferences.instance.getcountryModel();
    try {
      final response = await dio.get(EndPoints.filterhomeUrl, queryParameters: {
        'pagination_status': "off",
        "gear_type":gear_type,
        "status":status,
        "manufacturing_year":manufacturing_year,
        "category_id":category_id,
        "from_price":from_price,
        "to_price":to_price,
        "country_id": countryModel.id
      });
      return Right(CarsDataModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, SettingData>> getSettings() async {
    try {
      final response = await dio.get(
        EndPoints.settingsUrl,
      );
      return Right(SettingData.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, UserModel>> postLogin(LoginModel model) async {
    try {
      final response = await dio.post(
        EndPoints.loginUrl,
        body: {
          'email': model.email,
          'password': model.password,
        },
      );
      return Right(UserModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, StatusResponse>> forgotPassword(String email) async {
    try {
      final response = await dio.post(
        EndPoints.forgotpasswordUrl,
        body: {
          'email': email,

        },
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, StatusResponse>> confirmcode(String email,String code) async {
    try {
      final response = await dio.post(
        EndPoints.confirmcodeUrl,
        body: {
          'email': email,
          'code': code,

        },
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, StatusResponse>> newpassword(String email,String password) async {
    try {
      final response = await dio.post(
        EndPoints.newpasswordUrl,
        body: {
          'email': email,
          'password': password,

        },
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, UserModel>> registerUser(
      RegisterModel userData) async {
    try {
      final response = await dio.post(
        EndPoints.registerUrl,
        formDataIsEnabled: true,
        body: await userData.updateToJson(),
      );
      return Right(UserModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, SingleAdModel>> addAd(
      AddAdModel userData) async {
    try {
      UserModel? userModel = await Preferences.instance.getUserModel();

      final response = await dio.post(
        EndPoints.addAdsUrl,
        formDataIsEnabled: true,
        body: await userData.updateToJson(),
        options: Options(
          headers: {
            'Authorization': userModel!.data!.token,
          },
        ),
      );
      return Right(SingleAdModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, SingleAdModel>> updateAd(
      AddAdModel userData) async {
    try {
      UserModel? userModel = await Preferences.instance.getUserModel();

      final response = await dio.post(
        EndPoints.updateAdsUrl,
        formDataIsEnabled: true,
        body: await userData.updateaddToJson(),
        options: Options(
          headers: {
            'Authorization': userModel!.data!.token,
          },
        ),
      );
      return Right(SingleAdModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, SingleMessageModel>> sendmessage(
      String text,String image,int user_id) async {
    UserModel? userModel = await Preferences.instance.getUserModel();

    try {
      final response = await dio.post(
        EndPoints.sendmessagesUrl,
        formDataIsEnabled: true,
        options: Options(
          headers: {
            'Authorization': userModel!.data!.token,
          },
        ),
        body:{
          "text": text,
"to_user_id":user_id,
          if (image.isNotEmpty) ...{
            "image": await MultipartFile.fromFile(image)
          },

        },
      );
      return Right(SingleMessageModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, SingleChatModel>> openchat(
      String text,String image,int user_id) async {
    UserModel? userModel = await Preferences.instance.getUserModel();

    try {
      final response = await dio.post(
        EndPoints.openchatUrl,
        formDataIsEnabled: true,
        options: Options(
          headers: {
            'Authorization': userModel!.data!.token,
          },
        ),
        body:{
          "text": text,
"to_user_id":user_id,
          if (image.isNotEmpty) ...{
            "image": await MultipartFile.fromFile(image)
          },

        },
      );
      return Right(SingleChatModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, ContactUsModel>> contactUsApi(
      ContactUsData contactUsData) async {
    try {
      final response = await dio.post(
        EndPoints.contactUsUrl,
        body: contactUsData.toJson(),
      );
      return Right(ContactUsModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, UserModel>>  EditProfileUser(EditProfileModel model) async {
    try {
      UserModel? userModel = await Preferences.instance.getUserModel();

      final response = await dio.post(
        EndPoints.updateuserUrl,
        formDataIsEnabled: true,
        body: await model.updateToJson(),
        options: Options(
          headers: {
            'Authorization': userModel!.data!.token,
          },
        ),
      );
      return Right(UserModel.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, StatusResponse>> deleteAccount() async {
    try {
      UserModel? userModel = await Preferences.instance.getUserModel();

      final response = await dio.post(
        EndPoints.deleteAccountUrl,
        formDataIsEnabled: true,
        options: Options(
          headers: {
            'Authorization': userModel!.data!.token,
          },
        ),
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, StatusResponse>> addDeviceToken(
      String deviceToken, String deviceType) async {
    UserModel? loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        EndPoints.addDeviceTokenUrl,
        body: {
          'token': deviceToken,
          'type': deviceType,
        },
        options: Options(
          headers: {
            'Authorization': loginModel!.data!.token,
          },
        ),
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, StatusResponse>> logout(
      String deviceToken) async {
    UserModel? loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        EndPoints.logoutUrl,
        body: {
          'token': deviceToken,

        },
        options: Options(
          headers: {
            'Authorization': loginModel!.data!.token,
          },
        ),
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
  Future<Either<Failure, StatusResponse>> deleteproduct(
      String id) async {
    UserModel? loginModel = await Preferences.instance.getUserModel();
    try {
      final response = await dio.post(
        EndPoints.deleteproductUrl,
        body: {
          'id': id,

        },
        options: Options(
          headers: {
            'Authorization': loginModel!.data!.token,
          },
        ),
      );
      return Right(StatusResponse.fromJson(response));
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
