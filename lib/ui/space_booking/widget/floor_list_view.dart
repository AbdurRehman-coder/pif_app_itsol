import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/space_booking/index.dart';

class FloorListView extends StatelessWidget {
  const FloorListView({required this.lstFloors, required this.notifier, super.key});

  final List<FloorModel> lstFloors;
  final FilterByNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: lstFloors.length,
        separatorBuilder: (context, index) {
          return SizedBox(
            width: 8.w,
          );
        },
        itemBuilder: (context, index) {
          final item = lstFloors[index];
          final borderColor = item.isSelected ?? false ? Colors.transparent : darkBorderColor;
          final bgColor = item.isSelected ?? false ? primaryColor : whiteColor;
          final textColor = item.isSelected ?? false ? whiteColor : darkBorderColor;
          return InkWell(
            onTap: () {
              notifier.updateFloorList(index: index);
            },
            child: Container(
              height: 40.h,
              margin: index == 0 ? EdgeInsets.only(left: 10.w) : EdgeInsets.only(left: 0.w),
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(
                  color: borderColor,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              alignment: Alignment.center,
              child: Text(
                lstFloors[index].name ?? '',
                style: Style.commonTextStyle(
                  color: textColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
