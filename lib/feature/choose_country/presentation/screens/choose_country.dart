import 'package:engwheels/core/widgets/custom_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/models/country_model.dart';
import '../../../../core/preferences/preferences.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/network_image.dart';
import '../../cubit/choose_country_cubit.dart';

class ChooseCountry extends StatefulWidget {
  const ChooseCountry({Key? key}) : super(key: key);

  @override
  State<ChooseCountry> createState() => _ChooseCountryState();
}

class _ChooseCountryState extends State<ChooseCountry> {
  @override
  Widget build(BuildContext context) {
    ChooseCountryCubit cubit = context.read<ChooseCountryCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'welcom_to_you'.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                              fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'app_name'.tr(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                    fontSize: 20)),
                          ],
                        ),
                      ),
                      Text("app_desc".tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.descriptionBoardingColor,
                              fontSize: 13)),
                      SizedBox(
                        height: 70,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: [
                              Image.asset(ImageAssets.mapImage),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("please_choose_country".tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black,
                                            fontSize: 13)),
                                    Text("you_can_change_country".tr(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors
                                                .descriptionBoardingColor,
                                            fontSize: 13))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<ChooseCountryCubit, ChooseCountryState>(
                        builder: (context, state) {
                          return Container(
                            height: 60,
                            decoration: BoxDecoration(
                                color: AppColors.gray3,
                                border: Border.all(color: AppColors.gray2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                isExpanded: true,
                                style:
                                    TextStyle(decoration: TextDecoration.none),
                                hint: Row(
                                  children: [
                                    Visibility(
                                      child: ManageNetworkImage(
                                        imageUrl: cubit.selectedCountry1!=null?cubit.selectedCountry1!.image:"",
                                        width: 30,
                                        height: 30,
                                        borderRadius: 6,
                                      ),
                                      visible: cubit.selectedCountry1!=null,
                                    ),

                                    SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                      child: Text(
                                       cubit.selectedCountry1!=null?( EasyLocalization.of(context)!
                                           .currentLocale!
                                           .languageCode ==
                                           'ar'
                                           ? cubit.selectedCountry1!.titleAr
                                           : cubit.selectedCountry1!.titleEn): 'select_country'.tr(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.black,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ],
                                ),
                                items: cubit.countries
                                    .map((item) =>
                                        DropdownMenuItem<CountryModel>(
                                          value: item,
                                          child:
                                          Row(
                                            children: [
                                              ManageNetworkImage(
                                                imageUrl: item.image,
                                                width: 30,
                                                height: 30,
                                                borderRadius: 6,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              Text(
                                                EasyLocalization.of(context)!
                                                            .currentLocale!
                                                            .languageCode ==
                                                        'ar'
                                                    ? item.titleAr
                                                    : item.titleEn,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.black1,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                value: cubit.selectedCountry,
                                onChanged: (value) {
                                  cubit.changeCountry(value);
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 50,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                  elevation: 2,
                                ),
                                iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: AppColors.black1,
                                  ),
                                  iconSize: 30,
                                ),
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: 200,
                                  padding: null,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  elevation: 8,
                                  offset: Offset(-20, 0),
                                  scrollbarTheme: ScrollbarThemeData(
                                    radius: Radius.circular(40),

                                    //thickness: MaterialStateProperty.all<double>(6),
                                    //     thumbVisibility: MaterialStateProperty.all<bool>(true),
                                  ),
                                ),
                                menuItemStyleData: MenuItemStyleData(
                                  height: 40,
                                  padding: EdgeInsets.only(left: 14, right: 14),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )),
            Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: BlocBuilder<ChooseCountryCubit, ChooseCountryState>(
                  builder: (context, state) {
                    return CustomButton(
                      text: 'confirm'.tr(),
                      color: AppColors.primary,
                      enable: cubit.selectedCountry != null ? true : false,
                      onClick: () {
                        Preferences.instance
                            .setcountry(cubit.selectedCountry!)
                            .then((value) => {
                                  Navigator.pushNamed(context, Routes.mainRoute)
                                });
                      },
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
