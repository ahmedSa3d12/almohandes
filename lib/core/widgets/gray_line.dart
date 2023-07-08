import 'package:flutter/material.dart';

class GrayLine extends StatelessWidget {
  const GrayLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        thickness: 2,
      ),
    );
  }
}
