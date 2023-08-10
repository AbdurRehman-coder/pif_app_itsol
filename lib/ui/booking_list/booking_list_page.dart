import 'package:dixels_sdk/features/commerce/booking/model/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/background_widget.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/common/shared/widget/search_text_field.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/booking_list/provider/booking_list_provider.dart';
import 'package:pif_flutter/ui/booking_list/state/booking_list_state.dart';
import 'package:pif_flutter/ui/booking_list/widget/booking_list_shimmer_widget.dart';
import 'package:pif_flutter/ui/booking_list/widget/booking_list_tile.dart';
import 'package:pif_flutter/ui/space_booking/widget/space_booking_empty_view.dart';
import 'package:pif_flutter/ui/space_booking/widget/space_booking_shimmer_widget.dart';
import 'package:pif_flutter/widgets/debouncer.dart';

class BookingListPage extends ConsumerStatefulWidget {
  const BookingListPage({
    super.key,
  });

  @override
  ConsumerState createState() => _BookingListPageState();
}

class _BookingListPageState extends ConsumerState<BookingListPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      Duration.zero,
      () {
        ref.read(bookingListProvider.notifier).getStatus();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(bookingListProvider.notifier);
    final provider = ref.watch(bookingListProvider);
    final _debouncer = Debouncer(milliseconds: 500);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        titleWidget: SearchTextField(
          textEditingController: notifier.searchController,
          hintText: S.current.searchByBookingTitle,
          hintTextStyle: Style.commonTextStyle(
            color: hintColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          onChanged: (txt) {
            _debouncer.run(() {
              notifier.searchData(txt);
            });
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: FloatingActionButton(
          onPressed: () {
            AppRouter.pushNamed(Routes.spaceBookingScreen);
          },
          elevation: 0,
          child: Icon(
            Icons.add,
            size: 24.sp,
            color: whiteColor,
          ),
        ),
      ),
      body: BackgroundWidget(
        child: Column(
          children: [
            SizedBox(
              height: 43.h,
              child: provider.lstStatus.when(
                data: (data) {
                  if (data.isEmpty) {
                    return const SizedBox();
                  } else {
                    return ListView.separated(
                      itemCount: data.length,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            notifier.updateStatusList(model: data[index]);
                          },
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 24.w),
                              alignment: Alignment.center,
                              height: 38.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: data[index].isSelected! ? secondary : Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.10),
                                    blurRadius: 4.r,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                data[index].name ?? '',
                                style: Style.commonTextStyle(
                                  color: data[index].isSelected! ? Colors.white : darkBorderColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          width: 10.w,
                        );
                      },
                    );
                  }
                },
                error: (error, stackTrace) {
                  return const SizedBox();
                },
                loading: () {
                  return const BookingListShimmerWidget();
                },
              ).visibility(visible: notifier.searchController.text.isEmpty),
            ),
            SizedBox(
              height: 24.h,
            ),
            provider.lstData.when(
              data: (data) {
                if (data.isEmpty) {
                  return SpaceBookingEmptyView(
                    isFromEdit: true,
                  );
                } else {
                  return setListView(
                    data,
                    notifier,
                    provider,
                  );
                }
              },
              error: (e, s) {
                return SpaceBookingEmptyView(
                  isFromEdit: true,
                );
              },
              loading: () {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.w, left: 20.w),
                    child: const SpaceBookingShimmerWidget(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget setListView(List<BookingModel> data, BookingListNotifier notifier, BookingListState provider) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () {
          notifier.searchController.clear();

          return notifier.getBookings();
        },
        child: ListView.separated(
          controller: notifier.scrollController,
          padding: EdgeInsets.only(bottom: 60.h),
          itemBuilder: (context, index) {
            if (data.length == index) {
              return Center(
                child: SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
              ).visibility(visible: provider.isLoading);
            }
            return BookingListTile(data: data[index]);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 16.h,
            );
          },
          itemCount: data.length + 1,
        ),
      ),
    );
  }
}
