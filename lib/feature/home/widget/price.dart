import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/widgets/custom_button.dart';
import 'package:range_slider_flutter/range_slider_flutter.dart';

import '../cubit/home_cubit.dart';

class Price extends StatefulWidget {
  const Price({Key? key}) : super(key: key);

  @override
  State<Price> createState() => _PriceState();
}

class _PriceState extends State<Price> {
  int _counter = 0;

  double _lowerValue = 50;
  double _upperValue = 180;
  @override
  Widget build(BuildContext context) {
    HomeCubit cubit=context.read<HomeCubit>();

    return Container(
      color:AppColors.transparent1,
      child: Container(

        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16),
              topRight: Radius.circular(16)),

        ),
        child:
        ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("price".tr(), style: TextStyle(color: AppColors.black1,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child:
                    Container(
                      width: 30,
                      height: 30,

                      child: Icon(Icons.close,color: AppColors.white,),
                      decoration:BoxDecoration(
                          color: AppColors.black1,
                          shape: BoxShape.circle
                      ) ,
                    ),
                  )
                ],
              ),

            ),
            Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Container(
                margin: EdgeInsets.only(top: 20,left: 20,right: 40),
                alignment: Alignment.centerLeft,
                child: RangeSliderFlutter(
                  // key: Key('3343'),
                  values: [_lowerValue, _upperValue],
rtl: EasyLocalization.of(context)!.currentLocale!.languageCode=='ar'?true:false,
                  rangeSlider: true,

                  max: 200000,

                  handlerHeight:20,
                  textBackgroundColor: Colors.red,

                  trackBar: RangeSliderFlutterTrackBar(
                    activeTrackBarHeight: 4,
                    inactiveTrackBarHeight: 4,
                    activeTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red,
                    ),
                    inactiveTrackBar: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                  ),
                  // handler: RangeSliderFlutterHandler(
                  //   decoration: BoxDecoration(
                  //     color: Colors.yellow,
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  // ),
                  min: 0,
                  fontSize: 15,

                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    _lowerValue = lowerValue;
                    _upperValue = upperValue;
                    cubit.setprice(_lowerValue,_upperValue);
                    setState(() {});
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(_lowerValue.toString(), style: TextStyle(color: AppColors.black1,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),),
                      Text("qar".tr(), style: TextStyle(color: AppColors.descriptionBoardingColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Row(
                    children: [
                      Text(_upperValue.toString(), style: TextStyle(color: AppColors.black1,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),

                      ),
                      Text("qar".tr(), style: TextStyle(color: AppColors.descriptionBoardingColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(text: 'confirm'.tr(),color: AppColors.primary,onClick: () {
                cubit.getFilterHome();
                Navigator.pop(context);
              },),
            )
          ],
        ),
      ),
    );
  }
}
