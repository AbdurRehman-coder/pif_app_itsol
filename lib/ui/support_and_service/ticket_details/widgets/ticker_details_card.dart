import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/ticket_status.dart';
import 'package:pif_flutter/widgets/custom_image.dart';

class TicketDetailsCard extends StatelessWidget {
  const TicketDetailsCard({required this.ticketData, super.key});

  final SupportTicketModel ticketData;

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
          if (ticketData.attachment?.link != null) ...[
            CustomImage(
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(6.r),
              image:
                  NetworkImage(ticketData.attachment!.link!.href!.getImageUrl),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
          if (ticketData.ticketStatus != null) ...[
            TicketStatus(
              ticketStatus: ticketData.ticketStatus!,
            ),
          ],
          SizedBox(
            height: 10.h,
          ),
          HtmlWidget(
            ticketData.description ?? '',
            textStyle: Style.commonTextStyle(
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
                ticketData.dateCreated!
                    .toFormattedString('hh:mm a - dd/MM/yyyy'),
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
