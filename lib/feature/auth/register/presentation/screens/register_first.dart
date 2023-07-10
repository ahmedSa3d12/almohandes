import 'dart:io';

import 'package:engwheels/core/widgets/my_svg_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../cubit/register_cubit.dart';
import '../../cubit/register_state.dart';
import '../../widget/country.dart';

class RegisterFirst extends StatefulWidget {
  const RegisterFirst({Key? key}) : super(key: key);

  @override
  State<RegisterFirst> createState() => _RegisterFirstState();
}

class _RegisterFirstState extends State<RegisterFirst> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    RegisterCubit cubit = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit, RegisterState>(
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
                      Text(
                        "profile_details".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: AppColors.black1),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "user_identify".tr(),
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.descriptionBoardingColor),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            buildAlertDialog();
                          },
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: AppColors.white,
                                border: Border.all(color: AppColors.gray2)),
                            child: Column(
                              children: [
                                Center(
                                    child: cubit.model.image.isEmpty
                                        ? Image.asset(
                                            ImageAssets.userImage,
                                          )
                                        : Image.file(
                                            File(
                                              cubit.model.image,
                                            ),
                                            width: 140.0,
                                            height: 140.0,
                                            fit: BoxFit.cover,
                                          )),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "personal_image".tr(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: AppColors
                                                  .descriptionBoardingColor),
                                        ),
                                      ),
                                      Icon(
                                        Icons.add_circle,
                                        color: AppColors.primary,
                                        size: 25,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.gray3,
                            border: Border.all(color: AppColors.gray2),
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: TextFormField(
                          style: TextStyle(color: AppColors.black1, fontSize: 14),
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (data) {
                            cubit.model.name = data;
                            formKey.currentState!.validate();
                            cubit.checkValidLoginData();
                          },  validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "field_required".tr();
                          }
                          return null;
                        },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(7),
                              border: InputBorder.none,
                              hintText: "name".tr(),
                              hintStyle: TextStyle(
                                  fontSize: 13, color: AppColors.black1),
                              suffixIcon: Icon(
                                Icons.person_outline,
                                color: AppColors.primary,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.gray3,
                                  border: Border.all(color: AppColors.gray2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: TextFormField(
                                style: TextStyle(
                                    color: AppColors.black1, fontSize: 14),
                                keyboardType: TextInputType.phone,
                                textAlign: TextAlign.start,
                                textAlignVertical: TextAlignVertical.center,
                                onChanged: (data) {
                                  cubit.model.phone = data;
                                  formKey.currentState!.validate();
                                  cubit.checkValidLoginData();
                                },  validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "field_required".tr();
                                }
                                return null;
                              },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(7),
                                    border: InputBorder.none,
                                    hintText: "phone".tr(),
                                    hintStyle: TextStyle(
                                        fontSize: 13, color: AppColors.black1),
                                    suffixIcon: Icon(
                                      Icons.phone_android,
                                      color: AppColors.primary,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: AppColors.gray3,
                                  border: Border.all(color: AppColors.gray2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  )),
                              child: Country(),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 32,
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
          return BlocBuilder<RegisterCubit, RegisterState>(
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
                        context.read<RegisterCubit>().pickImage(type: 'camera');
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
                            .read<RegisterCubit>()
                            .pickImage(type: 'gallery');
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
