import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';

class OrderStatusIcon extends StatelessWidget {
  const OrderStatusIcon({
    required this.orderStatusText,
    required this.orderStatusIcon,
    this.orderStatusSelected = false,
    super.key,
  });

  final String orderStatusText;
  final String orderStatusIcon;
  final bool orderStatusSelected;

  @override
  Widget build(BuildContext context) {
    if (orderStatusSelected) {
      return Column(
        children: [
          Image.asset(
            orderStatusIcon,
            width: 40.w,
            height: 40.h,
            color: primaryColor,
          ),
          SizedBox(height: 5.h),
          Text(
            orderStatusText,
            style: Style.commonTextStyle(
              color: primaryColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      );
    } else {
      return Image.asset(
        orderStatusIcon,
        width: 40.w,
        height: 40.h,
      );
    }
  }
}
