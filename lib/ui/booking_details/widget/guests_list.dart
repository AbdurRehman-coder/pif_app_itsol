import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/ui/booking_details/widget/list_tile_widget.dart';
import 'package:pif_flutter/utils/colors.dart';

class GuestsList extends StatelessWidget {
  const GuestsList({required this.model, super.key});

  final List<UserModel> model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          itemCount: model.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return ListTileWidget(
              imageProfile: 'https://picsum.photos/80/80',
              userName: model[index].name ?? '',
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
