import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/visit/visit_list/provider/visit_list_provider.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/visit_card.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/visit_status.dart';
import 'package:pif_flutter/ui/visit/visit_list/widget/visitor_empty_view.dart';

class VisitsListView extends ConsumerWidget {
  const VisitsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(visitListProvider);
    final notifier = ref.read(visitListProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: InkWell(
            onTap: AppRouter.pop,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.2),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: dayTextColor,
                size: 22,
              ),
            ),
          ),
        ),
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0,
        title: Text(
          S.of(context).visitsList,
          style: Style.commonTextStyle(
            color: blackColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            CustomTextField(
              fillColor: expireBgColor,
              textEditingController: notifier.searchVisitController,
              hintText: S.of(context).searchByVisitorName,
              style: Style.commonTextStyle(
                color: textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 11.w),
                child: SvgPicture.asset(
                  Assets.search,
                  height: 22.h,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            VisitStatus(
              notifier: notifier,
              provider: provider,
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: RefreshIndicator(
                onRefresh: notifier.getVisits,
                child: provider.allVisitsModel.value != null &&
                        provider.allVisitsModel.value!.isEmpty
                    ? const VisitorEmptyView()
                    : ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (_, index) {
                          final allVisit = provider.allVisitsModel.value;
                          return VisitCard(
                            notifier: notifier,
                            visitModel: allVisit?[index],
                          );
                        },
                        separatorBuilder: (_, index) {
                          return SizedBox(height: 16.h);
                        },
                        itemCount: provider.allVisitsModel.isLoading
                            ? 3
                            : provider.allVisitsModel.value!.length,
                      ).shimmerLoading(
                        loading: provider.allVisitsModel.isLoading,
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: () => AppRouter.pushNamed(Routes.inviteVisitorScreen),
        child: Container(
          width: 54.w,
          height: 54.h,
          padding: EdgeInsets.symmetric(
            vertical: 14.h,
            horizontal: 14.w,
          ),
          decoration: const BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            Assets.addIcon,
          ),
        ),
      ),
    );
  }
}
