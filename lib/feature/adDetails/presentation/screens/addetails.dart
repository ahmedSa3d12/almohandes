import 'package:cached_network_image/cached_network_image.dart';
import 'package:engwheels/core/widgets/my_svg_widget.dart';
import 'package:engwheels/feature/adDetails/cubit/ad_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_launch/flutter_launch.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/models/cars_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter/src/widgets/image.dart' as image;
import '../../../../core/utils/hex_color.dart';

class AddetialsScreen extends StatefulWidget {
  final CarsModel carsModel;

  const AddetialsScreen({Key? key, required this.carsModel}) : super(key: key);

  @override
  State<AddetialsScreen> createState() => _AddetialsScreenState();
}

class _AddetialsScreenState extends State<AddetialsScreen> {
  @override
  Widget build(BuildContext context) {

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
            child: Text(
              'addetials'.tr(),
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )),
      body: BlocBuilder<AdDetailsCubit, AdDetailsState>(
  builder: (context, state) {
    return Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 240,
                child: Stack(
                  children: [
                    Positioned(
                      child: CarouselSlider(
                          options: CarouselOptions(
                              onPageChanged:
                                  (int i, CarouselPageChangedReason c) {
                              context.read<AdDetailsCubit>().changepage(i);
                              },
                              enlargeCenterPage: true,
                              enableInfiniteScroll: false,
                              autoPlay: true,
                              reverse: false,
                              height: 240,
                              viewportFraction: 1.0),
                          items: List.generate(
                              
                              widget.carsModel.images.length,

                              (index) {

                            return Container(
                              width: MediaQuery.of(context).size.width,
                              height: 240,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: widget.carsModel.images
                                          .elementAt(index)
                                          .image !=
                                      null
                                  ? CachedNetworkImage(
                                      width: MediaQuery.of(context).size.width,
                                      height: 240,
                                      fit: BoxFit.fitWidth,
                                      imageBuilder: (context, imageProvider) =>
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
                                          widget.carsModel.images
                                              .elementAt(index)
                                              .image!,
                                    )
                                  : Container(),
                            );
                          })),
                      top: 0,
                      bottom: 0,
                      right: 0,
                      left: 0,
                    ),
                    Positioned(
                        left: 20,
                        bottom: 0,
                        child: Text(
                          (context.read<AdDetailsCubit>().page ).toString()+
                              "/" +
                              widget.carsModel.images.length.toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: AppColors.white),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  EasyLocalization.of(context)!.currentLocale!.languageCode ==
                          'ar'
                      ? widget.carsModel.category.titleAr +
                          " " +
                          widget.carsModel.subCategory.titleAr
                      : widget.carsModel.category.titleEn +
                          " " +
                          widget.carsModel.subCategory.titleEn,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: AppColors.black1),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  EasyLocalization.of(context)!.currentLocale!.languageCode ==
                          'ar'
                      ? widget.carsModel.description
                      : widget.carsModel.description,
                  style: TextStyle(
                      fontSize: 14, color: AppColors.descriptionBoardingColor),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.carsModel.data.length+1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index1) {
                    return Row(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                               index1==widget.carsModel.data.length?(widget.carsModel.kilometre!+"km".tr()): widget.carsModel.data.elementAt(index1).value.tr(),
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
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          MySvgWidget(
                              path: ImageAssets.flagIcon,
                              imageColor: AppColors.descriptionBoardingColor,
                              size: 20),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            EasyLocalization.of(context)!
                                        .currentLocale!
                                        .languageCode ==
                                    "ar"
                                ? widget.carsModel.country.titleAr
                                : widget.carsModel.country.titleEn,
                            style: TextStyle(
                              color: AppColors.black1,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          MySvgWidget(
                              path: ImageAssets.mapIcon,
                              imageColor: AppColors.descriptionBoardingColor,
                              size: 20),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            EasyLocalization.of(context)!
                                        .currentLocale!
                                        .languageCode ==
                                    "ar"
                                ? widget
                                    .carsModel.governorate.governorateNameAr
                                : widget
                                    .carsModel.governorate.governorateNameEn,
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40,
                              ),
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
                                  text: widget.carsModel.price.toString(),
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.gray2,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            image.Image.asset(ImageAssets.newcarImage),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "car_options".tr(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: AppColors.descriptionBoardingColor),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 4,
                                    crossAxisSpacing: 4,
                                    crossAxisCount: 2,
                                    childAspectRatio: 4),
                            itemCount: widget.carsModel.options.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    color: AppColors.gray3,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    EasyLocalization.of(context)!
                                                .currentLocale!
                                                .languageCode ==
                                            "ar"
                                        ? widget.carsModel.options
                                            .elementAt(index)
                                            .option
                                            .titleAr
                                        : widget.carsModel.options
                                            .elementAt(index)
                                            .option
                                            .titleEn,
                                    style: TextStyle(
                                        fontSize: 13, color: AppColors.black1),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: context.read<AdDetailsCubit>().userModel==null||context.read<AdDetailsCubit>().userModel!=widget.carsModel.user!.id?true:false,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.gray2,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: widget.carsModel.user!.photo != null
                                      ? CachedNetworkImage(
                                          width: 64,
                                          height: 64,
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
                                              widget.carsModel.user!.photo,
                                        )
                                      : Container(),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'adviser'.tr(),
                                        style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              AppColors.descriptionBoardingColor,
                                        ),
                                      ),
                                      Text(
                                        widget.carsModel.user!.name,
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
                                  context.read<AdDetailsCubit>().sendMessage(widget.carsModel.userId!, context);
                                },
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16))),
                                  child: Center(
                                    child: MySvgWidget(
                                      size: 60,
                                      path: ImageAssets.chatIcon,
                                      imageColor: AppColors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () async {
                                    await FlutterLaunch.launchWhatsapp(phone: widget.carsModel.user!.phone,message: "");
                                  },
                                  child: image.Image.asset(ImageAssets.whatsappImage)),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: ()  async {
                                  await launch("tel://${widget.carsModel.user!.phone}");
                                },
                                  child: image.Image.asset(ImageAssets.callImage),

                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                  onTap: ()  async {
                                    await    launch("sms://${widget.carsModel.user!.phone}");
                                  },
                                  child: image.Image.asset(ImageAssets.messageImage)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
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
),
    );
  }
}
