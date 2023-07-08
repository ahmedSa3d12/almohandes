import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:engwheels/core/models/category_model.dart';
import 'package:engwheels/core/widgets/no_data_widget.dart';
import 'package:engwheels/core/widgets/show_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/network_image.dart';
import '../cubit/add_ad_cubit.dart';
import '../cubit/add_ad_state.dart';

class CarOptions extends StatefulWidget {
  const CarOptions({Key? key}) : super(key: key);

  @override
  State<CarOptions> createState() => _CarOptionsState();
}

class _CarOptionsState extends State<CarOptions> {
  @override
  Widget build(BuildContext context) {

    AddAdCubit cubit = context.read<AddAdCubit>();

    return  BlocBuilder<AddAdCubit, AddAdState>(
      builder: (context, state) {
        if(state is CarOptionsLoading){
          return ShowLoadingIndicator();
        }
        else if(state is CarOptionsError){
          return NoDataWidget(onclick: () {
            cubit.getCarOptions();
          }, title: "no_data".tr());
        }
        else{
        return    Padding(
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
            itemCount: cubit.options.length,
            itemBuilder: (context, index) {
              return
               CheckboxListTile(
                 title:  Text(EasyLocalization.of(context)!.currentLocale!.languageCode=='ar'?cubit.options[index].titleAr:cubit.options[index].titleAr,style: TextStyle(color: AppColors.black1,fontSize: 14),),
                 controlAffinity: ListTileControlAffinity.leading,
                 value:cubit.options[index].isselected,

                 onChanged: (value) {
cubit.changeoptions(value,index);
               },);
            },
          ),
        );}
      },
    )
    ;
  }
}
