
import 'package:engwheels/core/models/chat_data_model.dart';
import 'package:engwheels/core/models/new_model.dart';
import 'package:engwheels/feature/addad/presentation/screens/add_ad.dart';
import 'package:engwheels/feature/auth/confirmcode/presentation/screens/confirm_code.dart';
import 'package:engwheels/feature/auth/forgotpassword/presentation/screens/forgot_password.dart';
import 'package:engwheels/feature/auth/login/presentation/screens/login.dart';
import 'package:engwheels/feature/choose_country/presentation/screens/choose_country.dart';
import 'package:engwheels/feature/main/presentation/screens/mainScreen.dart';
import 'package:engwheels/feature/my_ads/presentation/screens/my_ads_screen.dart';
import 'package:engwheels/feature/news_detials/presentation/screens/news_details_screen.dart';
import 'package:flutter/material.dart';


import '../../core/models/cars_model.dart';
import '../../core/utils/app_strings.dart';

import '../../feature/adDetails/presentation/screens/addetails.dart';
import '../../feature/auth/edit_profile/presentation/screens/edit_profile.dart';
import '../../feature/auth/newpassword/presentation/screens/new_password.dart';
import '../../feature/auth/register/presentation/screens/register.dart';
import '../../feature/contact us/presentation/screens/contact_us.dart';
import '../../feature/message/presentation/screens/messge_screen.dart';
import '../../feature/privacy_terms_screen/privacy_terms_page.dart';
import '../../feature/splash/presentation/screens/splash_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String chooseCountryRoute = 'chooseCountry';
  static const String mainRoute = 'mainScreen';
  static const String newsDetailsRoute = 'newsDetails';
  static const String myAdsRoute = 'myAds';
  static const String adAdsRoute = 'adAds';
  static const String AddetialsRoute = 'adDetials';
  static const String loginRoute = 'login';
  static const String registerRoute = 'register';
  static const String editProfileRoute = 'editProfile';
  static const String forgotpassRoute = 'forgotpass';
  static const String confirmCodeRoute = 'confirmCode';
  static const String newpassRoute = 'newpass';
  static const String contactusRoute = 'contactus';
  static const String privacyRoute = 'privacy';
  static const String messageRoute = 'message';

}

class AppRoutes {
  static String route = '';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
        case Routes.chooseCountryRoute:
        return MaterialPageRoute(
          builder: (context) => const ChooseCountry(),
        );
        case Routes.contactusRoute:
        return MaterialPageRoute(
          builder: (context) =>  ContactUsScreen(),
        );
      case Routes.privacyRoute:
        String uri =
        settings.arguments as String;

        return MaterialPageRoute(
            builder: (context) =>
                PrivacyTermsPage(url: uri,));
        case Routes.newsDetailsRoute:
          NewsData newsModel=settings.arguments as NewsData;
        return MaterialPageRoute(
          builder: (context) =>  NewsDetailsScreen(newsModel:newsModel),
        );
        case Routes.messageRoute:
          ChatModel chatModel=settings.arguments as ChatModel;
        return MaterialPageRoute(
          builder: (context) =>  MessgeScreen( chatModel:chatModel ,),
        );
        case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
        case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
        case Routes.editProfileRoute:
        return MaterialPageRoute(
          builder: (context) => const EditProfileScreen(),
        );
        case Routes.forgotpassRoute:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );
        case Routes.confirmCodeRoute:
        return MaterialPageRoute(
          builder: (context) => const ConfirmCodeScreen(),
        );
        case Routes.newpassRoute:
        return MaterialPageRoute(
          builder: (context) =>  NewPasswordScreen(),
        );
   case Routes.mainRoute:
        return MaterialPageRoute(
          builder: (context) => const MainScreens(),
        );
        case Routes.myAdsRoute:
        return MaterialPageRoute(
          builder: (context) => const MyAdsScreen(),
        );
        case Routes.adAdsRoute:
          dynamic
          carsModel=settings.arguments as dynamic;

          return MaterialPageRoute(
          builder: (context) =>  AddAdScreen(carsModel: carsModel,),
        );
        case Routes.AddetialsRoute:
          CarsModel carsModel=settings.arguments as CarsModel;
        return MaterialPageRoute(

          builder: (context) =>  AddetialsScreen(carsModel: carsModel,),
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
