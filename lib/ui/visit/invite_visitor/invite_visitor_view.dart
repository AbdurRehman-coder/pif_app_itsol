import 'package:awesome_calendar/awesome_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/routes/app_router.dart';

class InviteVisitorView extends StatelessWidget {
  InviteVisitorView({super.key});

  final startDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate({
      required BuildContext context,
      DateTime? selectedDate,
    }) async {
      final picked = await showDialog<List<DateTime>>(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AwesomeCalendarDialog(
                canToggleRangeSelection: true,
                startDate: selectedDate,
                initialDate: selectedDate,
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: expireBgColor,
        leading: IconButton(
          onPressed: AppRouter.pop,
          icon: SvgPicture.asset(
            Assets.back,
            height: 14.h,
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0,
        title: Text(
          'Invite Visitors',
          style: Style.commonTextStyle(
            color: blackColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      textEditingController: startDate,
                      suffixIcon: IconButton(
                        onPressed: () => selectDate(context: context),
                        icon: SvgPicture.asset(Assets.booking),
                      ),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    '-',
                    style: Style.commonTextStyle(
                      color: blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: CustomTextField(
                      textEditingController: startDate,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
