import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/ui/booking_details/widget/list_tile_widget.dart';
import 'package:pif_flutter/utils/colors.dart';

class GuestsList extends StatelessWidget {
  const GuestsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: 3,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return const ListTileWidget(
          imageProfile: 'https://picsum.photos/80/80',
          userName: 'Khaled moh (you)',
          userPosition: 'Product owner',
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            SizedBox(height: 10.h),
            const Divider(color: darkBorderColor),
            SizedBox(height: 10.h),
          ],
        );
      },
    );
  }
}
