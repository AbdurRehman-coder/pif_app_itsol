import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/space_booking/index.dart';

class CapacityView extends StatelessWidget {
  const CapacityView({required this.provider, required this.notifier, super.key});

  final FilterByState provider;
  final FilterByNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.capacity,
            height: 22,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            S.of(context).capacity,
            style: Style.commonTextStyle(
              color: textColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: notifier.removeCapacity,
            child: SvgPicture.asset(
              Assets.minus,
              height: 33.h,
            ),
          ),
          Container(
            width: 55.w,
            alignment: Alignment.center,
            child: Text(
              provider.capacity.toString(),
              style: Style.commonTextStyle(
                color: hintColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          InkWell(
            onTap: notifier.addCapacity,
            child: SvgPicture.asset(
              Assets.plus,
              height: 33.h,
            ),
          ),
        ],
      ),
    );
  }
}
