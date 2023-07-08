import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:engwheels/core/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/network_image.dart';
import '../cubit/add_ad_cubit.dart';
import '../cubit/add_ad_state.dart';

class EngineType extends StatefulWidget {
  const EngineType({Key? key}) : super(key: key);

  @override
  State<EngineType> createState() => _EngineTypeState();
}

class _EngineTypeState extends State<EngineType> {
    
  List data=['manual','automatic'];

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AddAdCubit cubit = context.read<AddAdCubit>();

    return  BlocBuilder<AddAdCubit, AddAdState>(
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
            child: DropdownButton2<String>(
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
                      'select_EngineType'.tr(),
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                          decoration: TextDecoration.none),
                    ),
                  ),
                ],
              ),
              items: data
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Row(
                      children: [

                        Text(
                        item.toString().tr(),
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

                      ],
                    ),
                  ))
                  .toList(),
              value: cubit.engineType,
              onChanged: (value) {
                cubit.model.engineType=value!.toString();
                cubit.changeEngineType(value);
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
