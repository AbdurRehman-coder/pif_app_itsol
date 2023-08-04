import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/ui/booking_details/widget/list_tile_widget.dart';
import 'package:pif_flutter/utils/colors.dart';

class GuestsList extends StatelessWidget {
  const GuestsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          itemCount: 2,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return const ListTileWidget(
              imageProfile: 'https://picsum.photos/80/80',
              userName: 'Khaled moh',
              userPosition: 'Product owner',
              isFromGuest: true,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                SizedBox(height: 8.h),
                const Divider(color: greyDivider),
                SizedBox(height: 8.h),
              ],
            );
          },
        ),
        Column(
          children: [
            SizedBox(height: 8.h),
            const Divider(color: greyDivider),
            SizedBox(height: 8.h),
          ],
        )
      ],
    );
  }
}
