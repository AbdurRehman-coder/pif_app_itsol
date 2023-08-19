import 'package:dixels_sdk/features/commerce/booking/model/booking_model.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';

extension GetDateTimeByBookModel on BookingModel {
  String get formatLeftTimeByBookModel {
    final currentTime = DateTime.now();
    var date = bookedDates?.split(',').first;
    date = date!.replaceAll('[', '');
    date = date.replaceAll(']', '');
    date = date.replaceAll('"', '');
    final startDate = date.getDateTime;
    final dateTime = startDate.add(Duration(minutes: startTime!));

    final leftDuration = dateTime.difference(currentTime);
    final leftTimeString =
        '${leftDuration.inHours} h ${leftDuration.inMinutes} mins left';

    return leftTimeString;
  }

  DateTime get getStartDateByBookModel {
    var date = bookedDates?.split(',').first;
    date = date!.replaceAll('[', '');
    date = date.replaceAll(']', '');
    date = date.replaceAll('"', '');

    return date.getDateTime;
  }
}
