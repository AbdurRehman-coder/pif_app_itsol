import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/popup_menu_button.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/single_visitor.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/visit_information.dart';

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
      backgroundColor: expireBgColor,
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
          S.of(context).invitationDetails,
          style: Style.commonTextStyle(
            color: blackColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: const [
          CustomPopupMenuButton(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
            vertical: 24.h,
            horizontal: 16.w,
          ),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(borderRadius),
              topLeft: Radius.circular(borderRadius),
            ),
          ),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 4.h,
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
                SizedBox(
                  height: 16.h,
                ),
                VisitInformation(
                  svgImage: Assets.calendar,
                  text: visitModel?.visitStartDate == null
                      ? ''
                      : '${visitModel?.visitStartDate?.getTime()} - ${visitModel?.visitStartDate?.getCommonFormatDate(pattern: 'dd/MM/yyyy')}',
                ),
                SizedBox(
                  height: 15.h,
                ),
                VisitInformation(
                  svgImage: Assets.calendarDate,
                  text: visitModel?.visitEndDate == null
                      ? ''
                      : '${visitModel?.visitEndDate?.getTime()} - ${visitModel?.visitEndDate?.getCommonFormatDate(pattern: 'dd/MM/yyyy')}',
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  S.of(context).visitors,
                  style: boldStyle,
                ),
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 20.h),
                  itemBuilder: (_, index) {
                    final visit = visitModel!.visitors![index];
                    return SingleVisitor(
                      status: true,
                      showStatus: true,
                      visitorsModel: visit,
                    );
                  },
                  separatorBuilder: (_, index) {
                    return Divider(
                      color: gray9E,
                      height: 30.h,
                      thickness: 0.5,
                    );
                  },
                  itemCount: visitModel!.visitors!.length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
