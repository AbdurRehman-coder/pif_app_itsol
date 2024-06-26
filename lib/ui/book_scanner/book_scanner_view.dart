import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/common/shared/method/check_permission.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/book_scanner/index.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class BookScannerView extends ConsumerStatefulWidget {
  const BookScannerView({
    required this.isFromSpace,
    super.key,
  });

  final bool isFromSpace;

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
    CheckPermission.checkCameraPermission();
    controller = MobileScannerController();
    Future.delayed(Duration.zero, () {
      final notifier = ref.read(scanBookingListProvider.notifier);
      final isScanned = ref.read(scanBookingListProvider).isScanFirstTime;
      if (isScanned!) {
        scanHelpBottomSheet(context: context, notifier: notifier);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(bookingScannerProvider);
    final notifier = ref.read(scanBookingListProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: grayF5,
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleSpacing: 0,
        elevation: 0,
        leading: InkWell(
          onTap: AppRouter.pop,
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: activeBgColor,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: dayTextColor,
                size: 20,
              ),
            ),
          ),
        ),
        title: Text(
          S.current.scanQrToBook,
          style: Style.commonTextStyle(
            color: blackColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          InkWell(
            onTap: () =>
                scanHelpBottomSheet(context: context, notifier: notifier),
            child: Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Container(
                height: 40.h,
                width: 40.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: activeBgColor,
                ),
                child: const Icon(
                  Icons.question_mark,
                  color: dayTextColor,
                  size: 20,
                ),
              ),
            ),
          ),
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
                  isFromSpace: widget.isFromSpace,
                );
                Future.delayed(const Duration(milliseconds: 100), () async {
                  await controller.start();
                });
              } else {
                controller.events?.pause();
                alertMessage(
                  errorMessage: S
                      .of(context)
                      .pleaseMakeSureYouAreScanningAValidRoomQRCode,
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
        ],
      ),
      bottomNavigationBar: Container(
        height: 70.h,
        color: whiteColor,
        child: BottomSheetButtonWidget(
          onTap: () {
            AppRouter.pushReplacement(Routes.spaceBookingScreen);
          },
        ),
      ),
    );
  }
}
