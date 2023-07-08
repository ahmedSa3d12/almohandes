import 'package:engwheels/core/widgets/my_svg_widget.dart';
import 'package:engwheels/feature/auth/register/presentation/screens/register_first.dart';
import 'package:engwheels/feature/auth/register/presentation/screens/register_seconed.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:readmore/readmore.dart';

import '../../../../../config/routes/app_routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/assets_manager.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/outline_button_widget.dart';
import '../../cubit/register_cubit.dart';
import '../../cubit/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

List screen = [RegisterFirst(), RegisterSeconed()];

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    int page = 0;
    RegisterCubit cubit = context.read<RegisterCubit>();

    return BlocBuilder<RegisterCubit, RegisterState>(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 16),
              )),
          body: Column(
            children: [
              Expanded(child: screen[context.read<RegisterCubit>().index]),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: Row(
                    children: [
                      Visibility(
                        visible: context.read<RegisterCubit>().index == 1,
                        child: Expanded(
                          child: OutLineButtonWidget(
                            text: "previous".tr(),
                            borderColor: AppColors.black1,
                            onclick: () {
                              context.read<RegisterCubit>().setIndex(0);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Expanded(
                        child: CustomButton(
                          text: cubit.index == 0 ? "next".tr() : "confirm".tr(),
                          color: AppColors.primary,
                          onClick: () {
                            if (cubit.index == 0) {
                              if (cubit.model.name.isNotEmpty &&
                                  cubit.model.phone.isNotEmpty &&
                                  cubit.model.phone_code.isNotEmpty) {
                                context.read<RegisterCubit>().setIndex(1);
                              } else {}
                            } else {
                              if (cubit.isLoginValid) {
                                cubit.register(context);
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
