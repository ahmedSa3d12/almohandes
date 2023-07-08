import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/widgets/custom_button.dart';
import '../cubit/home_cubit.dart';

class IndustryYear extends StatefulWidget {
  const IndustryYear({Key? key}) : super(key: key);

  @override
  State<IndustryYear> createState() => _IndustryYearState();
}

class _IndustryYearState extends State<IndustryYear> {
  String _verticalGroupValue = "all".tr();
  int currentYear = DateTime.now().year;
  int startingYear = 1950;
  List data=[];

  @override
  void initState() {
    super.initState();
    List yearList = List.generate((currentYear-startingYear)+1, (index) => startingYear+index);
    data.add("all");
    data.addAll(yearList);
  }

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
                  Text("industry_year".tr(), style: TextStyle(color: AppColors.black1,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                child: ListView.builder(

                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                 return  InkWell(
                   onTap: () {
                     setState(() {
                       _verticalGroupValue=data[index].toString();
                       cubit.setyear(data[index].toString());
                     });
                   },
                   child: Row(
                      children: [

                        Container(

                          decoration: BoxDecoration(
                              color: _verticalGroupValue==data.elementAt(index).toString()?AppColors.primary:AppColors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primary)
                          ),
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 4,),
                        Text(data.elementAt(index).toString()),
                      ],
                    ),
                 );
                },),
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
