import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/features/content/structure_content/model/structure_content_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/utilities/constant.dart';
import 'package:pif_flutter/routes/routes.dart';

class BannerTextView extends StatelessWidget {
  const BannerTextView({
    required this.text,
    required this.imageCompany,
    required this.creator,
    required this.contentFields,
    required this.dateCreated,
    super.key,
  });

  final String text;
  final String imageCompany;
  final Creator creator;
  final DateTime dateCreated;
  final List<ContentField> contentFields;

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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70.h,
                  child: HtmlWidget(
                    text,
                    textStyle: Style.commonTextStyle(
                      color: blackColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () => AppRouter.pushNamed(
                    Routes.newsDetails,
                    args: [
                      creator,
                      dateCreated,
                      contentFields,
                    ],
                  ),
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
          ),
          CachedNetworkImage(
            imageUrl: Constant.imageBaseUrl + imageCompany,
            width: 70.w,
            height: 70.h,
          ),
        ],
      ),
    );
  }
}
