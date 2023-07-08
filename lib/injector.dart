import 'package:dio/dio.dart';
import 'package:engwheels/feature/adDetails/cubit/ad_details_cubit.dart';
import 'package:engwheels/feature/addad/cubit/add_ad_cubit.dart';
import 'package:engwheels/feature/auth/confirmcode/cubit/confirm_code_cubit.dart';
import 'package:engwheels/feature/auth/edit_profile/cubit/editprofile_cubit.dart';
import 'package:engwheels/feature/auth/forgotpassword/cubit/forgotpassword_cubit.dart';
import 'package:engwheels/feature/auth/newpassword/cubit/newpassword_cubit.dart';
import 'package:engwheels/feature/chat/cubit/chat_cubit.dart';
import 'package:engwheels/feature/home/cubit/home_cubit.dart';
import 'package:engwheels/feature/message/cubit/message_cubit.dart';
import 'package:engwheels/feature/my_ads/cubit/my_ads_cubit.dart';
import 'package:engwheels/feature/news/cubit/news_cubit.dart';
import 'package:engwheels/feature/profile/cubit/profile_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/app_interceptors.dart';
import 'core/api/base_api_consumer.dart';
import 'core/api/dio_consumer.dart';
import 'core/remote/service.dart';
import 'feature/auth/login/cubit/login_cubit.dart';
import 'feature/auth/register/cubit/register_cubit.dart';
import 'feature/choose_country/cubit/choose_country_cubit.dart';
import 'feature/contact us/presentation/cubit/contact_us_cubit.dart';
import 'feature/main/cubit/mainscreens_cubit.dart';


final serviceLocator = GetIt.instance;

Future<void> setup() async {
  //! Features

  ///////////////////////// Blocs ////////////////////////

  serviceLocator.registerFactory(
        () => MainscreensCubit(

    ),
  );
  serviceLocator.registerFactory(
        () => RegisterCubit(
            serviceLocator()
    ),
  );
  serviceLocator.registerFactory(
        () => NewsCubit(
            serviceLocator()
    ),
  );
  serviceLocator.registerFactory(
        () => HomeCubit(
            serviceLocator()
    ),
  );
  serviceLocator.registerFactory(
        () => MyAdsCubit(
            serviceLocator()
    ),
  );
  serviceLocator.registerFactory(
        () => ChatCubit(
            serviceLocator()
    ),
  );
  serviceLocator.registerFactory(
        () => ConfirmCodeCubit(
            serviceLocator()
    ),
  ); serviceLocator.registerFactory(
        () => NewpasswordCubit(
            serviceLocator()
    ),
  ); serviceLocator.registerFactory(
        () => ForgotpasswordCubit(
            serviceLocator()
    ),
  );
  serviceLocator.registerFactory(
        () => EditProfileCubit(
            serviceLocator()
    ),
  );
  serviceLocator.registerFactory(
        () => AdDetailsCubit(

    ),
  );
  serviceLocator.registerFactory(
        () => MessageCubit(
            serviceLocator()
    ),
  );
  serviceLocator.registerFactory(
        () => AddAdCubit(
            serviceLocator()
    ),
  );
  serviceLocator.registerFactory(
        () => ChooseCountryCubit(
            serviceLocator()

    ),
  );
  serviceLocator.registerFactory(
        () => LoginCubit(
            serviceLocator()

    ),
  );
  serviceLocator.registerFactory(
        () => ProfileCubit(
            serviceLocator()

    ),
  );
  serviceLocator.registerFactory(
        () => ContactUsCubit(
            serviceLocator()

    ),
  );

  ///////////////////////////////////////////////////////////////////////////////

  //! External
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);

  serviceLocator.registerLazySingleton(() => ServiceApi(serviceLocator()));

  serviceLocator.registerLazySingleton<BaseApiConsumer>(
      () => DioConsumer(client: serviceLocator()));
  serviceLocator.registerLazySingleton(() => AppInterceptors());

  // Dio
  serviceLocator.registerLazySingleton(
    () => Dio(
      BaseOptions(
        contentType: "application/x-www-form-urlencoded",
        headers: {
          "Accept": "application/json",
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );
}
