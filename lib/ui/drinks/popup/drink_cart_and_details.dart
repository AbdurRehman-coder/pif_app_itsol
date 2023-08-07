import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/drinks/index.dart';
import 'package:pif_flutter/ui/drinks/widget/checkbox_cart_widget.dart';
import 'package:pif_flutter/ui/drinks/widget/drink_cart_tile.dart';

void showOrderCartAndDetails({
  required BuildContext context,
  DrinkModel? drinkModel,
}) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: grayF9,
    isScrollControlled: true,
    routeSettings: const RouteSettings(name: Routes.drinkDetailsScreen),
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
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: FractionallySizedBox(
                heightFactor: provider.lstCarts.length > 2 ? 0.92 : 0.7,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: InkWell(
                          onTap: AppRouter.pop,
                          child: Padding(
                            padding: EdgeInsets.only(top: 16.h),
                            child: Image.asset(
                              Assets.homeIndicator,
                              height: 5.h,
                              width: 60.w,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 30.h,
                            ),
                            if (provider.lstCarts.isNotEmpty) ...[
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (_, index) {
                                  return SizedBox(height: 20.h);
                                },
                                itemBuilder: (_, index) {
                                  return DrinkCartTile(
                                    notifier: notifier,
                                    item: provider.lstCarts[index],
                                  );
                                },
                                itemCount: provider.lstCarts.length,
                              ),
                            ] else ...[
                              DrinkCartTile(
                                notifier: notifier,
                                item: drinkModel,
                              ),
                            ],
                            SizedBox(height: 20.h),
                            CustomTextField(
                              textEditingController: notifier.notesController,
                              maxLines: 3,
                              hintText: S.current.notes,
                            ),
                            CustomCheckBoxWithText(
                              isChecked: provider.isSelectedPinOrder,
                              text: S.of(context).pinOrderQuickActions,
                              onChanged: (value) {
                                notifier.updatePinOrderQuickActions(
                                  value: value!,
                                );
                              },
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            FloatActionWidget(
                              provider: provider,
                              notifier: notifier,
                              drinkModel: drinkModel,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

class FloatActionWidget extends StatelessWidget {
  const FloatActionWidget({
    required this.provider,
    required this.notifier,
    required this.drinkModel,
    super.key,
  });

  final DrinksState provider;
  final DrinksNotifier notifier;
  final DrinkModel? drinkModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: pendingStatusColor,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
            onPressed: () {
              if (provider.lstCarts.isEmpty) {
                notifier.addItemToCart(
                  item: drinkModel!,
                  context: context,
                  withOrder: true,
                );
              } else {
                notifier.orderNow(context: context);
              }
            },
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
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              backgroundColor: whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: const BorderSide(
                  color: primaryColor,
                ),
              ),
            ),
            onPressed: () {
              if (provider.lstCarts.isEmpty) {
                notifier.addItemToCart(
                  item: drinkModel!,
                  context: context,
                );
              }
              AppRouter.pop();
            },
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
    );
  }
}
