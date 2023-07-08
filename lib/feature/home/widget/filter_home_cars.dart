import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:engwheels/feature/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/api/end_points.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/assets_manager.dart';
import '../../../core/widgets/my_svg_widget.dart';
import '../../../core/widgets/no_data_widget.dart';
import '../../../core/widgets/show_loading_indicator.dart';

class FilterCars extends StatelessWidget {
  const FilterCars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeFilterCarsLoading) {
          return ShowLoadingIndicator();
        } else if (state is HomeFilterCarsError) {
          return NoDataWidget(
              onclick: () {
                cubit.getFilterHome();
              },
              title: "no_data".tr());
        } else {
          if (cubit.carsFilter.isNotEmpty) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: cubit.carsFilter.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.AddetialsRoute,arguments: cubit.carsFilter.elementAt(index));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 280,
                        child: Stack(
                          children: [
                            Positioned(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                child: cubit.cars.elementAt(index).image != null
                                    ? CachedNetworkImage(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 160,
                                        fit: BoxFit.fitWidth,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        imageUrl: EndPoints.baseUrl
                                                .replaceAll("/api", "") +
                                            cubit.cars.elementAt(index).image!,
                                      )
                                    : Container(),
                              ),
                              top: 0,
                              bottom: 25,
                              right: 0,
                              left: 0,
                            ),
                            Positioned(
                                right: 20,
                                bottom: 0,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle),
                                          child: cubit.cars
                                                      .elementAt(index)
                                                      .user!
                                                      .photo !=
                                                  null
                                              ? CachedNetworkImage(
                                                  width: 40,
                                                  height: 40,
                                                  fit: BoxFit.fitWidth,
                                                  imageBuilder: (context,
                                                          imageProvider) =>
                                                      Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: imageProvider,
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  imageUrl: EndPoints.baseUrl
                                                          .replaceAll(
                                                              "/api", "") +
                                                      cubit.cars
                                                          .elementAt(index)
                                                          .user!.photo,
                                                )
                                              : Container(),
                                        ),
                                        Text(
                                          cubit.cars
                                              .elementAt(index)
                                              .user!.name,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors
                                                  .descriptionBoardingColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: AppColors.gray2,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(
                                          color: AppColors.white, width: 4)),
                                  width: 150,
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                            EasyLocalization.of(context)!.currentLocale!.languageCode=='ar'?
                            cubit.cars.elementAt(index).category.titleAr+" "+cubit.cars.elementAt(index).subCategory.titleAr:
                            cubit.cars.elementAt(index).category.titleEn+" "+cubit.cars.elementAt(index).subCategory.titleEn,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: AppColors.black1),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cubit.carsFilter.elementAt(index).data.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index1) {
                            return
                              Row(
                              children: [
                                SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.gray2,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4))),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        cubit.carsFilter.elementAt(index).data.elementAt(index1).value,
                                        style: TextStyle(
                                            fontSize: 14, color: AppColors.black1),
                                      ),
                                    ),
                                  ),
                                  height: 50,
                                ),

                              ],
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            );
                        },

                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  MySvgWidget(
                                      path: ImageAssets.flagIcon,
                                      imageColor:
                                          AppColors.descriptionBoardingColor,
                                      size: 20),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                   EasyLocalization.of(context)!.currentLocale!.languageCode=="ar"?cubit.carsFilter.elementAt(index).country.titleAr:cubit.carsFilter.elementAt(index).country.titleEn,
                                    style: TextStyle(
                                      color: AppColors.black1,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                      height: 20,
                                      width: 20, imageUrl:cubit.carsFilter.elementAt(index).country.image,),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    EasyLocalization.of(context)!.currentLocale!.languageCode=="ar"?cubit.carsFilter.elementAt(index).governorate.governorateNameAr:cubit.carsFilter.elementAt(index).governorate.governorateNameEn,

                                    style: TextStyle(
                                      color: AppColors.black1,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Align(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                      ),
                                      MySvgWidget(
                                          path: ImageAssets.walletIcon,
                                          imageColor: AppColors
                                              .descriptionBoardingColor,
                                          size: 20),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: cubit.carsFilter.elementAt(index).price.toString(),
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
                                alignment: Alignment.centerLeft,
                              ),
                              flex: 1,
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return NoDataWidget(
                onclick: () {
                  cubit.getFilterHome();
                },
                title: "no_data".tr());
          }
        }
        ;
      },
    );
  }
}
