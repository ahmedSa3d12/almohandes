import 'dart:async';
import 'package:engwheels/core/preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/models/country_model.dart';
import '../../../../core/utils/app_colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Timer _timer;

  _goNext() async {
   CountryModel countryModel=await Preferences.instance.getcountryModel();
   if(countryModel.id!=0){
     Navigator.pushNamed(context, Routes.mainRoute);
   }
   else{
     Navigator.pushNamed(context, Routes.chooseCountryRoute);
   }
//
    // _getStoreUser();
  }

  _startDelay() async {
    _timer = Timer(
      const Duration(milliseconds: 2500),
      () {
        // Preferences.instance.clearUserData();
        _goNext();
      },
    );
  }

  Future<void> _getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   // UserModel userModel = await Preferences.instance.getUserModel();

  }

  @override
  void initState() {
    super.initState();
    // context.read<SplashCubit>().getAdsOfApp();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

        return Scaffold(

          body:
             Stack(
               children: [
                 Positioned(
                     bottom: 0,
                     top: 0,
                     right: 0,
                     left: 0,
                     child:
                     Column(children: [
                       Expanded(child:   Center(
                     child: Hero(
                       tag: 'logo',
                       child: SizedBox(
                         // width: 300,
                         // height: 300,
                         child: Image.asset('assets/images/logo.png'),
                       ),
                     ),
             )),

                       Hero(
                         tag: 'logo',
                         child: Container(


                           width: MediaQuery.of(context).size.width,

                           child: Image.asset('assets/images/splash_background.png',width: MediaQuery.of(context).size.width,
                               fit: BoxFit.fitWidth),
                         ),
                       )
                     ],),





             )])
          ,
          backgroundColor: AppColors.primary,
        );

  }
}
