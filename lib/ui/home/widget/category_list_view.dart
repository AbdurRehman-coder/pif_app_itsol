import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_lottie_widget.dart';
import 'package:pif_flutter/helpers/constants.dart';
import 'package:pif_flutter/ui/dashboard/provider/dashboard_provider.dart';
import 'package:pif_flutter/ui/home/provider/home_provider.dart';
import 'package:pif_flutter/ui/home/widget/services_loader.dart';

class CategoryListView extends ConsumerWidget {
  const CategoryListView({
    required this.animationController,
    super.key,
  });

  final AnimationController animationController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);
    final notifierDashboard = ref.read(dashboardProvider.notifier);
    return provider.servicesList.when(
      data: (data) {
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
            final serviceImage =
                '${Constants.baseUrl}${data[index].contentFields?.where((content) => content.name == 'lottieFile').firstOrNull?.contentFieldValue?.document?.contentUrl}';
            final servicesText = data[index]
                .contentFields
                ?.where((content) => content.name == 'Text57336959')
                .firstOrNull
                ?.contentFieldValue
                ?.data;
            final servicesCategoryId = data[index]
                .contentFields
                ?.where((content) => content.name == 'Numeric50450853')
                .firstOrNull
                ?.contentFieldValue
                ?.data;
            final servicesSubCategoryId = data[index]
                .contentFields
                ?.where((content) => content.name == 'Numeric98141434')
                .firstOrNull
                ?.contentFieldValue
                ?.data;
            final servicesType = data[index]
                .contentFields
                ?.where((content) => content.name == 'Numeric98141434')
                .firstOrNull
                ?.contentFieldValue
                ?.data;

            return InkWell(
              onTap: () {
                notifierDashboard.closeFloatMenu(
                  animationController: animationController,
                );
                notifier.onTapServices(
                  type: servicesText ?? '',
                  categoryId: servicesCategoryId,
                  subCategoryId: servicesSubCategoryId,
                );
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
                    child: CustomLottieWidget(
                      lottieUrl: serviceImage,
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Expanded(
                    child: Text(
                      servicesText ?? '',
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
      },
      error: (_, err) {
        return const SizedBox();
      },
      loading: () {
        return const ServicesLoader();
      },
    );
  }
}
