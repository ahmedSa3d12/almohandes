import 'package:cached_network_image/cached_network_image.dart';
import 'package:engwheels/core/widgets/my_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/models/new_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import 'package:readmore/readmore.dart';

class NewsDetailsScreen extends StatefulWidget {
  const NewsDetailsScreen({Key? key, required this.newsModel})
      : super(key: key);
  final NewsData newsModel;

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.black),
          centerTitle: false,
          elevation: 0,
          leadingWidth: 30,
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
            child: Text(
              EasyLocalization.of(context)!.currentLocale!.languageCode == 'ar'
                  ? widget.newsModel.titleAr
                  : widget.newsModel.titleEn,
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: CachedNetworkImage(
                  imageUrl: EndPoints.baseUrl.replaceAll("/api", "")+widget.newsModel.photo,
                  imageBuilder: (context, imageProvider) => Container(


                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                ),
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
                    widget.newsModel.createdAt.split("T")[0],
                    style: TextStyle(fontSize: 13, color: AppColors.black1),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                EasyLocalization.of(context)!.currentLocale!.languageCode ==
                        'ar'
                    ? widget.newsModel.titleAr
                    : widget.newsModel.titleEn,
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.black1,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                EasyLocalization.of(context)!.currentLocale!.languageCode ==
                        'ar'
                    ? widget.newsModel.descAr
                    : widget.newsModel.descEn,
                style: TextStyle(
                    color: AppColors.descriptionBoardingColor, fontSize: 13),
              ),
              SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
