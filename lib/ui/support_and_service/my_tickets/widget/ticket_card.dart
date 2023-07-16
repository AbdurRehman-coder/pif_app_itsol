import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/ticket_status.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    required this.ticketModel,
    required this.index,
    super.key,
  });

  final SupportTicketModel? ticketModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRouter.pushNamed(
        Routes.ticketDetailsScreen,
        args: ticketModel,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 15.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TicketStatus(
                  ticketStatus: ticketModel!.ticketStatus!,
                ),
                if (index > 0) ...[
                  Badge(
                    label: Text(index.toString()),
                    backgroundColor: primaryColor,
                    child: const Icon(
                      Icons.email_outlined,
                      size: 25,
                      color: hintColor,
                    ),
                  )
                ] else ...[
                  const Icon(
                    Icons.email_outlined,
                    size: 25,
                    color: hintColor,
                  ),
                ],
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              ticketModel?.description ?? '',
              style: Style.commonTextStyle(
                color: blackColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  size: 20,
                  color: hintColor,
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  ticketModel!.dateCreated!.toFormattedString('hh:mm a - dd/MM/yyyy'),
                  style: Style.commonTextStyle(
                    color: grayTextColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
