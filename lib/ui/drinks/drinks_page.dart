import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/widget_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/drinks/index.dart';
import 'package:pif_flutter/ui/drinks/widget/drinks_bag_view.dart';

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
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                const SliverAppBar(
                  expandedHeight: 150,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: StoreInformation(),
                ),
              ];
            },
            body: Column(
              children: [
                SizedBox(height: 16.h),
                Container(
                  height: 40.h,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      color: borderColor,
                      width: 1.w,
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.search,
                        height: 22.h,
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Expanded(
                        child: TextField(
                          controller: notifier.searchController,
                          onChanged: notifier.searchData,
                          focusNode: notifier.searchFocusNode,
                          style: Style.commonTextStyle(
                            color: textColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: Style.inputDecoration(
                            text: S.of(context).search,
                            hintColor: hintColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40.h,
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
                                onTap: () {
                                  notifier.updateCategory(index: index);
                                },
                                child: CategoryListTile(
                                  item: provider.lstCategory[index],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        provider.lstDrinks.when(
                          data: (data) {
                            if (data.isEmpty) {
                              return const DrinkEmptyView();
                            } else {
                              return Expanded(
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
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            child: InkWell(
              onTap: () {
                notifier.drinkBagTap(context: context);
              },
              child: DrinksBagView(
                provider: provider,
              ),
            ),
          ).visibility(visible: provider.lstCarts.isNotEmpty)
        ],
      ),
    );
  }
}
