import 'package:cached_network_image/cached_network_image.dart';
import 'package:engwheels/core/widgets/my_svg_widget.dart';
import 'package:engwheels/core/widgets/no_data_widget.dart';
import 'package:engwheels/core/widgets/show_loading_indicator.dart';
import 'package:engwheels/feature/news/cubit/news_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import 'package:readmore/readmore.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    NewsCubit cubit=context.read<NewsCubit>();
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leadingWidth: MediaQuery.of(context).size.width,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              'news'.tr(),
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: BlocBuilder<NewsCubit, NewsState>(
  builder: (context, state) {
    if(state is NewsLoading){
      return ShowLoadingIndicator();
    }
    else if(state is NewsError){
      return NoDataWidget(onclick: () {
        cubit.getNews();
      }, title: "no_data".tr());
    }
    else{
      if(cubit.news.isNotEmpty) {
        return ListView.builder(
          itemCount: cubit.news.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 200,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      child:
                      CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth,
                        imageBuilder: (context, imageProvider) => Container(


                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        imageUrl: EndPoints.baseUrl.replaceAll("/api", "")+cubit.news.elementAt(index).photo,),
                    ),
                    SizedBox(height: 4,),
                    Row(
                      children: [
                        MySvgWidget(
                            path: ImageAssets.calenderIcon,
                            imageColor: AppColors.primary,
                            size: 20),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          cubit.news.elementAt(index).createdAt.split("T").first,
                          style:
                          TextStyle(fontSize: 13, color: AppColors.black1),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                     EasyLocalization.of(context)!.currentLocale!.languageCode=='ar'? cubit.news.elementAt(index).titleAr:cubit.news.elementAt(index).titleEn,
                      style: TextStyle(
                          fontSize: 15,
                          color: AppColors.black1,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        cubit.getNews();
                        Navigator.pushNamed(context, Routes.newsDetailsRoute,arguments: cubit.news.elementAt(index));
                      },
                      child: ReadMoreText(
                        EasyLocalization.of(context)!.currentLocale!.languageCode=='ar'? cubit.news.elementAt(index).descAr:cubit.news.elementAt(index).descEn,
                        style: TextStyle(
                            color: AppColors.descriptionBoardingColor,
                            fontSize: 13),
                        callback: (val) {
                          cubit.getNews();
                          Navigator.pushNamed(context, Routes.newsDetailsRoute,arguments: cubit.news.elementAt(index));
                        },
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'read_more'.tr(),
                        trimExpandedText: '',
                        moreStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            );
          },
        );
      }else{
        return NoDataWidget(onclick: () {
          cubit.getNews();
        }, title: "no_data".tr());
      }
      }
  },
),
      ),
    );
  }
}
