import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconWithTextWidget extends StatelessWidget {
  const IconWithTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor})
      : super(key: key);
  final String icon;
  final String text;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          color: iconColor,
          width: 16,
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8, left: 8),
          child: Text(
            " $text",
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }
}
