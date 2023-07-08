import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:engwheels/core/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/network_image.dart';
import '../cubit/add_ad_cubit.dart';
import '../cubit/add_ad_state.dart';

class Addtions extends StatefulWidget {
  const Addtions({Key? key}) : super(key: key);

  @override
  State<Addtions> createState() => _AddtionsState();
}

class _AddtionsState extends State<Addtions> {
  @override
  Widget build(BuildContext context) {
    AddAdCubit cubit = context.read<AddAdCubit>();

    return BlocBuilder<AddAdCubit, AddAdState>(
      builder: (context, state) {
        return Container(
          height: 200,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text("additions".tr(),
                    style: TextStyle(color: AppColors.black1, fontSize: 14),),
                  InkWell(
                    child: Icon(Icons.add_circle, color: AppColors.primary,),
                    onTap: () {
                        cubit.addwiget();

                    },
                  ),

                ],),
                BlocBuilder<AddAdCubit, AddAdState>(
                  builder: (context, state) {
                    return ListView.builder(
                      itemCount: cubit.model.additions.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                         return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border.all(color: AppColors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: TextFormField(
                                controller: cubit.additionscontrol.elementAt(index),
                                style: TextStyle(color: AppColors.black1, fontSize: 14),
                                textAlign: TextAlign.start,
                                textAlignVertical: TextAlignVertical.center,
                                onChanged: (data) {

                                  cubit.changtextname(data,index);
                                  //    cubit.checkValidLoginData();
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "field_required".tr();
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(7),
                                  border: InputBorder.none,
                                  hintText: "band_name".tr(),
                                  hintStyle: TextStyle(
                                      fontSize: 13, color: AppColors.black1),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 4,), Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  border: Border.all(color: AppColors.white),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  )),
                              child: TextFormField(
                                
                                style: TextStyle(color: AppColors.black1, fontSize: 14),
                                controller: cubit.additionsvaluecontrol.elementAt(index),
                                textAlign: TextAlign.start,
                                textAlignVertical: TextAlignVertical.center,
                                onChanged: (data) {
                                  cubit.changtextvalue(data,index);
                                  //    cubit.checkValidLoginData();
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "field_required".tr();
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(7),
                                  border: InputBorder.none,
                                  hintText: "value".tr(),
                                  hintStyle: TextStyle(
                                      fontSize: 13, color: AppColors.black1),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 4,),
                          InkWell
                            (

                              child: Icon(Icons.delete,),
                          onTap: () {
                            cubit.remove(index);
                          },
                          )
                        ],),
                      );

                      },);
                  },
                )
              ],
            ),
          ),
        );
      },
    )
    ;
  }
}

