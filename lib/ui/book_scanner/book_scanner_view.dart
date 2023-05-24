import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/book_scanner/popup/scan_help.dart';
import 'package:pif_flutter/ui/book_scanner/provider/book_scanner_provider.dart';
import 'package:pif_flutter/ui/book_scanner/widget/book_search_widget.dart';
import 'package:pif_flutter/ui/book_scanner/widget/bottom_sheet_button_widget.dart';
import 'package:pif_flutter/ui/book_scanner/widget/qr_scanner_overlay.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
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
    return Consumer(
      builder: (context, ref, child) {
        final notifier = ref.read(bookingScannerProvider.notifier);
        return SlidingUpPanel(
          panelBuilder: () => BookSearchWidget(
            scrollController: notifier.scrollController,
            panelController: notifier.panelController,
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
              ],
            ),
            body: Consumer(
              builder: (context, ref, child) {
                final notifier = ref.read(bookingScannerProvider.notifier);
                return Stack(
                  children: [
                    QRView(
                      onQRViewCreated: (controller) {
                        controller.scannedDataStream.listen(
                          (scanData) {
                            if (notifier.isNumeric(scanData.code)) {
                              controller.dispose();
                              AppRouter.pushNamed(Routes.bookingScreen).then(
                                (value) async {
                                  setState(() {});
                                },
                              );
                            } else {
                              controller.dispose();
                              errorMessage(
                                errorMessage: S.of(context).pleaseMakeSureYouAreScanningAValidRoomQRCode,
                                context: context,
                              );
                              controller.resumeCamera();
                              setState(() {});
                            }
                          },
                        );
                      },
                      key: notifier.qrKey,
                      // formatsAllowed: const [
                      //   BarcodeFormat.qrcode,
                      // ],
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
                );
              },
            ),
          ),
          maxHeight: MediaQuery.of(context).size.height * 0.9,
          backdropEnabled: true,
          backdropTapClosesPanel: false,
          controller: notifier.panelController,
          scrollController: notifier.scrollController,
          padding: EdgeInsets.zero,
          minHeight: 80.h,
          collapsed: BottomSheetButtonWidget(
            bottomText: S.of(context).troubleScanningQRCodeEnterManually,
            onTap: notifier.panelController.open,
          ),
        );
      },
    );
  }
}
