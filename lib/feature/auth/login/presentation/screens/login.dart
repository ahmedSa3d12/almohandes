import 'package:engwheels/core/widgets/my_svg_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

import 'package:readmore/readmore.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../cubit/login_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool? _checking = true;
  @override
  Widget build(BuildContext context) {
    LoginCubit cubit=context.read<LoginCubit>();
    int page = 0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.black),
          centerTitle: false,
          elevation: 0,
          leadingWidth: 30,
          titleSpacing: 10,
          toolbarHeight: 50,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 16),
          )),
      body: Container(
        child: BlocBuilder<LoginCubit, LoginState>(

  builder: (context, state) {
    bool isValid = cubit.isLoginValid;
    if (state is OnLoginVaildFaild) {
      isValid = false;
    } else if (state is OnLoginVaild) {
      isValid = true;
    } else if (state is OnError) {}
    return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "welcome_you".tr(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: AppColors.black1),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "enter_your_registerd_data".tr(),
                  style: TextStyle(
                      fontSize: 14, color: AppColors.descriptionBoardingColor),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.gray3,
                      border: Border.all(color: AppColors.gray2),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: TextFormField(
                    style: TextStyle(color: AppColors.black1, fontSize: 14),
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    onChanged: (data) {
                      cubit.loginModel.email = data;
                      cubit.checkValidLoginData();
                    },  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "field_required".tr();
                    }
                    return null;
                  },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(7),
                        border: InputBorder.none,
                        hintText: "email".tr(),
                        hintStyle:
                            TextStyle(fontSize: 13, color: AppColors.black1),
                        suffixIcon: Icon(
                          Icons.mail_outline,
                          color: AppColors.primary,
                        )),

                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.gray3,
                      border: Border.all(color: AppColors.gray2),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: TextFormField(
                    style: TextStyle(color: AppColors.black1, fontSize: 14),
                    keyboardType: TextInputType.visiblePassword,
                    textAlign: TextAlign.start,
                    onChanged: (data) {
                      cubit.loginModel.password = data;
                      cubit.checkValidLoginData();
                    },

                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(7),
                        border: InputBorder.none,
                        hintText: "password".tr(),
                        hintStyle:
                            TextStyle(fontSize: 13, color: AppColors.black1),
                        suffixIcon: Icon(
                          Icons.lock_outline,
                          color: AppColors.primary,
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "field_required".tr();
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.forgotpassRoute);
                    },
                    child: Text(
                      textAlign: TextAlign.end,
                      "forgot_password".tr(),
                      style: TextStyle(fontSize: 14, color: AppColors.primary),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                CustomButton(
                  text: "login".tr(),
                  color: AppColors.primary,
                  onClick: () {
                    cubit.login(context);
                  },
               enable: isValid,
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Center(
                      child: Divider(
                        color: AppColors.unselectedTab,
                        height: 2,
                      ),
                    )),
                    SizedBox(
                      width: 6,
                    ),
                    Center(
                        child: Text(
                      "or_register_by".tr(),
                      style: TextStyle(fontSize: 13, color: AppColors.black1),
                    )),
                    SizedBox(
                      width: 6,
                    ),
                    Expanded(
                        child: Center(
                      child: Divider(
                        color: AppColors.unselectedTab,
                        height: 2,
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          //signInWithFacebook();
                      //
                          _login();
                        },
                        child: Container(
                          height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: AppColors.blueColor4),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,

                                  children: [
                                    MySvgWidget(
                                        path: ImageAssets.facebookIcon,
                                        imageColor: AppColors.white,
                                        size: 15),
                                    SizedBox(width: 0,),
                                    Text("facebook_account".tr(),style: TextStyle(fontSize: 14,color: AppColors.white),),

                                  ],
                                ),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          signInWithGoogle(context: context);
                        },
                        child: Container(
                          height: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: AppColors.redcolor1),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MySvgWidget(
                                        path: ImageAssets.googleIcon,
                                        imageColor: AppColors.white,
                                        size: 15),
                                    SizedBox(width: 4,),
                                    Text("google_account".tr(),style: TextStyle(fontSize: 14,color: AppColors.white),),

                                  ],
                                ),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Center(
                  child:
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.registerRoute);
                    },
                    child: RichText(

                      text: TextSpan(
                        text: 'no_account'.tr(),
                        style: TextStyle(
                             color: AppColors.black1,fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'register'.tr(),
                              style: TextStyle(
                                  color: AppColors.primary,fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  },
),
      ),
    );
  }
  // Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
print(user!.displayName!);
    return user;
  }
  _login() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      _accessToken = loginResult.accessToken;
      final userInfo = await FacebookAuth.instance.getUserData();
      print('ResultStatus:');

      print('ResultStatus: ${loginResult.status}');

      _userData = userInfo;
      print(_userData.toString());
    } else {
      print('ResultStatus: ${loginResult.status}');
      print('Message: ${loginResult.message}');
    }
  }
}
