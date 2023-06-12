import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/drinks/index.dart';
import 'package:pif_flutter/ui/drinks/widget/darink_cart_tile.dart';
import 'package:pif_flutter/widgets/margin_widget.dart';

void showOrderDetails({
  required BuildContext context,
}) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: whiteColor,
    isScrollControlled: true,
    routeSettings: const RouteSettings(name: Routes.drinkDetailsScreen),
    constraints: BoxConstraints(maxHeight: context.screenHeight - 80.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    builder: (context) {
      return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final provider = ref.watch(drinksProvider);
          final notifier = ref.read(drinksProvider.notifier);
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(
                    child: InkWell(
                      onTap: AppRouter.pop,
                      child: SvgPicture.asset(
                        Assets.downArrow,
                        height: 13.h,
                      ),
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (_, index) {
                                return SizedBox(
                                  height: 16.h,
                                );
                              },
                              itemBuilder: (_, index) {
                                return DrinkCartTile(
                                  notifier: notifier,
                                  item: provider.lstCarts[index],
                                );
                              },
                              itemCount: provider.lstCarts.length,
                            ),
                            const MarginWidget(
                              horizontal: -16,
                              child: Divider(
                                color: grayD7,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            CustomTextField(
                              textEditingController: notifier.notesController,
                              maxLines: 3,
                              hintText: S.current.notes,
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                ),
                                onPressed: () => notifier.orderNow(context),
                                child: Text(
                                  S.of(context).orderNow,
                                  style: Style.commonTextStyle(
                                    color: whiteColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Align(
                              child: TextButton(
                                onPressed: AppRouter.pop,
                                child: Text(
                                  S.of(context).addMoreItems,
                                  style: Style.commonTextStyle(
                                    color: primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 18.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
