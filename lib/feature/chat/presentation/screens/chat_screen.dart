import 'package:cached_network_image/cached_network_image.dart';
import 'package:engwheels/core/widgets/my_svg_widget.dart';
import 'package:engwheels/feature/chat/cubit/chat_cubit.dart';
import 'package:engwheels/feature/message/cubit/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/assets_manager.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/widgets/no_data_widget.dart';
import '../../../../core/widgets/show_loading_indicator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {
   ChatCubit cubit=context.read<ChatCubit>();

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leadingWidth: MediaQuery.of(context).size.width,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Text(
              'chat'.tr(),
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: BlocBuilder<ChatCubit, ChatState>(
  builder: (context, state) {
    if(state is MyRoomsLoading){
    return ShowLoadingIndicator();
    }
    else if(state is MyRoomsError){
    return NoDataWidget(onclick: () {
    cubit.getRooms();
    }, title: "no_data".tr());
    }
    else {
      if (cubit.rooms.isNotEmpty) {
        return ListView.builder(
          itemCount: cubit.rooms.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                context.read<MessageCubit>().getMessages(cubit.rooms.elementAt(index).id);
                Navigator.pushNamed(context, Routes.messageRoute,arguments:cubit.rooms.elementAt(index) );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child:  Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(15)),
                          ),
                          child:cubit.rooms.elementAt(index).photo!=null?
                          CachedNetworkImage(
                            width: 48,
                            height: 48,
                            fit: BoxFit.fitWidth,
                            imageBuilder: (context, imageProvider) => Container(


                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            imageUrl: cubit.rooms.elementAt(index).photo!,):Container(),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit.rooms.elementAt(index).name,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.black1,
                                ),
                              ),
                              Text(
                                cubit.rooms.elementAt(index).lastMessage.text,
                                style: TextStyle(
                                  fontSize: 16,
                                  color:cubit.rooms.elementAt(index).unreadMessageNumber>0?AppColors.primary: AppColors.descriptionBoardingColor,
                                ),
                              ),
                            ],
                          ),

                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            cubit.rooms.elementAt(index).lastMessage.date,

                            style: TextStyle(
                              fontSize: 13,
                              color:AppColors.descriptionBoardingColor,
                            ),
                          ),
                          Visibility(
                            visible: cubit.rooms.elementAt(index).unreadMessageNumber>0?true:false,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: AppColors.primary),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    cubit.rooms.elementAt(index).unreadMessageNumber.toString(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppColors.white,

                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],)
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
      else {
        return NoDataWidget(onclick: () {
          cubit.getRooms();
        }, title: "no_data".tr());
      }
    }
  },
)
      ),
    );
  }

  @override
  void initState() {
    super.initState();

  }
}
