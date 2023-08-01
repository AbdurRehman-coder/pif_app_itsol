import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/app_bar_with_search.dart';
import 'package:pif_flutter/common/shared/widget/search_text_field.dart';
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
      backgroundColor: expireBgColor,
      appBar: AppBarWithCustomTitle(
        title: SearchTextField(
          textEditingController: notifier.searchVisitController,
          onChanged: (value) {},
          hintText: S.of(context).searchVisitInvitation,
          hintTextStyle: Style.commonTextStyle(
            color: hintColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          fillColor: whiteColor,
          showBorders: false,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.emptySearchBgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: () => AppRouter.pushNamed(
          Routes.inviteVisitorScreen,
          args: false,
        ),
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
          child: const Icon(
            Icons.add,
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
