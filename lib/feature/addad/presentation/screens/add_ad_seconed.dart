import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../cubit/add_ad_cubit.dart';
import '../../cubit/add_ad_state.dart';
import '../../widget/additions.dart';
import '../../widget/car_options.dart';

class AddAdSeconed extends StatefulWidget {
  const AddAdSeconed({Key? key}) : super(key: key);

  @override
  State<AddAdSeconed> createState() => _AddAdSeconedState();
}

class _AddAdSeconedState extends State<AddAdSeconed> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    AddAdCubit cubit = context.read<AddAdCubit>();

    return BlocBuilder<AddAdCubit, AddAdState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: Container(
              color: AppColors.white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,

                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('additional_details'.tr(),style: TextStyle(color: AppColors.black1,fontSize: 14),),
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.gray3,
                                border: Border.all(color: AppColors.gray2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            child: TextFormField(
                              maxLines: 10,
                              style: TextStyle(color: AppColors.black1, fontSize: 14),
                              textAlign: TextAlign.start,
                              textAlignVertical: TextAlignVertical.center,
                              controller: cubit.detailsControl,
                              onChanged: (data) {
                                cubit.model.details = data;
                                formKey.currentState!.validate();
                                //    cubit.checkValidLoginData();
                              },  validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "field_required".tr();
                              }
                              return null;
                            },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(7),
                                border: InputBorder.none,
                                hintText: "write_here".tr(),
                                hintStyle: TextStyle(
                                    fontSize: 13, color: AppColors.black1),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(children: [Expanded(
                        child: Text(  "متاح للتقسيط",style: TextStyle(color: AppColors.black1,fontSize: 14),

                        ),
                      ),
                        Switch(value: cubit.model.isavilable, onChanged: (value) {
                          cubit.model.isavilable=value;
                          cubit.checkValid2AddAdData(context);
                        },)
                      ],),
                      Text(  "اوبشن السيارة",style: TextStyle(color: AppColors.black1,fontSize: 14),),
                      CarOptions(),
                      SizedBox(
                        height: 20,

                      ),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            color: AppColors.thirdPrimary,
                            borderRadius:
                            BorderRadius.all(Radius.circular(16))),
                        child: Addtions(),
                      ),


                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
