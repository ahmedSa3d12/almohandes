import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/app_colors.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({Key? key, required this.imagePath, required this.text}) : super(key: key);

  final String imagePath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          imagePath,
          width: 120,
          height: 120,
        ),
        SizedBox(height: 50),
        Text(
          text.tr(),
          style: TextStyle(
            color: AppColors.secondPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
