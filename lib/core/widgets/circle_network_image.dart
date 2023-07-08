import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class ManageCircleNetworkImage extends StatelessWidget {
  const ManageCircleNetworkImage(
      {Key? key, required this.imageUrl, this.height = 0, this.width = 0})
      : super(key: key);

  final String imageUrl;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        child: ClipOval(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        height: height != 0 ? height : null,
        width: width != 0 ? width : null,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      ),
    ));
  }
}
