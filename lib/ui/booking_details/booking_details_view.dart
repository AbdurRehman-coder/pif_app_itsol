import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/ui/booking_details/widget/room_details.dart';
import 'package:pif_flutter/ui/booking_list/model/booking_list_model.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({required this.data, super.key});

  final BookingListModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).bookingDetails,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Image.asset(
                Assets.hotelRoom,
              ),
            ),
            RoomDetails(
              item: data,
            ),
          ],
        ),
      ),
    );
  }
}
