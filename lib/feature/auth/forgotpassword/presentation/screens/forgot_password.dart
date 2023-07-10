import 'package:engwheels/core/widgets/my_svg_widget.dart';
import 'package:engwheels/feature/auth/forgotpassword/cubit/forgotpassword_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:readmore/readmore.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ForgotpasswordCubit cubit=context.read<ForgotpasswordCubit>();

    int page = 0;
    return Form(
      key: formKey,
      child: BlocBuilder<ForgotpasswordCubit, ForgotpasswordState>(
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
              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 16),
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
                  Center(child: Image.asset(ImageAssets.sentMessageImage,fit: BoxFit.fitWidth,)),
                  Text(
                    "forggot_password2".tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: AppColors.black1),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "enter_your_email_registerd".tr(),
                    style: TextStyle(
                        fontSize: 18, color: AppColors.black1),
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
                      controller: cubit.controllerEmail,
                      onChanged: (data) {
                        formKey.currentState!.validate();
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

                  CustomButton(
                    text: "sent     ".tr(),
                    color: AppColors.primary,
                    onClick: () {
                      if(formKey.currentState!.validate()){
                        cubit.forgotpassword(context);
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
