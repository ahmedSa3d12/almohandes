import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/my_svg_widget.dart';
import '../../../chat/presentation/screens/chat_screen.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../news/presentation/screens/news_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../cubit/mainscreens_cubit.dart';

class MainScreens extends StatefulWidget {
  const MainScreens({Key? key}) : super(key: key);

  @override
  State<MainScreens> createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainscreensCubit, MainscreensState>(
      builder: (context, state) {
        return Scaffold(
          body: pages(),

          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              if(value==1){
                if(context.read<MainscreensCubit>().userModel==null) {
                  Navigator.pushNamed(context, Routes.loginRoute);
                }
                else{
                  context.read<MainscreensCubit>().setIndex(value);
                }
              }
              else{
              context.read<MainscreensCubit>().setIndex(value);
            }},
              items: <BottomNavigationBarItem>[

                BottomNavigationBarItem(

                    icon: SvgPicture.asset('assets/icons/home.svg',
                    color: context.read<MainscreensCubit>().index==0?AppColors.primary:AppColors.descriptionBoardingColor, ),

                    label: ''

                ), BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/message.svg',
                        color: context.read<MainscreensCubit>().index==1?AppColors.primary:AppColors.descriptionBoardingColor),

                    label: ''
                ), BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/news.svg',
                        color: context.read<MainscreensCubit>().index==2?AppColors.primary:AppColors.descriptionBoardingColor),

                    label: ''
                ), BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/user.svg',
                        color: context.read<MainscreensCubit>().index==3?AppColors.primary:AppColors.descriptionBoardingColor),

                    label: ''
                ),
              ]),
        );
      },
    );
  }

  Widget pages() {
    _page=context.read<MainscreensCubit>().index;
    if (_page == 0) {
      return HomeScreen();
    } else if (_page == 1) {
      return ChatScreen();
    } else if (_page == 2) {
      return NewsScreen();
    } else {
      return ProfileScreen();
    }
  }
}
