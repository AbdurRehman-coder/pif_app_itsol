import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/visit/visit_list/provider/visit_list_provider.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/visit_status.dart';

class VisitsListView extends StatelessWidget {
  const VisitsListView({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Visits list',
          style: Style.commonTextStyle(
            color: blackColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: GestureDetector(
              onTap: () => AppRouter.pushNamed(Routes.inviteVisitorScreen),
              child: Container(
                width: 26.w,
                height: 26.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryColor),
                ),
                child: Icon(
                  Icons.add,
                  color: primaryColor,
                  size: 18.w,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final notifier = ref.read(visitListProvider.notifier);
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 27.h),
                  CustomTextField(
                    textEditingController: notifier.searchVisitController,
                  ),
                  SizedBox(height: 16.h),
                  const VisitStatus(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
