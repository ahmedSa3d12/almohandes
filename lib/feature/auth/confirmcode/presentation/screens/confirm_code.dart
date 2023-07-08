import 'dart:async';

import 'package:engwheels/core/widgets/my_svg_widget.dart';
import 'package:engwheels/feature/auth/confirmcode/cubit/confirm_code_cubit.dart';
import 'package:engwheels/feature/auth/forgotpassword/cubit/forgotpassword_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as tr;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import 'package:readmore/readmore.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/custom_button.dart';

class ConfirmCodeScreen extends StatefulWidget {
  const ConfirmCodeScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmCodeScreen> createState() => _ConfirmCodeScreenState();
}

bool hasError = false;


class _ConfirmCodeScreenState extends State<ConfirmCodeScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    ConfirmCodeCubit cubit = context.read<ConfirmCodeCubit>();
    int page = 0;
    return Form(
      key: formKey,
      child: BlocBuilder<ConfirmCodeCubit, ConfirmCodeState>(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 5.0, vertical: 16),
                )),
            body: Container(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: Image.asset(
                            ImageAssets.otpImage,
                            fit: BoxFit.fitWidth,
                          )),
                      Text(
                        tr.tr("enter_confirm_code"),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: AppColors.black1),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: tr.tr('enter_code_sent_to_email'),
                          style: TextStyle(
                              color: AppColors.black1, fontSize: 14),
                          children: <TextSpan>[
                            TextSpan(
                                text: context.read<ForgotpasswordCubit>().controllerEmail.text,
                                style: TextStyle(
                                    color: AppColors.primary, fontSize: 14)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Center(
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Pinput(

                            defaultPinTheme: PinTheme(
                              width: 60,
                              height: 70,
                              textStyle: TextStyle(fontSize: 20,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold),
                              decoration: BoxDecoration(
                                color: AppColors.thirdPrimary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            controller: cubit.controllerCode,
                            length: 6,
                            onChanged: (data) {
                              formKey.currentState!.validate();
                            },
                            validator: (v) {
                              if (v!.length < 6) {
                                return "";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(children: [
                            InkWell(
                              child: Text(
                                tr.tr("resend_code"),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.primary),
                              ),
                              onTap: () {
                                cubit.startTimer();
                                context.read<ForgotpasswordCubit>().forgotpassword(context);
                              },
                            ),
                            Expanded(child: Container()),
                            Text(
                              cubit.time1,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.black1),
                            ),
                          ],),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      CustomButton(
                        text: tr.tr("confirm"),
                        color: AppColors.primary,
                        onClick: () {
                          if(formKey.currentState!.validate()){
                            cubit.confirmcode(context);
                          }
                        },
                      ),
                      SizedBox(
                        height: 32,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
