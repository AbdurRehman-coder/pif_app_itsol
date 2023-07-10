import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/model/tiicket_model.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/widget/ticket_status.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    required this.ticketModel,
    required this.index,
    super.key,
  });

  final TicketModel? ticketModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>AppRouter.pushNamed(Routes.supportScreen),
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TicketStatus(
                  ticketStatus: ticketModel!.ticketStatus,
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
                  ),
                ],
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              ticketModel?.ticketText ?? '',
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
                  size: 20,
                  color: hintColor,
                ),
                SizedBox(width: 10.w),
                Text(
                  '7:00 pm - 21/3/2023',
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
