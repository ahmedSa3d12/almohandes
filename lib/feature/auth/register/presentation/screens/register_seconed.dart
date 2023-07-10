import 'package:easy_localization/easy_localization.dart';
import 'package:engwheels/feature/auth/register/cubit/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../cubit/register_cubit.dart';

class RegisterSeconed extends StatefulWidget {
  const RegisterSeconed({Key? key}) : super(key: key);

  @override
  State<RegisterSeconed> createState() => _RegisterSeconedState();
}

class _RegisterSeconedState extends State<RegisterSeconed> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    RegisterCubit cubit = context.read<RegisterCubit>();

    return BlocBuilder<RegisterCubit, RegisterState>(
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

                      Text(
                        "login_details".tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: AppColors.black1),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "data_enable_you".tr(),
                        style: TextStyle(
                            fontSize: 18,
                            color: AppColors.descriptionBoardingColor),
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
                              hintStyle:
                              TextStyle(fontSize: 13, color: AppColors.black1),
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
                          },  validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "field_required".tr();
                          }
                          return null;
                        },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(7),
                              border: InputBorder.none,
                              hintText: "password".tr(),
                              hintStyle:
                              TextStyle(fontSize: 13, color: AppColors.black1),
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
                          },  validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "field_required".tr();
                          }
                          return null;
                        },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(7),
                              border: InputBorder.none,
                              hintText: "confirm_password".tr(),
                              hintStyle:
                              TextStyle(fontSize: 13, color: AppColors.black1),
                              suffixIcon: Icon(
                                Icons.lock_outline,
                                color: AppColors.primary,
                              )),
                        ),
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
}
