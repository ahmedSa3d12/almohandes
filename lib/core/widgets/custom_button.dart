import 'package:engwheels/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onClick,
    this.paddingHorizontal = 0,
    this.borderRadius = 8,
    this.textcolor=Colors.white, this.enable=true,

  }) : super(key: key);
  final String text;
  final Color color;
  final Color textcolor;
  final double paddingHorizontal;
  final double? borderRadius;
  final bool? enable;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
      child: ElevatedButton(

        onPressed:enable!? onClick:null,

        style: ElevatedButton.styleFrom(

          maximumSize: Size.infinite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          minimumSize: const Size(double.infinity, 60),
          backgroundColor: enable!?color:AppColors.gray2,

        ),
        child: Text(text,
        style: TextStyle(color:textcolor ),),
      ),
    );
  }
}
