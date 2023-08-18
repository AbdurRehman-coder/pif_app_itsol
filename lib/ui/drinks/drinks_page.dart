import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/drinks/index.dart';
import 'package:pif_flutter/ui/drinks/widget/drink_page_shimmer.dart';
import 'package:pif_flutter/ui/drinks/widget/drinks_bag_view.dart';
import 'package:pif_flutter/ui/drinks/widget/store_close_message.dart';
import 'package:pif_flutter/ui/drinks/widget/user_location_widget.dart';

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
      body: (notifier.searchController.text.isNotEmpty
              ? provider.allDrinks
              : provider.lstDrinks)
          .when(
        data: (data) {
          if (data.isEmpty && notifier.searchController.text.isNotEmpty) {
            return const DrinkEmptyView();
          } else {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                NestedScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              if (notifier.searchController.text.isNotEmpty &&
                                  data.isNotEmpty) ...[
                                SizedBox(
                                  height: 1.h,
                                  width: double.infinity,
                                )
                              ] else ...[
                                Column(
                                  children: [
                                    UserLocationWidget(provider),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    const StoreInformation(),
                                    const StoreCloseMessage(),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        Flexible(
                          child: Column(
                            children: [
                              if (!(notifier.searchController.text.isNotEmpty &&
                                  data.isNotEmpty)) ...[
                                SizedBox(
                                  height: 50.h,
                                  child: ListView.separated(
                                    itemCount: provider.lstCategory.length,
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: 12.w,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () => notifier.updateCategory(
                                          index: index,
                                        ),
                                        child: CategoryListTile(
                                          item: provider.lstCategory[index],
                                          withOutSearch: notifier
                                              .searchController.text.isEmpty,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: provider.lstCarts.isNotEmpty
                                        ? 60.h
                                        : 10.h,
                                    top: 14.h,
                                  ),
                                  child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 18.w,
                                      mainAxisSpacing: 10.h,
                                      childAspectRatio: 0.7,
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
                              ),
                              if (provider.lstCarts.isNotEmpty)
                                SizedBox(
                                  height: 60.h,
                                )
                              else
                                const SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
        error: (e, s) {
          return Container();
        },
        loading: () {
          return const DrinkPageShimmerWidget();
        },
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
