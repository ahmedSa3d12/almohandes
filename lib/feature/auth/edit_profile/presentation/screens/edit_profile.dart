import 'dart:io';

import 'package:engwheels/core/widgets/my_svg_widget.dart';
import 'package:engwheels/feature/auth/edit_profile/cubit/editprofile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:readmore/readmore.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/network_image.dart';
import '../../../../../core/widgets/outline_button_widget.dart';
import '../../widget/country.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    EditProfileCubit cubit = context.read<EditProfileCubit>();
    final formKey = GlobalKey<FormState>();

    int page = 0;
    return Form(
      key: formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.white,
        appBar: AppBar(
            iconTheme: IconThemeData(color: AppColors.black),
            centerTitle: false,
            elevation: 0,
            leadingWidth: 30,
            titleSpacing: 10,
            toolbarHeight: 90,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 16),
              child: Text(
                'edit_profile'.tr(),
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            )),
        body: Container(
          color: AppColors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder<EditProfileCubit, EditProfileState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: AppColors.white,
                                border: Border.all(color: AppColors.gray2)),
                            child: Column(
                              children: [
                                Center(
                                    child: cubit.model.image.isEmpty
                                        ? Image.asset(
                                            ImageAssets.userImage,
                                          )
                                        : cubit.model.image.contains("http")
                                            ? ManageNetworkImage(
                                                imageUrl: cubit.model.image,
                                                height: 140,
                                                width: 140,
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
                      SizedBox(
                        height: 32,
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
                          controller: cubit.nameController,
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
                          textAlignVertical: TextAlignVertical.center,
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
                                controller: cubit.phoneController,
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
                            width: 10,
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
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.gray3,
                            border: Border.all(color: AppColors.gray2),
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: TextFormField(
                          style: TextStyle(color: AppColors.black1, fontSize: 14),
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.start,
                          controller: cubit.emailController,
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (data) {
                            cubit.model.email = data;
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
                              hintText: "email".tr(),
                              hintStyle: TextStyle(
                                  fontSize: 13, color: AppColors.black1),
                              suffixIcon: Icon(
                                Icons.mail_outline,
                                color: AppColors.primary,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.gray3,
                            border: Border.all(color: AppColors.gray2),
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: TextFormField(
                          style: TextStyle(color: AppColors.black1, fontSize: 14),
                          keyboardType: TextInputType.visiblePassword,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (data) {
                            cubit.model.password = data;
                            formKey.currentState!.validate();
                            cubit.checkValidLoginData();
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(7),
                              border: InputBorder.none,
                              hintText: "password".tr(),
                              hintStyle: TextStyle(
                                  fontSize: 13, color: AppColors.black1),
                              suffixIcon: Icon(
                                Icons.lock_outline,
                                color: AppColors.primary,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.gray3,
                            border: Border.all(color: AppColors.gray2),
                            borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: TextFormField(
                          style: TextStyle(color: AppColors.black1, fontSize: 14),
                          keyboardType: TextInputType.visiblePassword,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (data) {
                            cubit.model.confirmpassword = data;
                            formKey.currentState!.validate();
                            cubit.checkValidLoginData();
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(7),
                              border: InputBorder.none,
                              hintText: "confirm_password".tr(),
                              hintStyle: TextStyle(
                                  fontSize: 13, color: AppColors.black1),
                              suffixIcon: Icon(
                                Icons.lock_outline,
                                color: AppColors.primary,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      CustomButton(
                        text: "confirm".tr(),
                        color: AppColors.primary,
                        onClick: () {
                          if(formKey.currentState!.validate()){
                            cubit.EditProfile(context);
                          }
                        },

                        //      context.read<RegisterCubit>().setIndex(1);                      },
                      ),
                      SizedBox(
                        height: 32,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
  buildAlertDialog() {
    return showDialog(
        context: context,
        builder: (c) {
          return BlocBuilder<EditProfileCubit, EditProfileState>(
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
                        context.read<EditProfileCubit>().pickImage(type: 'camera');
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
                            .read<EditProfileCubit>()
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
