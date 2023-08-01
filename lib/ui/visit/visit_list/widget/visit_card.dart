import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/visit/visit_list/provider/visit_list_provider.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/popup_menu_button.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/single_visitor.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/start_end_time.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/visitor_list.dart';

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
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => AppRouter.pushNamed(
        Routes.invitationDetailsScreen,
        args: visitModel,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: whiteColor,
          boxShadow: const [
            BoxShadow(
              color: grayGradientStart,
              offset: Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(8.r),
          ),
          border: Border.all(
            color: grayBorderColor,
            width: 0.5.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// For Single visitor
                if (visitModel?.visitors != null &&
                    visitModel!.visitors!.isNotEmpty) ...[
                  Expanded(
                    child: SingleVisitor(
                      status: true,
                      visitorsModel: visitModel?.visitors?.first,
                    ).visibility(
                      // ignore: avoid_bool_literals_in_conditional_expressions
                      visible: visitModel!.visitors!.length == 1,
                    ),
                  ),
                ],

                /// For list of visitors
                if (visitModel?.visitors != null &&
                    visitModel!.visitors!.isNotEmpty) ...[
                  SizedBox(
                    height: 70.h,
                    width: size.width * 0.7,
                    child: VisitorList(
                      visitModel: visitModel?.visitors,
                    ),
                  ).visibility(
                    // ignore: avoid_bool_literals_in_conditional_expressions
                    visible: visitModel!.visitors!.length > 1,
                  ),
                ],
                const CustomPopupMenuButton(),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            StartEndTime(
              visitModel: visitModel,
            ),
          ],
        ),
      ),
    );
  }
}
