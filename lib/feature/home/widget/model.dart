import 'package:engwheels/feature/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/no_data_widget.dart';
import '../../../core/widgets/show_loading_indicator.dart';

class CarModel extends StatefulWidget {
  const CarModel({Key? key}) : super(key: key);

  @override
  State<CarModel> createState() => _CarModelState();
}

class _CarModelState extends State<CarModel> {
  String _verticalGroupValue ="all".tr();
  
  @override
  Widget build(BuildContext context) {
HomeCubit cubit=context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
      if(state is CategoryLoading){
        return ShowLoadingIndicator();
      }
      else if(state is CategoryError){
        return NoDataWidget(onclick: () {
          cubit.getHome();
        }, title: "no_data".tr());
      }
      else{
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
                  Text("brand".tr(), style: TextStyle(color: AppColors.black1,
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
                  itemCount: cubit.categories.length+1,
                  itemBuilder: (context, index) {
                 return  InkWell(
                   onTap: () {
                     setState(() {
                       _verticalGroupValue=index==0?"all".tr():cubit.categories[index-1].id.toString();
                       index==0?cubit.setcategory("all"):cubit.setcategory(cubit.categories[index-1].id.toString());
                     });
                   },
                   child: Row(
                      children: [

                        Container(

                          decoration: BoxDecoration(
                              color: (index==0&&_verticalGroupValue=="all")||(index!=0&&_verticalGroupValue==cubit.categories[index-1].id.toString())?AppColors.primary:AppColors.white,
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primary)
                          ),
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(width: 4,),
                        Text( index==0?"all".tr():(EasyLocalization.of(context)!.currentLocale!.languageCode=='ar'?
                        cubit.categories.elementAt(index-1).titleAr:
                        cubit.categories.elementAt(index-1).titleEn)


                        ),
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
    );}
  },
);
  }
}
