import 'dart:io';

import 'package:engwheels/core/widgets/my_svg_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:engwheels/core/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../cubit/add_ad_cubit.dart';
import '../../cubit/add_ad_state.dart';
import '../../widget/brand.dart';
import '../../widget/color_car.dart';
import '../../widget/engine_type.dart';
import '../../widget/industry_year.dart';
import '../../widget/model.dart';
import '../../widget/status.dart';

class AddAdFirst extends StatefulWidget {
  const AddAdFirst({Key? key}) : super(key: key);

  @override
  State<AddAdFirst> createState() => _AddAdFirstState();
}

class _AddAdFirstState extends State<AddAdFirst> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    AddAdCubit cubit = context.read<AddAdCubit>();
    return BlocBuilder<AddAdCubit, AddAdState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: Container(
            color: AppColors.white,
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text('car_images'.tr(),style: TextStyle(color: AppColors.black1,fontSize: 14),),
                      SizedBox(height: 2,),
                      InkWell(
                        onTap: () {
                          buildAlertDialog();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15)),
                              color: AppColors.gray3,
                              border: Border.all(color: AppColors.gray2)),
                          child: Center(
                              child: Image.asset(
                                ImageAssets.uploadImage,
                              )
                                 ),
                        ),
                      ),
                      SizedBox(height: 4,),
                      Visibility(
                        visible:cubit.model.image.isNotEmpty ,
                        child: Container(
                          height: 100,
                          child:
                          ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: cubit.model.image.length ,
                            itemBuilder: (context, index) {
                              return  cubit.model.image[index].contains("http")?
                              ManageNetworkImage(imageUrl: cubit.model.image[index])
                                  :Image.file(
                                File(
                                  cubit.model.image[index],
                                ),
                                width: 90.0,
                                height: 90.0,
                                fit: BoxFit.cover,

                              );
                            },),
                        ),
                      ),
                      SizedBox(height: 4,),
                      Container(
                        height: 100,

                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('brand'.tr(),style: TextStyle(color: AppColors.black1,fontSize: 14),),
                                  Brand()
                                ],
                              ),
                            ),
                            SizedBox(width: 4,),
                            Expanded(
                                child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('model'.tr(),style: TextStyle(color: AppColors.black1,fontSize: 14),),
                                Models()
                              ],
                            )),

                          ],
                        ),
                        width: MediaQuery.of(context).size.width,
                      ) ,
                      SizedBox(height: 4,),
                      Container(
                        height: 100,

                        child: Row(
                          children: [
                            Expanded(
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('kilometers_traveled'.tr(),style: TextStyle(color: AppColors.black1,fontSize: 14),),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.gray3,
                                        border: Border.all(color: AppColors.gray2),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        )),
                                    child:
                                    TextFormField(
                                      controller: cubit.kiloetercontrol,
                                      style: TextStyle(color: AppColors.black1, fontSize: 14),
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.start,
                                      textAlignVertical: TextAlignVertical.center,
                                      onChanged: (data) {
                                        cubit.model.kilometers_travaled = data;
                                        formKey.currentState!.validate();
                                    cubit.checkValid1AddAdData(context);
                                      },  validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "field_required".tr();
                                      }
                                      return null;
                                    },
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(7),
                                          border: InputBorder.none,
                                          hintText: "example".tr()+" 5000",
                                          hintStyle: TextStyle(
                                              fontSize: 13, color: AppColors.black1),
                                        ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 4,),
                            Expanded(
                                child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('engine_capacity'.tr(),style: TextStyle(color: AppColors.black1,fontSize: 14),),
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.gray3,
                                      border: Border.all(color: AppColors.gray2),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      )),
                                  child: TextFormField(
                                    controller: cubit.capcityControl,

                                    style: TextStyle(color: AppColors.black1, fontSize: 14),
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.start,
                                    textAlignVertical: TextAlignVertical.center,
                                    onChanged: (data) {
                                      cubit.model.engine_capacity = data;
                                      formKey.currentState!.validate();
                                      cubit.checkValid1AddAdData(context);
                                    },  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "field_required".tr();
                                    }
                                    return null;
                                  },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(7),
                                        border: InputBorder.none,
                                        hintText: "example".tr()+" 600",
                                        hintStyle: TextStyle(
                                            fontSize: 13, color: AppColors.black1),
                                        ),
                                  ),
                                )
                              ],
                            )),

                          ],
                        ),
                        width: MediaQuery.of(context).size.width,
                      ),
                      SizedBox(height: 4,),
                      Container(
                        height: 100,

                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('industry_year'.tr(),style: TextStyle(color: AppColors.black1,fontSize: 14),),
                                  Years()
                                ],
                              ),
                            ),
                            SizedBox(width: 4,),
                            Expanded(
                                child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('status'.tr(),style: TextStyle(color: AppColors.black1,fontSize: 14),),
                                    Status()
                                  ],
                                )),

                          ],
                        ),
                        width: MediaQuery.of(context).size.width,
                      ) ,
                      SizedBox(height: 4,),
                      Container(
                        height: 100,

                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('color'.tr(),style: TextStyle(color: AppColors.black1,fontSize: 14),),
                                  CarColors()
                                ],
                              ),
                            ),
                            SizedBox(width: 4,),
                            Expanded(
                                child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('engine_type'.tr(),style: TextStyle(color: AppColors.black1,fontSize: 14),),
                                    EngineType()
                                  ],
                                )),

                          ],
                        ),
                        width: MediaQuery.of(context).size.width,
                      ) ,
                      SizedBox(height: 4,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('price'.tr(),style: TextStyle(color: AppColors.black1,fontSize: 14),),
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.gray3,
                                border: Border.all(color: AppColors.gray2),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            child: TextFormField(
                              style: TextStyle(color: AppColors.black1, fontSize: 14),
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.start,
                              controller: cubit.priceControl,
                              textAlignVertical: TextAlignVertical.center,
                              onChanged: (data) {
                                cubit.model.price = data;
                                formKey.currentState!.validate();
                                cubit.checkValid1AddAdData(context);
                              },  validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "field_required".tr();
                              }
                              return null;
                            },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(7),
                                border: InputBorder.none,
                                hintText: "example".tr()+" 200000",
                                hintStyle: TextStyle(
                                    fontSize: 13, color: AppColors.black1),
                              ),
                            ),
                          )
                        ],
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

  buildAlertDialog() {
    return showDialog(
        context: context,
        builder: (c) {
          return BlocBuilder<AddAdCubit, AddAdState>(
            builder: (context, state) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'choose_photo'.tr(),
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      height: 1,
                      color: AppColors.gray4,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        context.read<AddAdCubit>().pickImage(type: 'camera',context: context);
                      },
                      child: Text(
                        'camera'.tr(),
                        style:
                            TextStyle(fontSize: 18.0, color: AppColors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        context
                            .read<AddAdCubit>()
                            .pickImage(type: 'gallery',context: context);
                      },
                      child: Text(
                        'gallery'.tr(),
                        style:
                            TextStyle(fontSize: 18.0, color: AppColors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      height: 1,
                      color: AppColors.gray4,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'cancel'.tr(),
                        style:
                            TextStyle(fontSize: 18.0, color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
