import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/helpers/filter_utils.dart';
import 'package:pif_flutter/routes/routes.dart';

final bookingScannerProvider = Provider.autoDispose<BookingScannerNotifier>((ref) {
  return BookingScannerNotifier();
});

class BookingScannerNotifier {
  BookingScannerNotifier();

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Future<void> getBookingInformation({
    required String roomId,
    required BuildContext context,
    required bool isFromSpace,
  }) async {
    final appProgressDialog = AppProgressDialog(context: context);
    await appProgressDialog.start();

    var filterQuery = FilterUtils.filterBy(
      key: 'bookable',
      value: true.toString(),
      operator: FilterOperator.equal.value,
    );
    filterQuery = '$filterQuery and ${FilterUtils.filterBy(
      key: 'id',
      value: "'$roomId'",
      operator: FilterOperator.equal.value,
    )}';
    final param = ParametersModel();
    param.filter = filterQuery;
    final result = await DixelsSDK.instance.roomService.getPageData(fromJson: RoomModel.fromJson, params: param);
    await appProgressDialog.stop();
    if (result != null && result.items!.isNotEmpty) {
      await AppRouter.pushNamed(
        Routes.bookingScreen,
        args: [result.items![0], true, null, isFromSpace],
      );
    } else {
      alertMessage(
        errorMessage: S.of(context).pleaseMakeSureYouAreScanningAValidRoomQRCode,
        context: context,
      );
    }
  }
}
