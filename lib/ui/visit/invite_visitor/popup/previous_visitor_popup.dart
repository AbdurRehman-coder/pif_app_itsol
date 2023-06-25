import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/ui/visit/invite_visitor/provider/previous_visitor_provider.dart';
import 'package:pif_flutter/ui/visit/invite_visitor/widget/previous_visitor_list_tile.dart';
import 'package:pif_flutter/widgets/margin_widget.dart';

Future<void> previousVisitorPopup({
  required BuildContext context,
}) async {
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

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 25.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      S.of(context).previousVisitors,
                      style: Style.commonTextStyle(
                        color: blackColor,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: AppRouter.pop,
                      icon: SvgPicture.asset(
                        Assets.cancelBtn,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                MarginWidget(
                  horizontal: -16,
                  child: Divider(
                    height: 1.h,
                    color: lineColor,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Text(
                  S.of(context).searchFromVisitorHistory,
                  style: Style.commonTextStyle(
                    color: textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                CustomTextField(
                  textEditingController: notifier.searchController,
                  labelText: S.current.searchVisitor,
                  focusNode: notifier.searchFocusNode,
                  onChanged: notifier.searchData,
                  suffixIcon: IconButton(
                    onPressed: notifier.clearSearch,
                    icon: SvgPicture.asset(
                      Assets.close,
                      height: 24.h,
                      colorFilter: const ColorFilter.mode(blackColor, BlendMode.srcIn),
                    ),
                  ).visibility(visible: provider.isVisibleCancel),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    itemCount: provider.lstData.length,
                    separatorBuilder: (_, index) {
                      return Divider(
                        height: 30.h,
                        thickness: 1.h,
                        color: lineColor,
                      );
                    },
                    itemBuilder: (_, index) {
                      return PreviousVisitorListTile(
                        item: provider.lstData[index],
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
}
