import 'package:engwheels/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ShowLoadingIndicator extends StatelessWidget {
  const ShowLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      //  SizedBox(height: MediaQuery.of(context).size.height/2-50),
        Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
