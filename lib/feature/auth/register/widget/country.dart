import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/models/country_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/network_image.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';

class Country extends StatefulWidget {
  const Country({Key? key}) : super(key: key);

  @override
  State<Country> createState() => _CountryState();
}

class _CountryState extends State<Country> {
  @override
  Widget build(BuildContext context) {
    RegisterCubit cubit = context.read<RegisterCubit>();

    return  BlocBuilder<RegisterCubit, RegisterState>(
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
                  SizedBox(
                    width: 1,
                  ),
                  Expanded(
                    child: Text(
                      'select_country'.tr(),
                      style: TextStyle(
                          fontSize: 10,
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
                    child: Row(
                      children: [

                        Text(
                          item.phoneCode,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black1,
                              decoration:
                              TextDecoration.none),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        ManageNetworkImage(
                          imageUrl: item.image,
                          width: 30,
                          height: 30,
                          borderRadius: 6,
                        ),
                      ],
                    ),
                  ))
                  .toList(),
              value: cubit.selectedCountry,
              onChanged: (value) {
                cubit.model.phone_code=value!.phoneCode;
                cubit.changeCountry(value);
              },
              buttonStyleData: ButtonStyleData(
                height: 50,
                padding: EdgeInsets.only(left: 1, right: 1),
                elevation: 1,

              ),
              iconStyleData: IconStyleData(
                icon: Icon(

                  Icons.keyboard_arrow_down_sharp,
                  color: AppColors.black1,
                ),
                iconSize: 20,
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
    )
    ;
  }
}
