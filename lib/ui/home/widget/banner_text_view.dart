import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/features/content/structure_content/model/structure_content_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart' as html;
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/utilities/constant.dart';
import 'package:pif_flutter/routes/routes.dart';

class BannerTextView extends StatelessWidget {
  const BannerTextView({
    required this.text,
    required this.imageCompany,
    required this.creator,
    required this.contentFields,
    required this.newsType,
    required this.dateCreated,
    super.key,
  });

  final String text;
  final String? imageCompany;
  final Creator creator;
  final DateTime dateCreated;
  final String newsType;
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
                  height: 60.h,
                  child: html.Html(
                    data: text,
                    style: {
                      '#': html.Style(
                        fontSize: html.FontSize(18),
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    },
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
                      newsType,
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
          if (imageCompany != null) ...[
            CachedNetworkImage(
              imageUrl: Constant.imageBaseUrl + imageCompany!,
              width: 70.w,
              height: 70.h,
            ),
          ],
        ],
      ),
    );
  }
}
