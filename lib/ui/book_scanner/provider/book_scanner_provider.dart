import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/book_scanner/state/book_scanner_state.dart';
import 'package:pif_flutter/ui/book_scanner/widget/qrcode_wrong_message.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

final bookingScannerProvider =
StateNotifierProvider.autoDispose<BookingScannerNotifier, BookScannerState>(
        (ref) {
      return BookingScannerNotifier(ref: ref);
    });

class BookingScannerNotifier extends StateNotifier<BookScannerState> {
  BookingScannerNotifier({required this.ref})
      : super(BookScannerState.initial());

  final Ref ref;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  ScrollController scrollController = ScrollController();
  final panelController = PanelController();

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  void onScanQrCODE({
    required QRViewController controller,
    required BuildContext context,
  }) {
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null && isNumeric(scanData.code)) {

          controller.pauseCamera();
          getBookingInformation(
            roomId: scanData.code!,
            context: context,
            controller: controller,
          );

      } else {
        controller.pauseCamera();
        errorMessage(
          errorMessage:
          S.of(context).pleaseMakeSureYouAreScanningAValidRoomQRCode,
          context: context,
        );
        Future.delayed(const Duration(milliseconds: 200), () {
          controller.resumeCamera();
        });
      }
    });
  }

  Future<void> getBookingInformation({
    required String roomId,
    required BuildContext context,
    required QRViewController controller,
  }) async {
    final appProgressDialog = AppProgressDialog(context: context);
    await appProgressDialog.start();
    final result =
    await DixelsSDK.roomService.getRoomInformation(roomId: roomId);
    await appProgressDialog.stop();
    if (result.isRight()) {
      if (result.getRight()!.items!.isNotEmpty) {
        await AppRouter.pushNamed(
          Routes.bookingScreen,
          args: result.getRight()!.items![0],
        ).then(
              (value) => controller.resumeCamera(),
        );
      } else {
        errorMessage(
          errorMessage:
          S.of(context).pleaseMakeSureYouAreScanningAValidRoomQRCode,

          context: context,
        );
        await controller.resumeCamera();
      }
    } else {
      errorMessage(
        errorMessage: result.getLeft().message,
        context: context,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    ref.exists(bookingScannerProvider);
  }
}

