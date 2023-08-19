import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/home/widget/walking_widget.dart';

class ComingVisitorCard extends StatelessWidget {
  const ComingVisitorCard({
    required this.visit,
    super.key,
  });

  final VisitModel visit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRouter.pushNamed(
        Routes.invitationDetailsScreen,
        args: visit,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.comingVisitorBackground,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.comingVisitor,
              style: Style.commonTextStyle(
                color: blackColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: 24.h,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final visitor = visit.visitors![index];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        visitor.name ?? '',
                        style: Style.commonTextStyle(
                          color: whiteColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, index) {
                  return SizedBox(width: 10.w);
                },
                itemCount: visit.visitors!.length,
              ),
            ),
            SizedBox(height: 13.h),
            WalkingWidget(
              visit: visit,
            ),
          ],
        ),
      ),
    );
  }
}
