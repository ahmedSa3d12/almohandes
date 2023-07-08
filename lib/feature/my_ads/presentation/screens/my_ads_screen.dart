import 'package:cached_network_image/cached_network_image.dart';
import 'package:engwheels/core/widgets/my_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/widgets/no_data_widget.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../../cubit/my_ads_cubit.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({Key? key}) : super(key: key);

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  @override
  Widget build(BuildContext context) {
    MyAdsCubit cubit=context.read<MyAdsCubit>();
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.black),
          centerTitle: false,
          elevation: 0,
          leadingWidth: 30,
          titleSpacing: 10,
          toolbarHeight: 90,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 16),
            child: Text(
              'my_ads'.tr(),
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )),
      body: Padding(
          padding: EdgeInsets.all(8.0),
          child: BlocBuilder<MyAdsCubit, MyAdsState>(
  builder: (context, state) {
    if(state is MyCarsLoading){
    return ShowLoadingIndicator();
    }
    else if(state is MyCarsError){
    return NoDataWidget(onclick: () {
    cubit.getMyAds();
    }, title: "no_data".tr());
    }
    else{
    if(cubit.cars.isNotEmpty) {

    return ListView.builder(
            shrinkWrap: true,
            itemCount: cubit.cars.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.AddetialsRoute,arguments: cubit.cars.elementAt(index));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.gray2,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Center(
                                child:
                                Container(
                                  width: 96,
                                  height: 96,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15)),
                                  ),
                                  child:cubit.cars.elementAt(index).image!=null?
                                  CachedNetworkImage(
                                    width: 96,
                                    height: 96,
                                    fit: BoxFit.fitWidth,
                                    imageBuilder: (context, imageProvider) => Container(


                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        image: DecorationImage(
                                            image: imageProvider, fit: BoxFit.cover),
                                      ),
                                    ),
                                    imageUrl: EndPoints.baseUrl.replaceAll("/api", "")+cubit.cars.elementAt(index).image!,):Container(),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width-150,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Text(
                                            EasyLocalization.of(context)!.currentLocale!.languageCode=='ar'?
                                            cubit.cars.elementAt(index).category.titleAr+" "+cubit.cars.elementAt(index).subCategory.titleAr:
                                            cubit.cars.elementAt(index).category.titleEn+" "+cubit.cars.elementAt(index).subCategory.titleEn,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: AppColors.black1),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          MySvgWidget(
                                              path: ImageAssets.walletIcon,
                                              imageColor:
                                                  AppColors.descriptionBoardingColor,
                                              size: 20),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: cubit.cars.elementAt(index).price.toString(),
                                              style: TextStyle(
                                                  color: AppColors.primary,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              children: [
                                                TextSpan(
                                                    text: "qar".tr(),
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .descriptionBoardingColor,
                                                        fontSize: 13))
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 30,),

                          Row(children: [
                            Expanded(child: Divider(color: AppColors.unselectedTab,
                            height: 2,)),
                            SizedBox(width: 4),
                            Expanded(child: Divider(color: AppColors.unselectedTab,height: 2,)),
                          ],),
                          SizedBox(height: 20,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  cubit.deleteProduct(cubit.cars.elementAt(index).id, index);
                                },
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: MySvgWidget(
                                            path: ImageAssets.removeIcon,
                                            imageColor: AppColors.black1,
                                            size: 15),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "remove".tr(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.black1),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 4,),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, Routes.adAdsRoute,arguments:cubit.cars.elementAt(index));
                                },
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: MySvgWidget(
                                            path: ImageAssets.editIcon,
                                            imageColor: AppColors.black1,
                                            size: 15),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "edit".tr(),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColors.black1),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );}
    else{
      return NoDataWidget(onclick: () {
        cubit.getMyAds();
      }, title: "no_data".tr());
    }
  }},
)),
    );
  }
}
