import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/visit/visit_list/model/visit_model.dart';
import 'package:pif_flutter/ui/visit/visit_list/provider/visit_list_provider.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/popup_menu_button.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/single_visitor.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/visit_information.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/visitor_list.dart';

class VisitCard extends StatelessWidget {
  const VisitCard({
    required this.notifier,
    required this.visitModel,
    super.key,
  });

  final VisitListNotifier notifier;
  final VisitsModel? visitModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRouter.pushNamed(
        Routes.invitationDetailsScreen,
        args: visitModel,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
          border: Border.all(
            color: grayBorderColor,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VisitInformation(
                  svgImage: Assets.calendar,
                  text: visitModel?.startDateTimeVisit == null
                      ? ''
                      : '${visitModel?.startDateTimeVisit?.getTime()} - ${visitModel?.startDateTimeVisit?.getCommonFormatDate(pattern: 'dd/MM/yyyy')}',
                ),
                const CustomPopupMenuButton(),
              ],
            ),
            SizedBox(
              height: 6.h,
            ),
            VisitInformation(
              svgImage: Assets.clock,
              text: visitModel?.endDateTimeVisit == null
                  ? ''
                  : '${visitModel?.endDateTimeVisit?.getTime()} - ${visitModel?.endDateTimeVisit?.getCommonFormatDate(pattern: 'dd/MM/yyyy')}',
            ),
            SizedBox(
              height: 13.h,
            ),
            SizedBox(
              height: 70.h,
              child: VisitorList(
                visitModel: visitModel?.visitModel,
              ),
            ).visibility(
              // ignore: avoid_bool_literals_in_conditional_expressions
              visible: visitModel?.visitModel != null ? visitModel!.visitModel!.length > 1 : false,
            ),
            SingleVisitor(
              status: true,
              visitorsModel: visitModel?.visitModel?.first,
            ).visibility(
              // ignore: avoid_bool_literals_in_conditional_expressions
              visible: visitModel?.visitModel != null ? visitModel!.visitModel!.length == 1 : false,
            ),
          ],
        ),
      ),
    );
  }
}
