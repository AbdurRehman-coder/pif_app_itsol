import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';

class BannerTextView extends StatelessWidget {
  const BannerTextView({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(14.r),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            expireBgColor.withOpacity(0.3),
            borderColor.withOpacity(0.3),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Welcome company\n',
                  style: Style.commonTextStyle(
                    color: blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: 'Neom to the co-builder',
                      style: Style.commonTextStyle(
                        color: blackColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  AppRouter.pushNamed(Routes.homeReadMoreScreen);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                    vertical: 10.h,
                  ),
                ),
                child: Text(
                  S.current.readMore,
                  style: Style.commonTextStyle(
                    color: whiteColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          CachedNetworkImage(
            imageUrl: 'http://20.74.136.229/documents/d/guest/group-1686551514',
            width: 70.w,
            height: 70.h,
          ),
        ],
      ),
    );
  }
}
