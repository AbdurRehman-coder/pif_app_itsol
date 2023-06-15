import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/visit_list/provider/visit_list_provider.dart';
import 'package:pif_flutter/ui/visit_list/widget/popup_menu_button.dart';
import 'package:pif_flutter/ui/visit_list/widget/single_visitor.dart';
import 'package:pif_flutter/ui/visit_list/widget/visit_information.dart';
import 'package:pif_flutter/ui/visit_list/widget/visitor_list.dart';

class VisitCard extends StatelessWidget {
  const VisitCard({
    required this.notifier,
    required this.visitModel,
    super.key,
  });

  final VisitListNotifier notifier;
  final VisitModel? visitModel;

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
                  text: visitModel?.visitStartDate == null
                      ? ''
                      : '${visitModel?.visitStartDate?.getTime()} - ${visitModel?.visitStartDate?.getCommonFormatDate(pattern: 'dd/MM/yyyy')}',
                ),
                const CustomPopupMenuButton(),
              ],
            ),
            SizedBox(
              height: 6.h,
            ),
            VisitInformation(
              svgImage: Assets.calendarDate,
              text: visitModel?.visitStartDate == null
                  ? ''
                  : '${visitModel?.visitEndDate?.getTime()} - ${visitModel?.visitEndDate?.getCommonFormatDate(pattern: 'dd/MM/yyyy')}',
            ),
            SizedBox(
              height: 13.h,
            ),
            SizedBox(
              height: 70.h,
              child: VisitorList(
                notifier: notifier,
              ),
            ).visibility(visible: false),
            const SingleVisitor(
              firstName: 'Khaled',
              lastName: 'moh',
              status: true,
              visitorEmail: 'example@gmail.com',
            ).visibility(),
          ],
        ),
      ),
    );
  }
}
