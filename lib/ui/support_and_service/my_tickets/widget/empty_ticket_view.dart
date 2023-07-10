import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';

class EmptyTicketView extends StatelessWidget {
  const EmptyTicketView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 100.h),
      child: Column(
        children: [
          SvgPicture.asset(
            Assets.emptyTicket,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            S.of(context).ticketEmpty,
            textAlign: TextAlign.center,
            style: Style.commonTextStyle(
              color: primaryColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            S.of(context).youDidNotRaiseAnyTicketsYet,
            textAlign: TextAlign.center,
            style: Style.commonTextStyle(
              color: textColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
