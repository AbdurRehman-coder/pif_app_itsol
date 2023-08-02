import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/background_widget.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/popup_menu_button.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/single_visitor.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/start_end_time.dart';

class InvitationDetailsView extends StatelessWidget {
  const InvitationDetailsView({
    required this.visitModel,
    super.key,
  });

  final VisitModel? visitModel;

  @override
  Widget build(BuildContext context) {
    final borderRadius = 24.r;
    final boldStyle = Style.commonTextStyle(
      color: blackColor,
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
    );
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).invitationDetails,
        actionWidget: [
          Padding(
            padding: EdgeInsets.only(top: 8.h, right: 16),
            child: const CustomPopupMenuButton(
              isFromDetails: true,
            ),
          ),
        ],
      ),
      body:BackgroundWidget(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 16.w,
          ),
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).visitors,
                    style: Style.commonTextStyle(
                      color: blackColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.h,
                      horizontal: 16.w,
                    ),
                    decoration: BoxDecoration(
                      color: loggedBgColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.r),
                      ),
                    ),
                    child: Text(
                      S.of(context).upComing,
                      style: Style.commonTextStyle(
                        color: goldenColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 16.h),
                itemBuilder: (_, index) {
                  final visit = visitModel!.visitors![index];
                  return Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: grayGradientStart,
                          offset: Offset(0, 2),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                      color: whiteColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.r),
                      ),
                      border: Border.all(
                        color: grayBorderColor,
                        width: 0.5.w,
                      ),
                    ),
                    child: SingleVisitor(
                      status: true,
                      showStatus: true,
                      visitorsModel: visit,
                    ),
                  );
                },
                separatorBuilder: (_, index) {
                  return SizedBox(
                    height: 12.h,
                  );
                },
                itemCount: visitModel!.visitors!.length,
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                S.of(context).dateTime,
                style: Style.commonTextStyle(
                  color: blackColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              StartEndTime(
                visitModel: visitModel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
