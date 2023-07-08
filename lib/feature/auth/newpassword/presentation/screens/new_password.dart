import 'package:engwheels/core/widgets/my_svg_widget.dart';
import 'package:engwheels/feature/auth/newpassword/cubit/newpassword_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:readmore/readmore.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/custom_button.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
NewpasswordCubit cubit=context.read<NewpasswordCubit>();
    int page = 0;
    return Form(
      key: formKey,
      child: BlocBuilder<NewpasswordCubit, NewpasswordState>(
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
                  Center(child: Image.asset(ImageAssets.newpassImage,fit: BoxFit.fitWidth,)),
                  Text(
                    "enter_password".tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: AppColors.black1),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "enter_new_password".tr(),
                    style: TextStyle(
                        fontSize: 13, color: AppColors.black1),
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
                      controller: cubit.newpass,
                      onChanged: (data) {

                        formKey.currentState!.validate();

                      },  validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "name_required".tr();
                      }
                      return null;
                    },
                      style: TextStyle(color: AppColors.black1, fontSize: 14),
                      keyboardType: TextInputType.visiblePassword,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
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
                      controller: cubit.confirmpass,
                      onChanged: (data) {
                        formKey.currentState!.validate();
                      },  validator: (value) {
                      if (value == null || value.isEmpty||value!=cubit.newpass.text) {
                        return value!.isEmpty?"name_required".tr():"password_must_equal".tr();
                      }
                      return null;
                    },
                      style: TextStyle(color: AppColors.black1, fontSize: 14),
                      keyboardType: TextInputType.visiblePassword,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
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
                  CustomButton(
                    text: "confirm".tr(),
                    color: AppColors.primary,
                    onClick: () {
                      if(formKey.currentState!.validate()){
                        cubit.newpassword(context);
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
