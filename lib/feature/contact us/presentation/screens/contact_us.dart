import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/toast_message_method.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/show_loading_indicator.dart';
import '../cubit/contact_us_cubit.dart';


class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocBuilder<ContactUsCubit, ContactUsState>(
        builder: (context, state) {
          ContactUsCubit cubit = context.read<ContactUsCubit>();
          if (state is ContactUsLoading) {
            return ShowLoadingIndicator();
          }
          else if (state is ContactUsLoaded) {
            Future.delayed(
              Duration(milliseconds: 300),
                  () {
                toastMessage(
                  'Success'.tr(),
                  context,
                  color: AppColors.success,
                );
                Future.delayed(
                  Duration(milliseconds: 300),
                      () {
                    Navigator.pop(context);
                  },
                );
              },
            );
            return ShowLoadingIndicator();
          }
          return
              Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),),
                    ),
                    width: double.infinity,
                    child: Card(
                      elevation: 8,
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25)),
                      ),
                      color: AppColors.primary,
                      child: SafeArea(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                ImageAssets.logoImage,
                                height: 70,
                                width: 70,
                              ),
                              Text(
                                'contact_us'.tr(),
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(
                                  Icons.arrow_forward,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),

                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        controller: cubit.nameController,
                        style: TextStyle(color: AppColors.black1, fontSize: 14),
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(7),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),

                            hintText: "name".tr(),
                            hintStyle:
                            TextStyle(fontSize: 13, color: AppColors.black1),
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: AppColors.primary,
                            )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "field_required".tr();
                          }
                          return null;
                        },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: cubit.phoneController,
                      style: TextStyle(color: AppColors.black1, fontSize: 14),
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(7),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),

                          hintText: "phone".tr(),
                          hintStyle:
                          TextStyle(fontSize: 13, color: AppColors.black1),
                          prefixIcon: Icon(
                            Icons.phone_android,
                            color: AppColors.primary,
                          )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "field_required".tr();
                          }
                          return null;
                        },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: cubit.emailController,
                      style: TextStyle(color: AppColors.black1, fontSize: 14),
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(7),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),

                          hintText: "email".tr(),
                          hintStyle:
                          TextStyle(fontSize: 13, color: AppColors.black1),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: AppColors.primary,
                          )),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "field_required".tr();
                          }
                          return null;
                        },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: cubit.subjectController,
                      style: TextStyle(color: AppColors.black1, fontSize: 14),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(7),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),

                          hintText: "subject".tr(),
                          hintStyle:
                          TextStyle(fontSize: 13, color: AppColors.black1),
                          prefixIcon: Icon(
                            Icons.subtitles_sharp,
                            color: AppColors.primary,
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "field_required".tr();
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: cubit.messageController,

                      style: TextStyle(color: AppColors.black1, fontSize: 14),
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,

                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(7),
border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),

                          hintText: "message".tr(),
                          hintStyle:
                          TextStyle(fontSize: 13, color: AppColors.black1),
                          prefixIcon: Icon(
                            Icons.message,
                            color: AppColors.primary,
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "field_required".tr();
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 60),
                  CustomButton(
                    text: 'send'.tr(),
                    color: AppColors.primary,
                    onClick: () {
                      if (formKey.currentState!.validate()) {
                        cubit.contactUsApi();
                      }
                    },
                    borderRadius: 35,
                    paddingHorizontal: 60,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          )
            ;
        },
      ),
    );
  }
}
