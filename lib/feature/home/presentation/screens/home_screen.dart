import 'package:engwheels/core/widgets/my_svg_widget.dart';
import 'package:engwheels/feature/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' ;

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/utils/hex_color.dart';
import '../../../profile/cubit/profile_cubit.dart';
import '../../widget/filter_home_cars.dart';
import '../../widget/home_cars.dart';
import '../../widget/industry_year.dart';
import '../../widget/model.dart';
import '../../widget/price.dart';
import '../../widget/spare_type.dart';
import '../../widget/status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit=context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.white,
      appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(ImageAssets.logoblackImage),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  leading: Container(),
                  leadingWidth: 0,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Column(
                        children: [
                      InkWell(
                        onTap: () {
                  if(context.read<ProfileCubit>().userModel!=null){
                  Navigator.pushNamed(context, Routes.adAdsRoute,arguments: null);}
                  else{
                  Navigator.pushNamed(context, Routes.loginRoute);
                  }                        },
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height:  MediaQuery
                        .of(context)
                        .size
                        .height/3.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              gradient: LinearGradient(colors: [
                                AppColors.black.withOpacity(.4),
                                AppColors.gray5
                              ])),
                          child: Stack(
                            children: [
                              Positioned(
                                child: Image.asset(ImageAssets.circleImage),
                                top: .1,
                                left: .1,
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width/2.2,
                                          child: Text(
                                            ("youcanadd".tr()),
                                            style: TextStyle(
                                                color: AppColors.unselectedTab,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.black1,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16.0, horizontal: 30),
                                          child: Row(
                                            children: [
                                              Text(
                                                "add_car".tr(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: AppColors.white),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              MySvgWidget(
                                                  path: ImageAssets.carIcon,
                                                  imageColor: AppColors.primary,
                                                  size: 20)
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 29),
                                    child: Image.asset(
                                      ImageAssets.carImage,
                                    width: MediaQuery.of(context).size.width/2.5,

                                      height: 150,
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Image.asset(ImageAssets.newcarImage),
                          SizedBox(
                            width: 7,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "recent_car".tr(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: AppColors.black1),
                              ),
                              Text(
                                "see_new_car".tr(),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.descriptionBoardingColor),
                              )
                            ],
                          )
                        ],
                      ),
                      Container(
                        height: 260,
                        child: HomeCar(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ]),
                  ),

                  // pinned: true,
                  backgroundColor: AppColors.white,
                  expandedHeight:  MediaQuery.of(context).size.height/1.38,


                  centerTitle: true,
                )
              ];
            },
            body: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  height: 140,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(ImageAssets.filtercarImage),
                            SizedBox(
                              width: 7,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "all_car".tr(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: AppColors.black1),
                                ),
                                Text(
                                  "user_filter".tr(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.descriptionBoardingColor),
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                           children: [
                              InkWell(

                                child: Container(
                                  height: 30,
                                  decoration:
                                  BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        MySvgWidget(path: ImageAssets.car1Icon, imageColor: AppColors.primary, size: 20),
                                        SizedBox(width: 4,),
                                        Text("status".tr(),style: TextStyle(fontSize: 12,color: AppColors.black1),),
                                        SizedBox(width: 4,),
                                        Icon(Icons.keyboard_arrow_down_sharp,color: AppColors.descriptionBoardingColor,),
                                        SizedBox(width: 2,),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  showMaterialModalBottomSheet(
                                    context: context,
                                    expand: true,

                                    backgroundColor: AppColors.transparent1,

                                    builder: (context) => Container(
                                      margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.8),

                                        child: Status()),
                                  );
                                },
                              ),
                             SizedBox(width: 10,),
                             InkWell(
                               onTap: () {
                                 showMaterialModalBottomSheet(
                                   context: context,
                                   expand: true,

                                   backgroundColor: AppColors.transparent1,

                                   builder: (context) => Container(
                                       margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.8),

                                       child: CarModel()),
                                 );
                               },
                               child: Container(
                                  height: 30,
                                  decoration:
                                  BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        MySvgWidget(path: ImageAssets.modelIcon, imageColor: AppColors.primary, size: 20),
                                        SizedBox(width: 4,),
                                        Text("brand".tr(),style: TextStyle(fontSize: 12,color: AppColors.black1),),
                                        SizedBox(width: 4,),
                                        Icon(Icons.keyboard_arrow_down_sharp,color: AppColors.descriptionBoardingColor,),
                                        SizedBox(width: 2,),
                                      ],
                                    ),
                                  ),
                                ),
                             ),
                             SizedBox(width: 10,),
                             InkWell(
                               onTap: () {
                                 showMaterialModalBottomSheet(
                                   context: context,
                                   expand: true,

                                   backgroundColor: AppColors.transparent1,

                                   builder: (context) => Container(
                                       margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.8),

                                       child: Price()),
                                 );
                               },
                               child: Container(
                                  height: 30,
                                  decoration:
                                  BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        MySvgWidget(path: ImageAssets.wallet1Icon, imageColor: AppColors.primary, size: 20),
                                        SizedBox(width: 4,),
                                        Text("price".tr(),style: TextStyle(fontSize: 12,color: AppColors.black1),),
                                        SizedBox(width: 4,),
                                        Icon(Icons.keyboard_arrow_down_sharp,color: AppColors.descriptionBoardingColor,),
                                        SizedBox(width: 2,),
                                      ],
                                    ),
                                  ),
                                ),
                             ),
                             SizedBox(width: 10,),
                             InkWell(
                               onTap: () {
                                 showMaterialModalBottomSheet(
                                   context: context,
                                   expand: true,

                                   backgroundColor: AppColors.transparent1,

                                   builder: (context) => Container(
                                       margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.8),

                                       child: SpareType()),
                                 );
                               },
                               child: Container(
                                  height: 30,
                                  decoration:
                                  BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        MySvgWidget(path: ImageAssets.car1Icon, imageColor: AppColors.primary, size: 20),
                                        SizedBox(width: 4,),
                                        Text("spare_type".tr(),style: TextStyle(fontSize: 12,color: AppColors.black1),),
                                        SizedBox(width: 4,),
                                        Icon(Icons.keyboard_arrow_down_sharp,color: AppColors.descriptionBoardingColor,),
                                        SizedBox(width: 2,),
                                      ],
                                    ),
                                  ),
                                ),
                             ),
                             SizedBox(width: 10,),
                             InkWell(
                               onTap: () {
                                 showMaterialModalBottomSheet(
                                   context: context,
                                   expand: true,

                                   backgroundColor: AppColors.transparent1,

                                   builder: (context) => Container(
                                       margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/1.8),

                                       child: IndustryYear()),
                                 );
                               },
                               child: Container(
                                  height: 30,
                                  decoration:
                                  BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(15))
                                  ),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        MySvgWidget(path: ImageAssets.car1Icon, imageColor: AppColors.primary, size: 20),
                                        SizedBox(width: 4,),
                                        Text("industry_year".tr(),style: TextStyle(fontSize: 12,color: AppColors.black1),),
                                        SizedBox(width: 4,),
                                        Icon(Icons.keyboard_arrow_down_sharp,color: AppColors.descriptionBoardingColor,),
                                        SizedBox(width: 2,),
                                      ],
                                    ),
                                  ),
                                ),
                             ),
                             SizedBox(width: 10,),
                            ]

                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.gray2,
                  ),
                ),
              FilterCars(),
              ],
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
