import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/widgets/custom_button.dart';
import '../cubit/home_cubit.dart';

class Status extends StatefulWidget {
  const Status({Key? key}) : super(key: key);

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  String _verticalGroupValue = "all".tr();

  final _status = ["all".tr(), "new".tr(), "used".tr()];

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = context.read<HomeCubit>();

    return Container(
      color: AppColors.transparent1,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "status".tr(),
                    style: TextStyle(
                        color: AppColors.black1,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      child: Icon(
                        Icons.close,
                        color: AppColors.white,
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.black1, shape: BoxShape.circle),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  ListTile(
                    title: InkWell(
                      onTap: () => setState(() {
                        _verticalGroupValue = "all" ?? '';
                        cubit.setstatus("all");
                      }),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: _verticalGroupValue == 'all'
                                    ? AppColors.primary
                                    : AppColors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.primary)),
                            width: 20,
                            height: 20,
                          ),
                          Text('all'.tr()),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  ListTile(
                      title: InkWell(
                    onTap: () => setState(() {
                      _verticalGroupValue = "new" ?? '';
                      cubit.setstatus("new");
                    }),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: _verticalGroupValue == 'new'
                                  ? AppColors.primary
                                  : AppColors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primary)),
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text('new'.tr()),
                      ],
                    ),
                  )),
                  ListTile(
                      title: InkWell(
                    onTap: () => setState(() {
                      _verticalGroupValue = "used" ?? '';
                      cubit.setstatus("used");
                    }),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: _verticalGroupValue == 'used'
                                  ? AppColors.primary
                                  : AppColors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primary)),
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text('used'.tr()),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: 'confirm'.tr(),
                color: AppColors.primary,
                onClick: () {
                  cubit.getFilterHome();
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
