import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/book_scanner/index.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class BookScannerView extends ConsumerStatefulWidget {
  const BookScannerView({
    super.key,
  });

  @override
  ConsumerState createState() => _BookScannerViewState();
}

class _BookScannerViewState extends ConsumerState<BookScannerView> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(bookingScannerProvider);
    final scanListNotifier = ref.read(scanBookingListProvider.notifier);
    return SlidingUpPanel(
      onPanelClosed: () {
        scanListNotifier.clearSearchData();
        FocusManager.instance.primaryFocus?.unfocus();
        provider.qrViewController.resumeCamera();
      },
      onPanelOpened: () {
        provider.qrViewController.pauseCamera();
      },
      panelBuilder: () => BookSearchWidget(
        scrollController: provider.scrollController,
        panelController: provider.panelController,
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
            QRView(
              onQRViewCreated: (controller) =>
                  provider.onScanQrCODE(controller: controller, context: context),
              key: provider.qrKey,
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
      controller: provider.panelController,
      scrollController: provider.scrollController,
      padding: EdgeInsets.zero,
      minHeight: 80.h,
      collapsed: BottomSheetButtonWidget(
        bottomText: S.of(context).troubleScanningQRCodeEnterManually,
        onTap: provider.panelController.open,
      ),
    );
  }
}
