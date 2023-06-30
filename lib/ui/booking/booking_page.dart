import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/booking/index.dart';

class BookingPage extends ConsumerStatefulWidget {
  const BookingPage({
    required this.spaceData,
    required this.isFromScan,
    super.key,
  });

  final RoomModel spaceData;
  final bool isFromScan;

  @override
  ConsumerState createState() => _BookingPageState();
}

class _BookingPageState extends ConsumerState<BookingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final notifier = ref.read(bookingProvider.notifier);
      notifier.getBookings(spaceData: widget.spaceData);
      if (widget.isFromScan) {
        bookingDetailsBottomSheet(context: context, spaceData: widget.spaceData);
        notifier.bindScanData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(bookingProvider);
    final notifier = ref.read(bookingProvider.notifier);
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: lightPrimaryColor,
        ),
        height: 80.h,
        child: InkWell(
          onTap: () {
            bookingDetailsBottomSheet(context: context, spaceData: widget.spaceData);
          },
          child: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              RotatedBox(
                quarterTurns: 2,
                child: SvgPicture.asset(
                  Assets.downArrow,
                  colorFilter: const ColorFilter.mode(borderColor, BlendMode.srcIn),
                  height: 13.h,
                ),
              ),
              SizedBox(
                height: 7.h,
              ),
              Text(
                S.of(context).editBooking,
                style: Style.commonTextStyle(
                  color: textColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SpaceInfoView(
            spaceData: widget.spaceData,
          ),
          BookingCalendarView(
            provider: provider,
            notifier: notifier,
          )
        ],
      ),
    );
  }
}
