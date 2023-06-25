import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/ui/book_scanner/index.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class BookScannerView extends ConsumerStatefulWidget {
  const BookScannerView({
    super.key,
  });

  @override
  ConsumerState createState() => _BookScannerViewState();
}

class _BookScannerViewState extends ConsumerState<BookScannerView> {
  final scrollController = ScrollController();
  final panelController = PanelController();
  late MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(bookingScannerProvider);
    final scanListNotifier = ref.read(scanBookingListProvider.notifier);
    return SlidingUpPanel(
      onPanelClosed: () {
        scanListNotifier.clearSearchData();
        FocusManager.instance.primaryFocus?.unfocus();
        controller.start();
      },
      onPanelOpened: controller.stop,
      panelBuilder: () => BookSearchWidget(
        scrollController: scrollController,
        panelController: panelController,
      ),
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: grayF5,
          automaticallyImplyLeading: false,
          centerTitle: false,
          titleSpacing: 0,
          elevation: 0,
          leading: IconButton(
            onPressed: AppRouter.pop,
            icon: SvgPicture.asset(
              Assets.back,
              height: 14.h,
            ),
          ),
          title: Text(
            S.current.spaceBooking,
            style: Style.commonTextStyle(
              color: blackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => {scanHelpBottomSheet(context: context)},
              icon: SvgPicture.asset(
                Assets.questionSquare,
                height: 26.h,
              ),
            )
          ], /**/
        ),
        body: Stack(
          children: [
            MobileScanner(
              controller: controller,
              onDetect: (capture) async {
                final barcodes = capture.barcodes;
                if (barcodes.isNotEmpty &&
                    barcodes.first.rawValue!.isNotEmpty &&
                    provider.isNumeric(barcodes.first.rawValue)) {
                  await controller.stop();
                  await provider.getBookingInformation(
                    roomId: barcodes[0].rawValue!.trim(),
                    context: context,
                  );
                  Future.delayed(const Duration(milliseconds: 100), () async {
                    await controller.start();
                  });
                } else {
                  controller.events?.pause();
                  errorMessage(
                    errorMessage: S.of(context).pleaseMakeSureYouAreScanningAValidRoomQRCode,
                    context: context,
                  );
                  Future.delayed(const Duration(milliseconds: 500), () {
                    controller.events?.resume();
                  });
                }
              },
            ),
            QRScannerOverlay(
              overlayColour: Colors.black.withOpacity(0.5),
            ),
            Positioned(
              bottom: 300.h,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Align(
                  child: Text(
                    S.of(context).alignQRCodeWithinFrameToScan,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      maxHeight: context.screenHeight * 0.9,
      backdropEnabled: true,
      backdropTapClosesPanel: false,
      controller: panelController,
      scrollController: scrollController,
      padding: EdgeInsets.zero,
      minHeight: 80.h,
      collapsed: BottomSheetButtonWidget(
        bottomText: S.of(context).troubleScanningQRCodeEnterManually,
        onTap: panelController.open,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
