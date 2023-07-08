import 'package:engwheels/core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OutLineButtonWidget extends StatelessWidget {
  const OutLineButtonWidget({Key? key, required this.text, required this.borderColor, required this.onclick}) : super(key: key);

  final String text;
  final Color borderColor;
  final VoidCallback onclick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>onclick(),
      child: Container(
        width: 100,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            
          ),
          borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        child: Center(
          child: Text(text.tr(),style: TextStyle(color: AppColors.black1,fontSize: 14),),
        ),
      ),
    );
  }
}
