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

class HomeCar extends StatelessWidget {
  const HomeCar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit=context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if(state is HomeCarsLoading){
          return ShowLoadingIndicator();
        }
        else if(state is HomeCarsError){
          return NoDataWidget(onclick: () {
            cubit.getHome();
          }, title: "no_data".tr());
        }
        else{
          if(cubit.cars.isNotEmpty){
        return ListView.builder(
          itemCount: cubit.cars.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
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
                      borderRadius:
                      BorderRadius.all(Radius.circular(10))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 240,
                        height: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15)),
                     ),
                        child:cubit.cars.elementAt(index).image!=null?
                        CachedNetworkImage(
                          width: 240,
                          height: 160,
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
                      SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7.0),
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
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0),
                        child: Row(
                          children: [
                            MySvgWidget(
                                path: ImageAssets.walletIcon,
                                imageColor: AppColors.descriptionBoardingColor,
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
                ),
              ),
            );
          },
        );}
        else{
            return NoDataWidget(onclick: () {
              cubit.getHome();
            }, title: "no_data".tr());
        }
        };
      },
    );
  }
}
