import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:engwheels/core/models/chat_data_model.dart';
import 'package:engwheels/core/utils/assets_manager.dart';
import 'package:engwheels/core/widgets/show_loading_indicator.dart';
import 'package:engwheels/feature/message/cubit/message_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bubble/bubble.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/my_svg_widget.dart';
import '../../../../core/widgets/no_data_widget.dart';

class MessgeScreen extends StatefulWidget {
  const MessgeScreen({Key? key, required this.chatModel}) : super(key: key);
  final ChatModel chatModel;

  @override
  State<MessgeScreen> createState() => _MessgeState();
}

class _MessgeState extends State<MessgeScreen> {
  @override
  Widget build(BuildContext context) {

    MessageCubit cubit = context.read<MessageCubit>();

    return Scaffold(

      appBar: AppBar(
          // actions: [
          //
          //   PopupMenuButton(
          //     // add icon, by default "3 dot" icon
          //     // icon: Icon(Icons.book)
          //       itemBuilder: (context) {
          //         return [
          //           PopupMenuItem<int>(
          //             value: 0,
          //             child: Text("report".tr()),
          //           ),
          //
          //           PopupMenuItem<int>(
          //             value: 1,
          //             child: Text("block".tr()),
          //           ),
          //
          //
          //         ];
          //       },
          //       onSelected: (value) {
          //         if (value == 0) {
          //           print("My account menu is selected.");
          //         } else if (value == 1) {
          //           print("Settings menu is selected.");
          //         }
          //       }
          //   ),
          //
          // ],
          iconTheme: IconThemeData(color: AppColors.black),
          centerTitle: false,
          elevation: 0,
          leadingWidth: 30,
          titleSpacing: 10,
          toolbarHeight: 90,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 16),
            child: Text(
              widget.chatModel.name,
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          )),
      body: SafeArea(
        child:
        Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: BlocBuilder<MessageCubit, MessageState>(
                    builder: (context, state) {
                      if (state is MessageLoading) {
                        return ShowLoadingIndicator();
                      }
                      else if (state is MessageError) {
                        return NoDataWidget(onclick: () {
                          cubit.getMessages(widget.chatModel.id);
                        }, title: "no_message".tr());
                      }
                      else {
                        return Expanded(

                            child: ListView.builder(
                              controller: cubit.scrollController,
                              shrinkWrap: true,
                              reverse: true,
                              itemCount: cubit.messages.length,
                              itemBuilder: (context, index) {

                                return

                                  Align(
                                      alignment: cubit.userModel!.data!.id ==
                                          cubit.messages
                                              .elementAt(index)
                                              .fromUserId ? Alignment
                                          .centerRight
                                          : Alignment.centerLeft,
                                      child: Column(

                                        children: [
                                          Align(
                                            alignment: cubit.userModel!.data!
                                                .id == cubit.messages
                                                .elementAt(index)
                                                .fromUserId ? Alignment
                                                .centerRight
                                                : Alignment.centerLeft,
                                            child: Bubble(
                                              color: cubit.userModel!.data!
                                                  .id == cubit.messages
                                                  .elementAt(index)
                                                  .fromUserId
                                                  ? (cubit.messages
                                                  .elementAt(index)
                                                  .text.isEmpty ?
                                              AppColors.white
                                                  : AppColors.primary)
                                                  :
                                              cubit.messages
                                                  .elementAt(index)
                                                  .text.isEmpty ? AppColors
                                                  .white : AppColors.gray2
                                              ,
                                              margin: BubbleEdges.only(top: 10),
                                              nip: cubit.userModel!.data!.id ==
                                                  cubit.messages
                                                      .elementAt(index)
                                                      .fromUserId
                                                  ? BubbleNip.rightBottom
                                                  : BubbleNip.leftBottom,
                                              elevation:
                                              cubit.messages
                                                  .elementAt(index)
                                                  .text.isEmpty
                                                  ? 0
                                                  : 2,
                                              child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(0),
                                                  child: (cubit.messages
                                                      .elementAt(index)
                                                      .text.isEmpty
                                                      ?
                                                  CachedNetworkImage(
                                                      height: 290,
                                                      imageUrl: cubit.messages
                                                          .elementAt(index)
                                                          .image,
                                                      placeholder: (context,
                                                          url) =>
                                                          Container(
                                                            color: AppColors
                                                                .gray2,
                                                          ),
                                                      errorWidget: (context,
                                                          url, error) =>
                                                          Container(
                                                            color: AppColors
                                                                .gray2,
                                                          ))
                                                      : Text(
                                                    cubit.messages
                                                        .elementAt(index)
                                                        .text,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      color: cubit.userModel!
                                                          .data!.id ==
                                                          cubit.messages
                                                              .elementAt(index)
                                                              .fromUserId
                                                          ? Colors.white
                                                          : AppColors.black1,
                                                      fontSize: 20.0,
                                                    ),
                                                  ))),
                                            ),
                                          ),
                                          Align(
                                              alignment: cubit.userModel!.data!
                                                  .id == cubit.messages
                                                  .elementAt(index)
                                                  .fromUserId ? Alignment
                                                  .centerRight
                                                  : Alignment.centerLeft,
                                              child: Text(cubit.messages
                                                  .elementAt(index)
                                                  .time, style: TextStyle(
                                                  color: AppColors
                                                      .descriptionBoardingColor,
                                                  fontSize: 10),))
                                        ],
                                      )
                                  );
                              },));
                      }
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [

                      Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                border: Border.all(color: AppColors.gray2),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(8))),
                            child:
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: AppColors.black1, fontSize: 14),
                                    keyboardType: TextInputType.text,
controller: cubit.textxontrol,

                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(7),
                                      border: InputBorder.none,
                                      hintText: "write_here",
                                      hintStyle: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.black1),
                                    ),
                                  ),
                                ),

                                IconButton(
                                  icon: Icon(Icons.camera_alt_outlined),
                                  color: AppColors.descriptionBoardingColor,
                                  iconSize: 25.0,
                                  onPressed: () {
                                     buildAlertDialog();
                                  },
                                ),

                              ],
                            ),
                          )),
                      InkWell(
                        onTap: () {
                          cubit.sendMessage(cubit.textxontrol.text, "", widget.chatModel.id);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.all(Radius.circular(16))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: MySvgWidget(path: ImageAssets.sendIcon,
                              imageColor: AppColors.white,
                              size: 20,),
                          ),
                        ),
                      ),
                    ],
                  ),
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
  buildAlertDialog() {
    return showDialog(
        context: context,
        builder: (c) {
          return BlocBuilder<MessageCubit, MessageState>(
            builder: (context, state) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'choose_photo'.tr(),
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      height: 1,
                      color: AppColors.gray4,
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        context.read<MessageCubit>().pickImage(type: 'camera', user_id: widget.chatModel.id,);
                      },
                      child: Text(
                        'camera'.tr(),
                        style:
                        TextStyle(fontSize: 18.0, color: AppColors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 12.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        context
                            .read<MessageCubit>()
                            .pickImage(type: 'gallery',user_id: widget.chatModel.id);
                      },
                      child: Text(
                        'gallery'.tr(),
                        style:
                        TextStyle(fontSize: 18.0, color: AppColors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 24.0,
                    ),
                    Container(
                      height: 1,
                      color: AppColors.gray4,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'cancel'.tr(),
                        style:
                        TextStyle(fontSize: 18.0, color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
