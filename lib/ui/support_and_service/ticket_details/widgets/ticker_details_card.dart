import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/model/tiicket_model.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/ticket_status.dart';

class TicketDetailsCard extends StatelessWidget {
  const TicketDetailsCard({required this.ticketData, super.key});

  final TicketModel ticketData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: const [
          BoxShadow(
            color: grayEB,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (ticketData.attachment.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: ticketData.attachment,
                fit: BoxFit.cover,
                height: 170.h,
                width: context.screenWidth,
                placeholder: (context, url) => Image.asset(
                  Assets.placeHolder,
                  fit: BoxFit.fill,
                  height: 170.h,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  Assets.placeHolder,
                  fit: BoxFit.fill,
                  height: 170.h,
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
          TicketStatus(
            ticketStatus: ticketData.ticketStatus,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            ticketData.ticketDescription ?? '',
            style: Style.commonTextStyle(
              color: blackColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              const Icon(
                Icons.calendar_today_rounded,
                size: 18,
                color: hintColor,
              ),
              SizedBox(width: 10.w),
              Text(
                '7:00 pm - 21/3/2023',
                style: Style.commonTextStyle(
                  color: grayTextColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ],
      ),
    );
    ;
  }
}
