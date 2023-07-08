import 'dart:async';

import 'package:engwheels/core/utils/toast_message_method.dart';
import 'package:engwheels/feature/addad/cubit/add_ad_cubit.dart';
import 'package:engwheels/feature/auth/confirmcode/cubit/confirm_code_cubit.dart';
import 'package:engwheels/feature/auth/forgotpassword/cubit/forgotpassword_cubit.dart';
import 'package:engwheels/feature/auth/newpassword/cubit/newpassword_cubit.dart';
import 'package:engwheels/feature/message/cubit/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

// import 'package:screenshot_callback/screenshot_callback.dart';

import 'config/routes/app_routes.dart';
import 'config/themes/app_theme.dart';
import 'core/preferences/preferences.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/app_strings.dart';
import 'package:engwheels/injector.dart' as injector;
import 'dart:developer' as developer;
import 'package:path/path.dart';

import 'feature/adDetails/cubit/ad_details_cubit.dart';
import 'feature/auth/edit_profile/cubit/editprofile_cubit.dart';
import 'feature/auth/login/cubit/login_cubit.dart';
import 'feature/auth/register/cubit/register_cubit.dart';
import 'feature/chat/cubit/chat_cubit.dart';
import 'feature/choose_country/cubit/choose_country_cubit.dart';
import 'feature/contact us/presentation/cubit/contact_us_cubit.dart';
import 'feature/home/cubit/home_cubit.dart';
import 'feature/main/cubit/mainscreens_cubit.dart';
import 'feature/my_ads/cubit/my_ads_cubit.dart';
import 'feature/news/cubit/news_cubit.dart';
import 'feature/profile/cubit/profile_cubit.dart';



class Engwheels extends StatefulWidget {
  const Engwheels({Key? key}) : super(key: key);

  @override
  State<Engwheels> createState() => _EngwheelsState();
}

class _EngwheelsState extends State<Engwheels> {



  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 25),(){
    //   setState(() {
    //     isThemes= true;
    //   });
    // });



  }

  @override
  void dispose() {
    // screenshotCallback.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    // print(text);

    Preferences.instance.savedLang(
      EasyLocalization.of(context)!.locale.languageCode,
    );
    return
       MultiBlocProvider(
       providers: [
         BlocProvider(
           create: (_) => injector.serviceLocator<MainscreensCubit>(),
         ),
         BlocProvider(
           create: (_) => injector.serviceLocator<RegisterCubit>(),
         ),
         BlocProvider(
           create: (_) => injector.serviceLocator<ChooseCountryCubit>(),
         ),
         BlocProvider(
           create: (_) => injector.serviceLocator<ContactUsCubit>(),
         ),
         BlocProvider(
           create: (_) => injector.serviceLocator<ProfileCubit>(),
         ),
         BlocProvider(
           create: (_) => injector.serviceLocator<LoginCubit>(),
         ),
         BlocProvider(
           create: (_) => injector.serviceLocator<NewsCubit>(),
         ),
         BlocProvider(
           create: (_) => injector.serviceLocator<HomeCubit>(),
         ),
         BlocProvider(
           create: (_) => injector.serviceLocator<MyAdsCubit>(),
         ),
         BlocProvider(
           create: (_) => injector.serviceLocator<AddAdCubit>(),
         ),
         BlocProvider(
           create: (_) => injector.serviceLocator<AdDetailsCubit>(),
         ),
         BlocProvider(
           create: (_) => injector.serviceLocator<ChatCubit>(),
         ),
         BlocProvider(
           create: (_) => injector.serviceLocator<MessageCubit>(),
         ),
         BlocProvider(
           create: (_) => injector.serviceLocator<ConfirmCodeCubit>(),
         ),
         BlocProvider(
           create: (_) => injector.serviceLocator<NewpasswordCubit>(),
         ),
         BlocProvider(
           create: (_) => injector.serviceLocator<ForgotpasswordCubit>(),
         ),
         BlocProvider(
           create: (_) => injector.serviceLocator<EditProfileCubit>(),
         ),

       ],
       child:
    MaterialApp(
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: appTheme(),
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      )
    )
    ;
  }
}
