import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/features/commerce/tickets/model/ticket_comment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/image_profile_visitor.dart';

class ReceiverTextView extends StatelessWidget {
  const ReceiverTextView({required this.item, super.key});

  final TicketCommentModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: item.creator?.image != null
                    ? item.creator!.image!.getImageUrl
                    : '',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                width: 24.w,
                height: 24.w,
                fit: BoxFit.cover,
                placeholder: (context, url) => const SizedBox(),
                errorWidget: (context, url, error) => ImageProfileVisitor(
                  firstName: item.creator!.givenName.toString(),
                  lastName: item.creator!.familyName.toString(),
                  fontSize: 12,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: expireBgColor,
                    border: Border.all(color: grayBorderColor),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: HtmlWidget(
                    item.commentDescription ?? '',
                    textStyle: Style.commonTextStyle(
                      color: textColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    item.dateCreated!.toLocal().toFormattedString('hh:mm a'),
                    style: Style.commonTextStyle(
                      color: dayTextColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
