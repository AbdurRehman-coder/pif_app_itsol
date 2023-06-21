import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/helpers/filter_utils.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

final bookingScannerProvider = Provider.autoDispose<BookingScannerNotifier>((ref) {
  return BookingScannerNotifier(ref: ref);
});

class BookingScannerNotifier {
  BookingScannerNotifier({required this.ref});

  final Ref ref;
  late QRViewController qrViewController;

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
    qrViewController = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null && isNumeric(scanData.code)) {
        controller.pauseCamera();
        getBookingInformation(
          roomId: scanData.code!.trim(),
          context: context,
          controller: controller,
        );
      } else {
        controller.pauseCamera();
        errorMessage(
          errorMessage: S.of(context).pleaseMakeSureYouAreScanningAValidRoomQRCode,
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

    final param = ParametersModel();
    param.filter = FilterUtils.filterBy(
      key: 'id',
      value: "'$roomId'",
      operator: FilterOperator.equal.value,
    );
    final result = await DixelsSDK.roomService.getPageData(fromJson: RoomModel.fromJson, params: param);
    await appProgressDialog.stop();
    if (result != null && result.items!.isNotEmpty) {
      Future.delayed(Duration.zero, () async {
        await AppRouter.pushNamed(
          Routes.bookingScreen,
          args: [result.items![0], true],
        ).then(
          (value) => controller.resumeCamera(),
        );
      });
    } else {
      errorMessage(
        errorMessage: S.of(context).pleaseMakeSureYouAreScanningAValidRoomQRCode,
        context: context,
      );

      Future.delayed(const Duration(milliseconds: 200), () {
        controller.resumeCamera();
      });
    }
  }
}
