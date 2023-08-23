import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:engwheels/core/preferences/preferences.dart';
import 'package:engwheels/core/widgets/my_svg_widget.dart';
import 'package:engwheels/feature/profile/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import 'package:readmore/readmore.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../auth/edit_profile/cubit/editprofile_cubit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  PackageInfo? packageInfo;
  @override
  Widget build(BuildContext context) {
    String lang=EasyLocalization.of(context)!.currentLocale!.languageCode;
    ProfileCubit cubit=context.read<ProfileCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leadingWidth: MediaQuery.of(context).size.width,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              'profile'.tr(),
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                cubit.userModel!=null&&cubit.userModel!.data!=null? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child:
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(15)),
                        ),
                        child:cubit.userModel!.data!.photo!=null?
                        CachedNetworkImage(
                          width: 64,
                          height: 64,
                          fit: BoxFit.fitWidth,
                          imageBuilder: (context, imageProvider) => Container(


                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                          ),
                          imageUrl: EndPoints.baseUrl.replaceAll("/api", "")+cubit.userModel!.data!.photo,):Container(),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'welcome'.tr(),
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.descriptionBoardingColor,
                              ),
                            ),
                            Text(
                              cubit.userModel!.data!.name,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.black1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<EditProfileCubit>().editData();
                        Navigator.pushNamed(context, Routes.editProfileRoute);

                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                            color: AppColors.thirdPrimary,
                            borderRadius: BorderRadius.all(Radius.circular(16))),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(
                              Icons.edit,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ):Container(),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if(context.read<ProfileCubit>().userModel!=null){
                            Navigator.pushNamed(context, Routes.adAdsRoute,arguments: null);}
                          else{
                            Navigator.pushNamed(context, Routes.loginRoute);
                          }                        },
                        child:
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: AppColors.thirdPrimary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(ImageAssets.addAdImage),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'add_ad'.tr(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.black1,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if(context.read<ProfileCubit>().userModel!=null){
                          Navigator.pushNamed(context, Routes.myAdsRoute);}
                          else{
                            Navigator.pushNamed(context, Routes.loginRoute);
                          }
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: AppColors.thirdPrimary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(ImageAssets.myadsImage),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  'my_ads'.tr(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.black1,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.gray2,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        InkWell(

                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Center(
                                      child: MySvgWidget(
                                          path: ImageAssets.contactIcon,
                                          imageColor: AppColors.primary,
                                          size: 30),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        "contact_us".tr(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.black1),
                                      ),
                                    )
                                  ],
                                ),
                                Transform.rotate(

                                  angle: lang == 'en' ? (3.14) : 0,
                                  child: MySvgWidget(
                                      path: ImageAssets.arrowIcon,
                                      imageColor: AppColors.black1,
                                      size: 15),
                                ),
                              ],
                            ),
                            height: 70,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, Routes.contactusRoute);
                          },
                        ),
                        InkWell(
                          onTap: () {
                            Preferences.instance.getSavedLang().then(
                                  (value) {
                                    String lang=value;
                          value == 'ar' ? 'en' : 'ar';
                                Preferences.instance.savedLang(value);
                                lang == 'ar'
                                    ? EasyLocalization.of(context)!.setLocale(const Locale('en'))
                                    : EasyLocalization.of(context)!.setLocale(const Locale('ar'));
                              },
                            );
                            Navigator.pushReplacementNamed(context, Routes.initialRoute);
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Center(
                                      child: MySvgWidget(
                                          path: ImageAssets.worldIcon,
                                          imageColor: AppColors.primary,
                                          size: 30),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        "language".tr(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.black1),
                                      ),
                                    )
                                  ],
                                ),
                                Transform.rotate(

                                  angle: lang == 'en' ? (3.14) : 0,
                                child: MySvgWidget(
                                      path: ImageAssets.arrowIcon,
                                      imageColor: AppColors.black1,
                                      size: 15),
                                ),
                              ],
                            ),
                            height: 70,
                          ),
                        ),
                        InkWell(
                          onTap: () {

                            Navigator.pushReplacementNamed(context, Routes.chooseCountryRoute);
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Center(
                                      child: MySvgWidget(
                                          path: ImageAssets.worldIcon,
                                          imageColor: AppColors.primary,
                                          size: 30),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        "change_country".tr(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.black1),
                                      ),
                                    )
                                  ],
                                ),
                                Transform.rotate(

                                  angle: lang == 'en' ? (3.14) : 0,
                                child: MySvgWidget(
                                      path: ImageAssets.arrowIcon,
                                      imageColor: AppColors.black1,
                                      size: 15),
                                ),
                              ],
                            ),
                            height: 70,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            rateApp();
                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Center(
                                      child: MySvgWidget(
                                          path: ImageAssets.rateIcon,
                                          imageColor: AppColors.primary,
                                          size: 30),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        "rate_app".tr(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.black1),
                                      ),
                                    )
                                  ],
                                ),
                    Transform.rotate(

                      angle: lang == 'en' ? (3.14) : 0,
                      child: MySvgWidget(
                            path: ImageAssets.arrowIcon,
                            imageColor: AppColors.black1,
                            size: 15),
                    ),

                              ],
                            ),
                            height: 70,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.privacyRoute,arguments: context.read<ProfileCubit>().settings!.data.privacy);

                          },
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Center(
                                      child: MySvgWidget(
                                          path: ImageAssets.privacyIcon,
                                          imageColor: AppColors.primary,
                                          size: 30),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        "privacy".tr(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.black1),
                                      ),
                                    )
                                  ],
                                ),
                                Transform.rotate(

                                  angle: lang == 'en' ? (3.14) : 0,
                                  child: MySvgWidget(
                                      path: ImageAssets.arrowIcon,
                                      imageColor: AppColors.black1,
                                      size: 15),
                                ),

                              ],
                            ),
                            height: 70,
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.privacyRoute,arguments: context.read<ProfileCubit>().settings!.data.termsLink);

                            },
                            child:Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Center(
                                    child: MySvgWidget(
                                        path: ImageAssets.termsIcon,
                                        imageColor: AppColors.primary,
                                        size: 30),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Center(
                                    child: Text(
                                      "terms_condition".tr(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.black1),
                                    ),
                                  )
                                ],
                              ),
                              Transform.rotate(

                                angle: lang == 'en' ? (3.14) : 0,
                                child: MySvgWidget(
                                    path: ImageAssets.arrowIcon,
                                    imageColor: AppColors.black1,
                                    size: 15),
                              ),

                            ],
                          ),
                          height: 70,
                        )),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.privacyRoute,arguments: context.read<ProfileCubit>().settings!.data.privacy);

                          },
                          child: InkWell(
                            onTap: () {
                              Alert(
                                context: context,
                                type: AlertType.warning,
                                title: "\n" + "delete_account".tr(),
                                desc: "\n\n" +
                                    "waring_delete_account_message".tr() +
                                    "\n\n",
                                buttons: [
                                  DialogButton(
                                    onPressed: () => Navigator.pop(context),
                                    color: AppColors.primary,
                                    child: Text(
                                      "cancel".tr(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  DialogButton(
                                    onPressed: () =>
                                        cubit.deleteAccount(context),
                                    color: AppColors.error,
                                    child: Text(
                                      "confirm".tr(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  )
                                ],
                              ).show();
                            },
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Center(
                                        child: MySvgWidget(
                                            path: ImageAssets.deleteuserIcon,
                                            imageColor: AppColors.primary,
                                            size: 30),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "delete_account".tr(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.primary),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              height: 70,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'follow_us_social_media'.tr(),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.descriptionBoardingColor,
                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  InkWell(
                    onTap: () {
                      _openSocialUrl(  url: context.read<ProfileCubit>().settings!.data.facebook);
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(shape: BoxShape.circle,
                      border: Border.all(color: AppColors.unselectedTab)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MySvgWidget(imageColor: AppColors.descriptionBoardingColor,path: ImageAssets.facebookIcon,size: 15,),
                      ),
                    ),
                  ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        _openSocialUrl(  url: context.read<ProfileCubit>().settings!.data.facebook);
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(shape: BoxShape.circle,
                            border: Border.all(color: AppColors.unselectedTab)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MySvgWidget(imageColor: AppColors.descriptionBoardingColor,path: ImageAssets.instegramIcon,size: 15,),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        _openSocialUrl(  url: context.read<ProfileCubit>().settings!.data.twitter);
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(shape: BoxShape.circle,
                            border: Border.all(color: AppColors.unselectedTab)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MySvgWidget(imageColor: AppColors.descriptionBoardingColor,path: ImageAssets.twitterIcon,size: 15,),
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                        onTap: () {
                          _openSocialUrl(  url: context.read<ProfileCubit>().settings!.data.facebook);
                        },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(shape: BoxShape.circle,
                            border: Border.all(color: AppColors.unselectedTab)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MySvgWidget(imageColor: AppColors.descriptionBoardingColor,path: ImageAssets.snapchatIcon,size: 15,),
                        ),
                      ),
                    )
                ],),
                SizedBox(height: 50,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 90.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        cubit.logout(context);
                      },
                      child: Container(
height: 50,
                        decoration: BoxDecoration(border: Border.all(color: AppColors.descriptionBoardingColor),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.power_settings_new,color: AppColors.descriptionBoardingColor,),
                                SizedBox(width: 8,),
                                Text(
                                  'logout'.tr(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.descriptionBoardingColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }
  rateApp() async {
    //print(packageInfo!.packageName);
    if(Platform.isIOS){
      Uri uri = Uri.parse("https://apps.apple.com/us/app/${packageInfo!.packageName}");

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri,
            mode: LaunchMode.externalApplication);

      }}
    else{
      StoreRedirect.redirect(
          androidAppId: packageInfo!.packageName,
          iOSAppId: "1671488623");}
    // showDialog(
    //   context: context,
    //   builder: (context) => _dialog!,
    // );
    // LaunchReview.launch(
    //
    // );
    // initPlatformState();
    // AdvancedInAppReview()
    //     .setMinDaysBeforeRemind(7)
    //     .setMinDaysAfterInstall(2)
    //     .setMinLaunchTimes(2)
    //     .setMinSecondsBeforeShowDialog(4)
    //     .monitor();
    // if (await inAppReview.isAvailable()) {
    //   inAppReview.requestReview();
    // }

    //
    // RateMyApp rateMyApp = RateMyApp(
    //
    //
    // );
    // //
    //  rateMyApp.init().then((value) async =>
    // {if(rateMyApp.shouldOpenDialog) {
    //  rateMyApp.showRateDialog(
    //
    //   context,
    //   title: 'Rate this app',
    //   message: 'If you like this app, please take a little bit of your time to review it !\nIt really helps us and it shouldn\'t take you more than one minute.',
    //   rateButton: 'RATE',
    //   noButton: 'NO THANKS',
    //   laterButton: 'MAYBE LATER',
    //  )
    // }
    // else{
    //   should=  (await rateMyApp.isNativeReviewDialogSupported)!,
    //   if(should){
    //    await rateMyApp.launchNativeReviewDialog()}
    //   else{
    //    rateMyApp.launchStore()
    //   }
    //   // print("ddkdkkdkdkjfj")
    //  }});
  }
  @override
  void initState() {
    super.initState();
    setuppackage();
  }

  Future<void> setuppackage() async {
    packageInfo = await PackageInfo.fromPlatform();
    // _dialog = RatingDialog(
    //   // your app's name?
    //   title: Text('rate'.tr()),
    //   // encourage your user to leave a high rating?
    //   enableComment: false,
    //   // your app's logo?
    //   // image: const FlutterLogo(size: 60),
    //   submitButtonText: 'confirm'.tr(),
    //   onCancelled: () => print('cancelled'),
    //   onSubmitted: (response) {
    //
    //     // print('rating: ${response.rating}, comment: ${response.comment}');
    //     // TODO: add your own logic
    //     StoreRedirect.redirect(
    //         androidAppId: packageInfo!.packageName,
    //         iOSAppId: packageInfo!.packageName);
    //   },
    // );
  }
  void _openSocialUrl({required String url}) async {
    Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'invalidUrl'.tr(),
          style: const TextStyle(fontSize: 18.0),
        ),
        backgroundColor: AppColors.primary,
        elevation: 8.0,
        duration: const Duration(seconds: 3),
      ));
    }
  }

}
