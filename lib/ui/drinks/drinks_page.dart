import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/widget_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/ui/drinks/index.dart';
import 'package:pif_flutter/ui/drinks/widget/drinks_bag_view.dart';
import 'package:pif_flutter/ui/drinks/widget/store_close_message.dart';

class DrinkPage extends ConsumerStatefulWidget {
  const DrinkPage({
    super.key,
  });

  @override
  ConsumerState createState() => _DrinkPageState();
}

class _DrinkPageState extends ConsumerState<DrinkPage> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(drinksProvider);
    final notifier = ref.read(drinksProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          NestedScrollView(
            physics: const NeverScrollableScrollPhysics(),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                const SliverToBoxAdapter(
                  child: StoreInformation(),
                ),
              ];
            },
            body: Column(
              children: [
                const StoreCloseMessage(),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomTextField(
                    fillColor: expireBgColor,
                    onChanged: notifier.searchData,
                    textEditingController: notifier.searchController,
                    hintText: S.of(context).search,
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
                    focusNode: notifier.searchFocusNode,
                  ),
                ),
                SizedBox(height: 10.h),
                Flexible(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 45.h,
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          itemCount: provider.lstCategory.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 12.w,
                            );
                          },
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () =>
                                  notifier.updateCategory(index: index),
                              child: CategoryListTile(
                                item: provider.lstCategory[index],
                                withOutSearch:
                                notifier.searchController.text.isEmpty,
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                      (notifier.searchController.text.isNotEmpty
                          ? provider.allDrinks
                          : provider.lstDrinks)
                          .when(
                        data: (data) {
                          if (data.isEmpty) {
                            return const DrinkEmptyView();
                          } else {
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 10.w,
                                  right: 10.w,
                                  bottom: provider.lstCarts.isNotEmpty
                                      ? 60.h
                                      : 10.h,
                                ),
                                child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(bottom: 50.h),
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return DrinkListTile(
                                      item: data[index],
                                      notifier: notifier,
                                      provider: provider,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 16.h,
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                        },
                        error: (e, s) {
                          return const SizedBox();
                        },
                        loading: () {
                          return const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        child: InkWell(
          onTap: () => notifier.drinkBagTap(context: context),
          child: DrinksBagView(
            provider: provider,
          ),
        ),
      ).visibility(
        visible: provider.lstCarts.isNotEmpty,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
