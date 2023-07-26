import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/drinks/index.dart';
import 'package:pif_flutter/ui/drinks/widget/drink_page_shimmer.dart';
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
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.circular(18.r), // 8 border radius
                            border: Border.all(
                              color: grayBorderColor,
                              width: 1.0, // Border width
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).deliveringTo,
                                    style: Style.commonTextStyle(
                                      color: grayTextColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    'Al-Multaqa 301',
                                    style: Style.commonTextStyle(
                                      color: blackColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SvgPicture.asset(Assets.locationPin),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        const StoreInformation(),
                        const StoreCloseMessage(),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SizedBox(height: 12.h),
                  Flexible(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45.h,
                          child: ListView.separated(
                            // padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                                    bottom: provider.lstCarts.isNotEmpty
                                        ? 60.h
                                        : 10.h,
                                  ),
                                  child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10.w,
                                      mainAxisSpacing: 16.h,
                                      childAspectRatio: 0.8,
                                    ),
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return DrinkListTile(
                                        item: data[index],
                                        notifier: notifier,
                                        provider: provider,
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
                              child: DrinkPageShimmerWidget(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
