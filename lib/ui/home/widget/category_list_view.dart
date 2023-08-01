import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/dashboard/provider/dashboard_provider.dart';
import 'package:pif_flutter/ui/home/provider/home_provider.dart';

class CategoryListView extends ConsumerWidget {
  const CategoryListView({
    required this.animationController,
    super.key,
  });

  final AnimationController animationController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homeProvider);
    final notifierDashboard = ref.read(dashboardProvider.notifier);
    final data = provider.lstCategory;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 40.h,
        mainAxisSpacing: 10.w,
        childAspectRatio: 0.6,
      ),
      itemCount: data.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            notifierDashboard.closeFloatMenu(
              animationController: animationController,
            );
            data[index].onTap!();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60.w,
                width: 60.w,
                padding: EdgeInsets.all(5.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: whiteColor,
                  border: Border.all(
                    width: 1.5,
                    color: grayD7,
                  ),
                ),
                child: Image.asset(
                  data[index].image ?? '',
                  fit: BoxFit.scaleDown,
                  height: 50.h,
                  width: 50.w,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Expanded(
                child: Text(
                  data[index].text ?? '',
                  style: Style.commonTextStyle(
                    color: textColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
