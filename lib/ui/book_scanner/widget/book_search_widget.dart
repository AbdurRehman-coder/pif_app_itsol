import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/ui/book_scanner/widget/book_widget.dart';
import 'package:pif_flutter/ui/book_scanner/widget/custom_text_field.dart';
import 'package:pif_flutter/ui/space_booking/provider/space_booking_provider.dart';
import 'package:pif_flutter/ui/space_booking/space_booking_empty_view.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class BookSearchWidget extends ConsumerStatefulWidget {
  const BookSearchWidget({
    required this.scrollController,
    required this.panelController,
    super.key,
  });

  final ScrollController scrollController;
  final PanelController panelController;

  @override
  ConsumerState createState() => _BookSearchViewState();
}

class _BookSearchViewState extends ConsumerState<BookSearchWidget> {
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(spaceBookingProvider.notifier);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          InkWell(
            onTap: () => widget.panelController.close(),
            child: Column(
              children: [
                SizedBox(height: 51.h),
                Center(
                  child: SvgPicture.asset(
                    Assets.downArrow,
                    height: 13.h,
                  ),
                ),
                SizedBox(height: 23.h),
              ],
            ),
          ),
          Text(
            S.of(context).troubleScanningQRCodeEnterManually,
            style: Style.commonTextStyle(
              fontSize: 18.sp,
              color: blackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.h),
          CustomTextField(
            textEditingController: searchTextController,
            labelText: S.of(context).roomName,
            isSearch: searchTextController.text.isNotEmpty,
            onSearch: () {
              searchTextController.clear();
              setState(() {});
            },
            onChanged: (valSearch) {
              notifier.onSearch(
                paramSearch: valSearch,
              );
              setState(() {});
            },
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final provider = ref.watch(spaceBookingProvider);
                final booksList = searchTextController.text.isNotEmpty
                    ? provider.lstDataSearch.value!
                    : provider.lstData.value!;
                return ListView(
                  padding: EdgeInsets.zero,
                  physics: PanelScrollPhysics(
                    controller: widget.panelController,
                  ),
                  controller: widget.scrollController,
                  shrinkWrap: true,
                  children: [
                    if (booksList.isEmpty) ...[
                      const SpaceBookingEmptyView()
                    ] else ...[
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          return BookWidget(
                            spaceBookingModel: booksList[index],
                          );
                        },
                        separatorBuilder: (_, index) {
                          return SizedBox(height: 10.h);
                        },
                        itemCount: booksList.length,
                      ),
                    ],
                    SizedBox(height: 16.h),
                    Text(
                      S.of(context).notMatchingWhatYouAreLookingFor,
                      textAlign: TextAlign.center,
                      style: Style.commonTextStyle(
                        fontSize: 16.sp,
                        color: grayTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      S.of(context).advancedSearchAndFilters,
                      textAlign: TextAlign.center,
                      style: Style.commonTextStyle(
                        fontSize: 14.sp,
                        color: primaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
