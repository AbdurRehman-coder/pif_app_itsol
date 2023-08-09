import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/background_widget.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/common/shared/widget/search_text_field.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/booking_list/model/booking_list_model.dart';
import 'package:pif_flutter/ui/booking_list/provider/booking_list_provider.dart';
import 'package:pif_flutter/ui/booking_list/widget/booking_list_tile.dart';

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
          onChanged: notifier.searchData,
        ),
      ),
      body: BackgroundWidget(
        child: Column(
          children: [
            SizedBox(
              height: 43.h,
              child: ListView.separated(
                itemCount: notifier.lstStatus.length,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      notifier.updateStatusList(index: index);
                    },
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        alignment: Alignment.center,
                        height: 38.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: provider.lstStatus[index].isSelected!
                              ? secondary
                              : Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.10),
                              blurRadius: 4.r,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          provider.lstStatus[index].name ?? '',
                          style: Style.commonTextStyle(
                            color: provider.lstStatus[index].isSelected!
                                ? Colors.white
                                : darkBorderColor,
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
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn',
        elevation: 1,
        onPressed: () {
          AppRouter.pushNamed(Routes.spaceBookingScreen);
        },
        child: SvgPicture.asset(
          Assets.addIcon,
        ),
      ),
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
