import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/ui/book_scanner/state/book_scanner_state.dart';
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
  QRViewController? qrViewController;
  ScrollController scrollController = ScrollController();
  final panelController = PanelController();

  void onQRViewCreated({
    required QRViewController controller,
    required BuildContext context,
  }) {
    qrViewController = controller;
    controller.scannedDataStream.listen(
      (scanData) {
        if (scanData.format == BarcodeFormat.qrcode) {
          print('ScanDateScanData ${scanData.code}');
          // controller.dispose();
          // AppRouter.pushNamed(Routes.bookingScreen).then(
          //   (value) async {
          //     onQRViewCreated(controller: controller, context: context);
          //   },
          // );
        } else {
          errorMessage(
            errorMessage:
                S.of(context).pleaseMakeSureYouAreScanningAValidRoomQRCode,
            context: context,
          );
        }
      },
    );
  }

  Future<void> resumeCamera(QRViewController controller) async {
    await controller.resumeCamera();
  }

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  void dispose() {
    super.dispose();
    ref.exists(bookingScannerProvider);
  }
}
