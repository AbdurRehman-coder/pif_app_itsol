import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/services/index.dart';

class ServicePage extends ConsumerWidget {
  const ServicePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(serviceProvider);
    final notifier = ref.read(serviceProvider.notifier);
    return Scaffold(
      backgroundColor: lightGrayBgColor,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: SizedBox(
              height: 50.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16.w),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      notifier.updateCategory(provider.lstCategory[index].categoryId!);
                    },
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        alignment: Alignment.center,
                        height: 40.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: provider.lstCategory[index].isSelected! ? secondary : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.10),
                              blurRadius: 4.r,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          provider.lstCategory[index].categoryName ?? '',
                          style: Style.commonTextStyle(
                            color: provider.lstCategory[index].isSelected! ? Colors.white : darkBorderColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 10.h,
                  );
                },
                itemCount: provider.lstCategory.length,
              ),
            ),
          ),
          SizedBox(
            height: 19.h,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 80.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Creative Services',
                    style: Style.commonTextStyle(
                      color: textColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ).visibility(visible: provider.isCreative),
                  SizedBox(
                    height: 10.h,
                  ).visibility(visible: provider.isCreative),
                  const CreativeServiceView().visibility(visible: provider.isCreative),
                  SizedBox(
                    height: 40.h,
                  ).visibility(visible: provider.isCreative && provider.isCanceled),
                  Text(
                    'Foundational Services',
                    style: Style.commonTextStyle(
                      color: textColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ).visibility(visible: provider.isFundamental),
                  SizedBox(
                    height: 10.h,
                  ).visibility(visible: provider.isFundamental),
                  const FoundationalServiceView().visibility(visible: provider.isFundamental),
                  SizedBox(
                    height: 40.h,
                  ).visibility(visible: provider.isCreative && provider.isFundamental),
                  Text(
                    'Canceled Services',
                    style: Style.commonTextStyle(
                      color: textColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ).visibility(visible: provider.isCanceled),
                  SizedBox(
                    height: 10.h,
                  ).visibility(visible: provider.isCanceled),
                  const CanceledServiceView().visibility(visible: provider.isCanceled),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
