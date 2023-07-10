import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/provider/my_tickets_provider.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/state/my_tickets_state.dart';

class TicketListStatus extends StatelessWidget {
  const TicketListStatus({
    required this.notifier,
    required this.provider,
    super.key,
  });

  final MyTicketsNotifier notifier;
  final MyTicketsState provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55.h,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        scrollDirection: Axis.horizontal,
        itemCount: notifier.ticketsStatusList.length,
        itemBuilder: (_, index) {
          final isTicketSelect = provider.ticketStatusIndex == index;
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: InkWell(
              onTap: () =>
                  notifier.updateSelectTicketStatus(indexNewSelect: index),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isTicketSelect ? secondary : whiteColor,
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: const [
                    BoxShadow(
                      color: greyDivider,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(0, 1),
                    )
                  ],
                ),
                child: Text(
                  notifier.ticketsStatusList[index],
                  style: Style.commonTextStyle(
                    color: isTicketSelect ? whiteColor : darkBorderColor,
                    fontSize: 14.sp,
                    height: 1.4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, index) {
          return SizedBox(width: 10.w);
        },
      ),
    );
  }
}
