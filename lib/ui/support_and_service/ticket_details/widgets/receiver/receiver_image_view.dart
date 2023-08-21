import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/features/commerce/tickets/model/ticket_comment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/image_profile_visitor.dart';

class ReceiverImageView extends StatelessWidget {
  const ReceiverImageView({required this.item, super.key});

  final TicketCommentModel item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 25.h),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 176.w,
              height: 160.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: expireBgColor,
                border: Border.all(color: grayBorderColor),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: CachedNetworkImage(
                imageUrl: item.commentAttachment!.getImageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Image.asset(
                  Assets.placeHolder,
                  fit: BoxFit.fill,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  Assets.spaceBg2,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            if (item.commentDescription != null ||
                item.commentDescription != '') ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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
            ],
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
      ],
    );
  }
}
