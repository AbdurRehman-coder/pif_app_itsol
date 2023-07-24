import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';

class OrderStatusIcon extends StatelessWidget {
  const OrderStatusIcon({
    required this.orderStatusText,
    required this.orderStatusIcon,
    this.orderStatusSelected = false,
    this.isLastItem = false,
    super.key,
  });

  final String orderStatusText;
  final String orderStatusIcon;
  final bool orderStatusSelected;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Image.asset(
              orderStatusIcon,
              width: 32.w,
              height: 32.h,
              color: orderStatusSelected ? primaryColor : secondary,
            ),
            Text(
              orderStatusText,
              style: Style.commonTextStyle(
                color: orderStatusSelected ? primaryColor : secondary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        if (!isLastItem) ...[
          Container(
            height: 1.h,
             width: 24.w,
            color: expireStatusColor,
          ),

        ],
      ],
    );
  }
}
