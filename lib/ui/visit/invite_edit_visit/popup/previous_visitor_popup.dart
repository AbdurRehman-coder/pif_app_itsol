import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/common/shared/widget/search_text_field.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/model/invite_edit_visit_model.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/provider/previous_visitor_provider.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/widget/previous_visitor_list_tile.dart';
import 'package:pif_flutter/widgets/margin_widget.dart';

Future<List<InviteVisitorModel>> previousVisitorPopup({
  required BuildContext context,
}) async {
  var previousVisitorSelected = <InviteVisitorModel>[];
  await showModalBottomSheet<dynamic>(
    backgroundColor: whiteColor,
    isScrollControlled: true,
    constraints: BoxConstraints(maxHeight: context.screenHeight - 170),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return Consumer(
        builder: (context, ref, child) {
          final provider = ref.watch(previousVisitorProvider);
          final notifier = ref.read(previousVisitorProvider.notifier);
          previousVisitorSelected = provider.previousVisitorList;
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    width: 100.w,
                    child: const Divider(
                      thickness: 4,
                      color: dividerColor,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  S.of(context).previousVisitors,
                  style: Style.commonTextStyle(
                    color: blackColor,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  S.of(context).searchFromVisitorHistory,
                  style: Style.commonTextStyle(
                    color: grayTextColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                SearchTextField(
                  textEditingController: notifier.searchController,
                  hintText: S.current.searchByVisitorName,
                  focusNode: notifier.searchFocusNode,
                  onChanged: notifier.searchData,
                  suffixIcon: IconButton(
                    onPressed: notifier.clearSearch,
                    icon: SvgPicture.asset(
                      Assets.icClose,
                      height: 24.h,
                      colorFilter:
                          const ColorFilter.mode(blackColor, BlendMode.srcIn),
                    ),
                  ).visibility(visible: provider.isVisibleCancel),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    itemCount: provider.previousVisitorList.length,
                    separatorBuilder: (_, index) {
                      return Divider(
                        height: 30.h,
                        thickness: 1.h,
                        color: lineColor,
                      );
                    },
                    itemBuilder: (_, index) {
                      return PreviousVisitorListTile(
                        item: provider.previousVisitorList[index],
                        notifier: notifier,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
  return previousVisitorSelected
      .where((element) => element.isSelected)
      .toList();
}
