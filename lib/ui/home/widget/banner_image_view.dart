import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/helpers/assets.dart';

class BannerImageView extends StatelessWidget {
  const BannerImageView({required this.imageUrl, super.key});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: 358.w,
        placeholder: (context, url) => Image.asset(
          Assets.placeHolder,
          fit: BoxFit.fill,
        ),
        errorWidget: (context, url, error) => Image.asset(
          Assets.spaceBg2,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
