import 'package:engwheels/core/models/cars_model.dart';
import 'package:engwheels/core/widgets/my_svg_widget.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:readmore/readmore.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/outline_button_widget.dart';
import '../../cubit/add_ad_cubit.dart';
import '../../cubit/add_ad_state.dart';
import 'add_ad_first.dart';
import 'add_ad_seconed.dart';

class AddAdScreen extends StatefulWidget {
  final CarsModel? carsModel;
  const AddAdScreen({Key? key, this.carsModel}) : super(key: key);

  @override
  State<AddAdScreen> createState() => _AddAdScreenState();
}

List screen = [AddAdFirst(), AddAdSeconed()];

class _AddAdScreenState extends State<AddAdScreen> {
  @override
  Widget build(BuildContext context) {
    int page = 0;
    AddAdCubit cubit = context.read<AddAdCubit>();
if(widget.carsModel!=null){
  cubit.setdata(widget.carsModel);
}
    return BlocBuilder<AddAdCubit, AddAdState>(
      builder: (context, state) {
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
                child: Text(widget.carsModel==null?'add_ad'.tr():"update_add".tr(),style: TextStyle(fontSize: 14,color: AppColors.black1),),
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 16),
              )),
          body: Column(
            children: [
              Expanded(child: screen[context.read<AddAdCubit>().index]),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: Row(
                    children: [
                      Visibility(
                        visible: context.read<AddAdCubit>().index == 1,
                        child: Expanded(
                          child: OutLineButtonWidget(
                            text: "previous".tr(),
                            borderColor: AppColors.black1,
                            onclick: () {
                              context.read<AddAdCubit>().setIndex(0);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Expanded(
                        child: CustomButton(
                          text: cubit.index == 0 ? "next".tr() : "confirm".tr(),
                          color: AppColors.primary,
                          onClick: () {
                            if (cubit.index == 0) {
                               if (cubit.model.isData1Valid(context) ){

                                context.read<AddAdCubit>().setIndex(1);
                               } else {}
                            } else {
                              if(cubit.model.isData2Valid(context)){
                                if(widget.carsModel==null) {
                                  cubit.addAd(context);
                                }
                                else{
                                  cubit.update(context);
                                }
                              }
                              else{
                                print(";dldll");
                              }

                              // if (cubit.isLoginValid) {
                              //   cubit.AddAd(context);
                              // }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
