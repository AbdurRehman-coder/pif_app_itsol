import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/booking_list/model/booking_list_model.dart';
import 'package:pif_flutter/ui/booking_list/provider/booking_list_provider.dart';
import 'package:pif_flutter/ui/booking_list/widget/booking_list_tile.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class BookingListPage extends ConsumerStatefulWidget {
  const BookingListPage({
    super.key,
  });

  @override
  ConsumerState createState() => _BookingListPageState();
}

class _BookingListPageState extends ConsumerState<BookingListPage> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(bookingListProvider.notifier);
    final provider = ref.watch(bookingListProvider);
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40.h,
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
                              style: Style.commonTextStyle(
                                color: textColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: Style.inputDecoration(
                                text: S.of(context).searchByBookingTitle,
                                hintColor: hintColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            SizedBox(
              height: 37.h,
              child: ListView.separated(
                itemCount: notifier.lstStatus.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      notifier.updateStatusList(index: index);
                    },
                    child: Container(
                      height: 37.h,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      decoration: BoxDecoration(
                        color: notifier.lstStatus[index].bgColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        notifier.lstStatus[index].name ?? '',
                        style: Style.commonTextStyle(
                          color: notifier.lstStatus[index].textColor,
                          fontSize: 14.sp,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 8.w,
                  );
                },
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            provider.lstData.when(
              data: setListView,
              error: (e, s) {
                return const SizedBox();
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.only(right: 20.w, bottom: 10.h),
          child: FloatingActionButton(
            heroTag: 'btn',
            elevation: 1,
            onPressed: () {
              AppRouter.pushNamed(Routes.spaceBookingScreen);
            },
            child: SvgPicture.asset(
              Assets.addIcon,
            ),
          ),
        )
      ],
    );
  }

  Widget setListView(List<BookingListModel> data) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: 60.h),
        itemBuilder: (context, index) {
          return BookingListTile(data: data[index]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 16.h,
          );
        },
        itemCount: data.length,
      ),
    );
  }
}
