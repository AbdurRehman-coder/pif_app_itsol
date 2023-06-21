import 'package:dixels_sdk/features/commerce/rooms/models/room_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/ui/space_booking/index.dart';
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
    final provider = ref.watch(spaceBookingProvider);
    return Column(
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            S.of(context).troubleScanningQRCodeEnterManually,
            style: Style.commonTextStyle(
              fontSize: 18.sp,
              color: blackColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: CustomTextField(
            textEditingController: notifier.searchController,
            labelText: S.of(context).roomName,
            suffixIcon: notifier.searchController.text.isNotEmpty
                ? IconButton(
                    onPressed: notifier.clearSearchBindData,
                    icon: const Icon(
                      Icons.close,
                      color: primaryColor,
                    ),
                  )
                : null,
            onChanged: notifier.searchData,
          ),
        ),
        SizedBox(height: 16.h),
        provider.lstData.when(
          data: (data) {
            if (data.isEmpty) {
              return const SpaceBookingEmptyView();
            } else {
              return setListView(data, notifier);
            }
          },
          error: (e, s) {
            return SizedBox(
              height: 10.h,
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }

  Widget setListView(List<RoomModel> data, SpaceBookingNotifier notifier) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        physics: PanelScrollPhysics(
          controller: widget.panelController,
        ),
        controller: widget.scrollController,
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 24.h, bottom: 80.h),
        itemBuilder: (context, index) {
          return SpaceBookingListTile(item: data[index]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 15.h,
          );
        },
        itemCount: data.length,
      ),
    );
  }
}
